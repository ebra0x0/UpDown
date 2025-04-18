import 'dart:async';
import 'dart:convert';

import 'package:UpDown/core/errors/failures.dart';
import 'package:UpDown/core/utils/secure_storage.dart';
import 'package:UpDown/core/utils/service_locator.dart';
import 'package:UpDown/features/root/create_issue/data/model/issue_model.dart';
import 'package:UpDown/features/root/home/data/model/building_model.dart';
import 'package:UpDown/features/root/home/data/model/building_summary_model.dart';
import 'package:UpDown/features/root/home/data/model/elevator_model.dart';
import 'package:UpDown/core/utils/model/user_model.dart';
import 'package:UpDown/features/auth/data/model/user_credentials_model.dart';
import 'package:UpDown/features/root/home/data/model/elevator_summary_model.dart';
import 'package:either_dart/either.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ApiService {
  ApiService(this._supabase);
  final SupabaseClient _supabase;

  // Auth Functions
  Future<Either<Failure, Session?>> signUp(UserCredentialsModel user) async {
    try {
      final AuthResponse res = await _supabase.auth.signUp(
        email: user.email,
        password: user.password,
      );

      return Right(res.session);
    } on AuthException catch (e) {
      return Left(SupabaseFailure.fromAuth(e));
    } catch (e) {
      return Left(CustomFailure("حدث خطاء اثناء التسجيل"));
    }
  }

  Future<Either<Failure, Session>> signInWithPassword(
      UserCredentialsModel user) async {
    try {
      final AuthResponse res = await _supabase.auth.signInWithPassword(
        email: user.email,
        password: user.password,
      );

      if (res.session == null) {
        return Left(CustomFailure("حدث خطاء اثناء تسجيل الدخول"));
      }

      return Right(res.session!);
    } on AuthException catch (e) {
      return Left(SupabaseFailure.fromAuth(e));
    } catch (e) {
      return Left(CustomFailure("حدث خطأ أثناء تسجيل الدخول"));
    }
  }

  Future<Either<Failure, void>> signOut() async {
    try {
      await _supabase.auth.signOut();
      return const Right(null);
    } on AuthException catch (e) {
      return Left(SupabaseFailure.fromAuth(e));
    } catch (e) {
      return Left(CustomFailure("حدث خطاء اثناء تسجيل الخروج"));
    }
  }

  Future<Either<Failure, Session?>> refreshToken({String? refreshToken}) async {
    try {
      if (_supabase.auth.currentSession == null) return const Right(null);
      final newSession = await _supabase.auth.refreshSession(refreshToken);

      return Right(newSession.session);
    } on AuthException catch (e) {
      return Left(SupabaseFailure.fromAuth(e));
    } catch (e) {
      return Left(CustomFailure("حدث خطاء اثناء تحديث الجلسة"));
    }
  }

  Future<Either<Failure, void>> sendConfirmationEmail(String email) async {
    try {
      if (email.isEmpty) {
        return Left(CustomFailure("يرجى إرفاق البريد الإلكتروني"));
      }

      await _supabase.auth.resend(type: OtpType.signup, email: email);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(SupabaseFailure.fromAuth(e));
    } catch (e) {
      return Left(CustomFailure("حدث خطاء اثناء إرسال رمز التفعيل"));
    }
  }

  Future<Either<Failure, void>> resetPassword({required String email}) async {
    try {
      if (email.isEmpty) {
        return Left(CustomFailure("يرجى إدخال البريد الإلكتروني"));
      }

      await _supabase.auth.resetPasswordForEmail(email);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(SupabaseFailure.fromAuth(e));
    } catch (e) {
      return Left(CustomFailure("حدث خطاء اثناء استعادة كلمة المرور"));
    }
  }

  Stream<Session?> get onAuthStateChanged =>
      _supabase.auth.onAuthStateChange.map((data) => data.session);

  // User Functions
  Future<Either<Failure, void>> createUserData(UserModel user) async {
    try {
      await _supabase.from('Users').insert(user.toJson());
      return const Right(null);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } catch (e) {
      return Left(CustomFailure("حدث خطاء اثناء استعادة كلمة المرور"));
    }
  }

  Future<Either<Failure, UserModel>> getUserData({required User user}) async {
    try {
      final Map<String, dynamic>? response = await _supabase
          .rpc("get_user_assets", params: {"u_id": user.id}).maybeSingle();

      if (response == null || response.isEmpty) {
        return Left(CustomFailure("بيانات المستخدم غير موجودة"));
      }

      final UserModel userData = UserModel.fromJson({
        ...response,
        "buildings": response["buildings"],
        "elevators": response["elevators"]
      });

      gitIt.get<SecureStorage>().addAll({
        "user_data": jsonEncode({
          ...response,
          "buildings": response["buildings"],
          "elevators": response["elevators"]
        }),
      });
      return Right(userData);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } catch (e) {
      return Left(CustomFailure("حدث خطاء اثناء جلب بيانات المستخدم"));
    }
  }

  // App Endpoints

  // Buildings
  Future<Either<Failure, List<BuildingSummaryModel>>>
      fetchBuildingsSummary() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        return Left(CustomFailure("يرجى تسجيل الدخول"));
      }

      final String userId = user.id;

      final List<dynamic>? response = await _supabase
          .rpc("get_user_buildings_summary", params: {"user_id": userId});

      if (response == null || response.isEmpty) {
        return Left(CustomFailure("لا يوجد أبنية مسجلة للمستخدم"));
      }

      final List<BuildingSummaryModel> buildings =
          response.map((b) => BuildingSummaryModel.fromJson(b)).toList();

      return Right(buildings);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } catch (e) {
      return Left(CustomFailure("حدث خطاء اثناء جلب بيانات الأبنية"));
    }
  }

  Future<Either<Failure, BuildingModel>> fetchBuildingDetails(
      {required String buildingId}) async {
    try {
      final Map<String, dynamic>? response = await _supabase.rpc(
          'get_building_by_id',
          params: {"b_id": buildingId}).maybeSingle();

      if (response == null || response.isEmpty) {
        return Left(CustomFailure("المبنى غير موجود"));
      }

      return Right(BuildingModel.fromJson(response));
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } catch (e) {
      return Left(CustomFailure("حدث خطاء اثناء جلب بيانات المبنى"));
    }
  }

  // Elevators
  Future<Either<Failure, List<ElevatorSummaryModel>>> fetchElevatorsSummary(
      {required String buildingId}) async {
    try {
      final List<Map<String, dynamic>>? response = await _supabase.rpc(
        "get_building_elevators_summary",
        params: {"b_id": buildingId},
      );

      if (response == null || response.isEmpty) {
        return Left(CustomFailure("لا يوجد مصاعد مسجلة للمبنى"));
      }

      final List<ElevatorSummaryModel> elevators = response.map((e) {
        return ElevatorSummaryModel.fromJson(e);
      }).toList();

      return Right(elevators);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } catch (e) {
      return Left(CustomFailure("حدث خطاء اثناء جلب بيانات المصاعد"));
    }
  }

  Future<Either<Failure, ElevatorModel>> fetchElevatorDetails(
      {required String elevatorId}) async {
    try {
      final Map<String, dynamic>? response = await _supabase.rpc(
          "get_elevator_by_id",
          params: {"e_id": elevatorId}).maybeSingle();

      if (response == null || response.isEmpty) {
        return Left(CustomFailure("المصعد غير موجود"));
      }

      return Right(ElevatorModel.fromJson(response));
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } catch (e) {
      return Left(CustomFailure("حدث خطاء اثناء جلب بيانات المصعد"));
    }
  }

  Future<Either<Failure, String>> createReport(
      {required String buildingId}) async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        return Left(CustomFailure("يجب تسجيل الدخول لإنشاء تقرير"));
      }

      final Map<String, dynamic> reportData = {
        "reported_by": user.id,
        "building_id": buildingId,
      };

      final Map<String, dynamic>? report = await _supabase.rpc(
          "create_and_get_report",
          params: {"report_data": reportData}).maybeSingle();

      if (report == null || report.isEmpty) {
        return Left(CustomFailure("لم يتم إنشاء التقرير"));
      }

      return Right(report["report_id"]);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } catch (e) {
      return Left(CustomFailure("حدث خطاء اثناءإنشاء التقرير"));
    }
  }

  Future<Either<Failure, void>> createIssue(IssueModel issueModel) async {
    try {
      if (issueModel.buildingId == null) {
        return Left(CustomFailure("يجب تحديد المبنى"));
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
      return Left(CustomFailure("حدث خطاء اثناءإنشاء المشكلة"));
    }
  }

  Future<Either<Failure, List<IssueModel>>> fetchActiveIssues() async {
    try {
      final List<Map<String, dynamic>> response =
          await _supabase.from("active_issues").select();

      if (response.isEmpty) {
        return Left(CustomFailure("لا يوجد أعطال نشطة"));
      }

      final List<IssueModel> issues = response.map((e) {
        return IssueModel.fromJson(e);
      }).toList();

      return Right(issues);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } catch (e) {
      return Left(CustomFailure("حدث حطأ اثناء جلب بيانات الأعطال النشطة"));
    }
  }
}
