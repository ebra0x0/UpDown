import 'package:UpDown/core/errors/failures.dart';
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

abstract class ApiService {
  static final supabase = Supabase.instance.client;

  // Auth Functions
  static Future<Either<String, void>> signUp(AuthUserModel user) async {
    try {
      if (user.email.isEmpty || user.password.isEmpty) {
        return Left("يرجى إدخال البريد الإلكتروني وكلمة المرور");
      }

      final response = await supabase.auth.signUp(
        email: user.email,
        password: user.password,
      );

      final userId = response.user?.id;
      if (userId == null) {
        return Left("حدث خطأ أثناء إنشاء الحساب");
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
      return Left(
          SupabaseFailure(e.toString()).handleSupabaseError(e.code ?? ""));
    } catch (e) {
      return Left("حدث خطأ أثناء إنشاء الحساب: ${e.toString()}");
    }
  }

  static Future<Either<String, void>> signInWithPassword(
      AuthUserModel user) async {
    try {
      if (user.email.isEmpty || user.password.isEmpty) {
        return Left("يرجى إدخال البريد الإلكتروني وكلمة المرور");
      }

      await supabase.auth.signInWithPassword(
        email: user.email,
        password: user.password,
      );

      return const Right(null);
    } on AuthException catch (e) {
      return Left(
          SupabaseFailure(e.toString()).handleSupabaseError(e.code ?? ""));
    } catch (e) {
      return Left("حدث خطأ أثناء تسجيل الدخول: ${e.toString()}");
    }
  }

  static Future<Either<String, void>> signOut() async {
    try {
      await supabase.auth.signOut();
      return const Right(null);
    } on AuthException catch (e) {
      return Left(
          SupabaseFailure(e.toString()).handleSupabaseError(e.code ?? ""));
    } catch (e) {
      return Left("حدث خطأ أثناء تسجيل الخروج: ${e.toString()}");
    }
  }

  static Future<Either<String, void>> resetPassword(
      {required String email}) async {
    try {
      if (email.isEmpty) {
        return Left("يرجى إدخال البريد الإلكتروني");
      }

      await supabase.auth.resetPasswordForEmail(email);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(
          SupabaseFailure(e.toString()).handleSupabaseError(e.code ?? ""));
    } catch (e) {
      return Left("حدث خطأ أثناء إعادة تعيين كلمة المرور: ${e.toString()}");
    }
  }

  // User Functions
  static Future<Either<String, void>> createUserData(
      Map<String, dynamic> user) async {
    try {
      if (!user.containsKey("user_id")) {
        return Left("يجب أن تحتوي بيانات المستخدم على معرف المستخدم ");
      }

      await supabase.from('Users').insert(user);
      return const Right(null);
    } on PostgrestException catch (e) {
      return Left(
          SupabaseFailure(e.toString()).handleSupabaseError(e.code ?? ""));
    } catch (e) {
      return Left("حدث خطأ أثناء إنشاء بيانات المستخدم: ${e.toString()}");
    }
  }

  static Future<Either<String, UserModel>> getUserData(
      {required User user}) async {
    try {
      final Map<String, dynamic>? response = await supabase
          .rpc("get_user_assets", params: {"u_id": user.id}).maybeSingle();

      if (response == null || response.isEmpty) {
        return Left("بيانات المستخدم غير موجودة");
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
      return Left(
          SupabaseFailure(e.toString()).handleSupabaseError(e.code ?? ""));
    } catch (e) {
      return Left("حدث خطأ أثناء جلب بيانات المستخدم: ${e.toString()}");
    }
  }

  // App Functions
  static Future<Either<String, List<BuildingSummaryModel>>>
      fetchBuildingsSummary() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        return Left("لم يتم تسجيل الدخول");
      }

      final String userId = user.id;

      final List<Map<String, dynamic>> response = await supabase
              .rpc("get_user_buildings_summary", params: {"user_id": userId}) ??
          [];

      if (response.isEmpty) {
        return Left("لا يوجد أبنية مسجلة للمستخدم");
      }

      final List<BuildingSummaryModel> buildings =
          response.map((b) => BuildingSummaryModel.fromJson(b)).toList();

      return Right(buildings);
    } on PostgrestException catch (e) {
      return Left(
          SupabaseFailure(e.toString()).handleSupabaseError(e.code ?? ""));
    } catch (e) {
      return Left("حدث خطأ أثناء جلب بيانات الأبنية: ${e.toString()}");
    }
  }

  static Future<Either<String, BuildingModel>> fetchBuildingDetails(
      {required String buildingId}) async {
    try {
      final Map<String, dynamic>? response = await supabase.rpc(
          'get_building_by_id',
          params: {"b_id": buildingId}).maybeSingle();

      if (response == null || response.isEmpty) {
        return Left("المبنى غير موجود");
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
      return Left(
          SupabaseFailure(e.toString()).handleSupabaseError(e.code ?? ""));
    } catch (e) {
      return Left("حدث خطأ أثناء جلب بيانات المبنى: ${e.toString()}");
    }
  }

  static Future<Either<String, List<ElevatorSummaryModel>>>
      fetchElevatorsSummary({required String buildingId}) async {
    try {
      final List<Map<String, dynamic>> response = await supabase.rpc(
            "get_building_elevators_summary",
            params: {"b_id": buildingId},
          ) ??
          [];

      if (response.isEmpty) {
        return Left("لا توجد مصاعد مسجلة في هذا المبنى");
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
      return Left(
          SupabaseFailure(e.toString()).handleSupabaseError(e.code ?? ""));
    } catch (e) {
      return Left("حدث خطأ أثناء جلب بيانات المصاعد: ${e.toString()}");
    }
  }

  static Future<Either<String, ElevatorModel>> fetchElevatorDetails(
      {required String elevatorId}) async {
    try {
      final Map<String, dynamic>? response = await supabase.rpc(
          "get_elevator_by_id",
          params: {"e_id": elevatorId}).maybeSingle();

      if (response == null || response.isEmpty) {
        return Left("المصعد غير موجود");
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
      return Left(
          SupabaseFailure(e.toString()).handleSupabaseError(e.code ?? ""));
    } catch (e) {
      return Left("حدث خطأ أثناء جلب بيانات المصعد: ${e.toString()}");
    }
  }

  static Future<Either<String, String>> createReport(
      {required String buildingId}) async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        return Left("يجب تسجيل الدخول لإنشاء تقرير");
      }

      final Map<String, dynamic> reportData = {
        "reported_by": user.id,
        "building_id": buildingId,
      };

      final Map<String, dynamic>? report = await supabase.rpc(
          "create_and_get_report",
          params: {"report_data": reportData}).maybeSingle();

      if (report == null || report.isEmpty) {
        return Left("لم يتم إنشاء التقرير");
      }

      return Right(report["report_id"]);
    } on PostgrestException catch (e) {
      return Left(
          SupabaseFailure(e.toString()).handleSupabaseError(e.code ?? ""));
    } catch (e) {
      return Left("حدث خطأ أثناء إنشاء التقرير: ${e.toString()}");
    }
  }

  static Future<Either<String, void>> createIssue(IssueModel issueModel) async {
    try {
      if (issueModel.buildingId == null) {
        return Left("يجب تحديد المبنى");
      }

      final reportId = await createReport(buildingId: issueModel.buildingId!);

      reportId.fold(
        (errMsg) {
          Left(errMsg);
          return;
        },
        (reportId) => reportId,
      );

      await supabase
          .from('Issues')
          .insert(issueModel.copyWith(reportId: reportId.right).toJson());

      return const Right(null);
    } on PostgrestException catch (e) {
      return Left(
          SupabaseFailure(e.toString()).handleSupabaseError(e.code ?? ""));
    } catch (e) {
      return Left("حدث خطأ أثناء إنشاء المشكلة: ${e.toString()}");
    }
  }
}
