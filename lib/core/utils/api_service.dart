import 'dart:async';

import 'package:UpDown/core/errors/failures.dart';
import 'package:UpDown/core/utils/secure_storage.dart';
import 'package:UpDown/core/utils/service_locator.dart';
import 'package:UpDown/features/root/create_issue/data/model/issue_model.dart';
import 'package:UpDown/features/root/home/data/model/building_model.dart';
import 'package:UpDown/features/root/home/data/model/building_summary_model.dart';
import 'package:UpDown/features/root/home/data/model/elevator_model.dart';
import 'package:UpDown/core/utils/model/user_model.dart';
import 'package:UpDown/features/auth/data/model/auth_user_model.dart';
import 'package:UpDown/features/root/create_issue/data/model/report_model.dart';
import 'package:UpDown/features/root/home/data/model/elevator_summary_model.dart';
import 'package:UpDown/features/root/home/data/model/floor_model.dart';
import 'package:either_dart/either.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ApiService {
  ApiService(this._supabase);
  final SupabaseClient _supabase;

  final StreamController<Session?> _authStateController =
      StreamController<Session?>.broadcast();

  Stream<Session?> get onAuthStateChange => _authStateController.stream;

  // Auth Functions
  Future<Either<Failure, void>> signUp(AuthUserModel user) async {
    try {
      if (user.email.isEmpty || user.password.isEmpty) {
        return Left(
            CustomException("يرجى إدخال البريد الإلكتروني وكلمة المرور"));
      }

      final response = await _supabase.auth.signUp(
        email: user.email,
        password: user.password,
      );

      final userId = response.user?.id;
      if (userId == null) {
        return Left(CustomException("حدث خطأ أثناء إنشاء الحساب"));
      }

      final Map<String, dynamic> newUser = {
        "user_id": userId,
        "name": "Ibrahim",
        "email": response.user?.email,
        "phone": "01205262745"
      };

      await createUserData(newUser);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(SupabaseFailure.fromAuth(e));
    } catch (e) {
      return Left(CustomException("حدث خطأ أثناء إنشاء الحساب"));
    }
  }

  Future<Either<Failure, void>> signInWithPassword(AuthUserModel user) async {
    try {
      if (user.email.isEmpty || user.password.isEmpty) {
        return Left(
            CustomException("يرجى إدخال البريد الإلكتروني وكلمة المرور"));
      }

      await _supabase.auth
          .signInWithPassword(
            email: user.email,
            password: user.password,
          )
          .then((res) => gitIt
              .get<SecureStorage>()
              .add("refresh_token", res.session!.refreshToken!));

      return const Right(null);
    } on AuthException catch (e) {
      return Left(SupabaseFailure.fromAuth(e));
    } catch (e) {
      return Left(CustomException("حدث خطأ أثناء تسجيل الدخول"));
    }
  }

  Future<Either<Failure, void>> signOut() async {
    try {
      await _supabase.auth.signOut();
      return const Right(null);
    } on AuthException catch (e) {
      return Left(SupabaseFailure.fromAuth(e));
    } catch (e) {
      return Left(CustomException("حدث خطاء اثناء تسجيل الخروج"));
    }
  }

  Future<Either<Failure, Session?>> refreshToken(String refreshToken) async {
    try {
      final newSession = await _supabase.auth.refreshSession(refreshToken);

      return Right(newSession.session);
    } on AuthException catch (e) {
      return Left(SupabaseFailure.fromAuth(e));
    } catch (e) {
      return Left(CustomException("حدث خطاء اثناء تحديث الجلسة"));
    }
  }

  Future<Either<Failure, void>> resetPassword({required String email}) async {
    try {
      if (email.isEmpty) {
        return Left(CustomException("يرجى إدخال البريد الإلكتروني"));
      }

      await _supabase.auth.resetPasswordForEmail(email);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(SupabaseFailure.fromAuth(e));
    } catch (e) {
      return Left(CustomException("حدث خطاء اثناء استعادة كلمة المرور"));
    }
  }

  void sessionMonitor() => _supabase.auth.onAuthStateChange.listen((event) {
        final session = event.session;
        final isLoggedIn = session != null;

        _authStateController.add(isLoggedIn ? session : null);
      });
  // User Functions
  Future<Either<Failure, void>> createUserData(
      Map<String, dynamic> user) async {
    try {
      if (!user.containsKey("user_id")) {
        return Left(CustomException("يبدو أن المستخدم غير مسجل"));
      }

      await _supabase.from('Users').insert(user);
      return const Right(null);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } catch (e) {
      return Left(CustomException("حدث خطاء اثناء استعادة كلمة المرور"));
    }
  }

  Future<Either<Failure, UserModel>> getUserData({required User user}) async {
    try {
      final Map<String, dynamic>? response = await _supabase
          .rpc("get_user_assets", params: {"u_id": user.id}).maybeSingle();

      if (response == null || response.isEmpty) {
        return Left(CustomException("بيانات المستخدم غير موجودة"));
      }

      List<BuildingSummaryModel> buildings =
          (response["buildings"] as List<dynamic>?)
                  ?.map((b) =>
                      BuildingSummaryModel.fromJson(b as Map<String, dynamic>))
                  .toList() ??
              [];

      List<ElevatorSummaryModel> elevators =
          (response["elevators"] as List<dynamic>?)
                  ?.map((e) =>
                      ElevatorSummaryModel.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [];

      return Right(UserModel.fromJson(
          {...response, "buildings": buildings, "elevators": elevators}));
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } catch (e) {
      return Left(CustomException("حدث خطاء اثناء جلب بيانات المستخدم"));
    }
  }

  // App Functions
  Future<Either<Failure, List<BuildingSummaryModel>>>
      fetchBuildingsSummary() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        return Left(CustomException("يرجى تسجيل الدخول"));
      }

      final String userId = user.id;

      final List<dynamic>? response = await _supabase
          .rpc("get_user_buildings_summary", params: {"user_id": userId});

      if (response == null || response.isEmpty) {
        return Left(CustomException("لا يوجد أبنية مسجلة للمستخدم"));
      }

      final List<BuildingSummaryModel> buildings =
          response.map((b) => BuildingSummaryModel.fromJson(b)).toList();

      return Right(buildings);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } catch (e) {
      return Left(CustomException("حدث خطاء اثناء جلب بيانات الأبنية"));
    }
  }

  Future<Either<Failure, BuildingModel>> fetchBuildingDetails(
      {required String buildingId}) async {
    try {
      final Map<String, dynamic>? response = await _supabase.rpc(
          'get_building_by_id',
          params: {"b_id": buildingId}).maybeSingle();

      if (response == null || response.isEmpty) {
        return Left(CustomException("المبنى غير موجود"));
      }

      List<ElevatorSummaryModel> elevators =
          (response["elevators"] as List<dynamic>?)
                  ?.map((e) => ElevatorSummaryModel.fromJson({
                        ...e as Map<String, dynamic>,
                        "issue_type":
                            (e["active_issue"] is Map<String, dynamic>)
                                ? e["active_issue"]["issue_type"]
                                : null
                      }))
                  .toList() ??
              [];

      List<ReportModel> reports = (response["reports"] as List<dynamic>?)
              ?.map((r) => ReportModel.fromJson(r as Map<String, dynamic>))
              .toList() ??
          [];

      List<FloorModel> floors = (response["floors"] as List<dynamic>?)
              ?.map((f) => FloorModel.fromJson(f as Map<String, dynamic>))
              .toList() ??
          [];

      List<FloorModel> closedFloors =
          (response["closed_floors"] as List<dynamic>?)
                  ?.map((cf) => FloorModel.fromJson(cf as Map<String, dynamic>))
                  .toList() ??
              [];

      ReportModel? activeReport =
          (response["active_report"] is Map<String, dynamic>)
              ? ReportModel.fromJson(response["active_report"])
              : null;

      return Right(BuildingModel.fromJson({
        ...response,
        "elevators": elevators,
        "reports": reports,
        "floors": floors,
        "closed_floors": closedFloors,
        "active_report": activeReport
      }));
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } catch (e) {
      return Left(CustomException("حدث خطاء اثناء جلب بيانات المبنى"));
    }
  }

  Future<Either<Failure, List<ElevatorSummaryModel>>> fetchElevatorsSummary(
      {required String buildingId}) async {
    try {
      final List<Map<String, dynamic>>? response = await _supabase.rpc(
        "get_building_elevators_summary",
        params: {"b_id": buildingId},
      );

      if (response == null || response.isEmpty) {
        return Left(CustomException("لا يوجد مصاعد مسجلة للمبنى"));
      }

      final List<ElevatorSummaryModel> elevators = response.map((e) {
        final issueData = e["active_issue"];
        final String? issueType = (issueData is Map<String, dynamic>)
            ? issueData["issue_type"] as String?
            : null;

        return ElevatorSummaryModel.fromJson({
          ...e,
          "issue_type": issueType,
        });
      }).toList();

      return Right(elevators);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } catch (e) {
      return Left(CustomException("حدث خطاء اثناء جلب بيانات المصاعد"));
    }
  }

  Future<Either<Failure, ElevatorModel>> fetchElevatorDetails(
      {required String elevatorId}) async {
    try {
      final Map<String, dynamic>? response = await _supabase.rpc(
          "get_elevator_by_id",
          params: {"e_id": elevatorId}).maybeSingle();

      if (response == null || response.isEmpty) {
        return Left(CustomException("المصعد غير موجود"));
      }

      final List<IssueModel> issues = (response["issues"] as List<dynamic>?)
              ?.map((i) => IssueModel.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [];

      final IssueModel? activeIssue =
          (response["active_issue"] is Map<String, dynamic>)
              ? IssueModel.fromJson(response["active_issue"])
              : null;

      return Right(ElevatorModel.fromJson(
          {...response, "issues": issues, "active_issue": activeIssue}));
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } catch (e) {
      return Left(CustomException("حدث خطاء اثناء جلب بيانات المصعد"));
    }
  }

  Future<Either<Failure, String>> createReport(
      {required String buildingId}) async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        return Left(CustomException("يجب تسجيل الدخول لإنشاء تقرير"));
      }

      final Map<String, dynamic> reportData = {
        "reported_by": user.id,
        "building_id": buildingId,
      };

      final Map<String, dynamic>? report = await _supabase.rpc(
          "create_and_get_report",
          params: {"report_data": reportData}).maybeSingle();

      if (report == null || report.isEmpty) {
        return Left(CustomException("لم يتم إنشاء التقرير"));
      }

      return Right(report["report_id"]);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } catch (e) {
      return Left(CustomException("حدث خطاء اثناءإنشاء التقرير"));
    }
  }

  Future<Either<Failure, void>> createIssue(IssueModel issueModel) async {
    try {
      if (issueModel.buildingId == null) {
        return Left(CustomException("يجب تحديد المبنى"));
      }

      final reportId = await createReport(buildingId: issueModel.buildingId!);

      reportId.fold(
        (errMsg) {
          Left(errMsg);
          return;
        },
        (reportId) => reportId,
      );

      await _supabase
          .from('Issues')
          .insert(issueModel.copyWith(reportId: reportId.right).toJson());

      return const Right(null);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } catch (e) {
      return Left(CustomException("حدث خطاء اثناءإنشاء المشكلة"));
    }
  }
}
