import 'package:UpDown/core/utils/function/auth_exceptions_handler.dart';
import 'package:UpDown/features/root/create_issue/data/model/issue_model.dart';
import 'package:UpDown/features/root/home/data/model/building_model.dart';
import 'package:UpDown/features/root/home/data/model/building_summary_model.dart';
import 'package:UpDown/features/root/home/data/model/elevator_model.dart';
import 'package:UpDown/core/utils/model/user_model.dart';
import 'package:UpDown/features/auth/data/model/auth_user_model.dart';
import 'package:UpDown/features/root/create_issue/data/model/report_model.dart';
import 'package:UpDown/features/root/home/data/model/elevator_summary_model.dart';
import 'package:UpDown/features/root/home/data/model/floor_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ApiService {
  static final supabase = Supabase.instance.client;

  // Auth Functions
  static Future<void> signUp(AuthUserModel user) async {
    try {
      await supabase.auth
          .signUp(
        email: user.email,
        password: user.password,
      )
          .then((value) async {
        String? userId = value.user?.id;

        if (userId == null) return;
        Map<String, dynamic> newUser = {
          "user_id": userId,
          "name": "Ibrahim",
          "email": value.user?.email,
          "phone": "01205262745"
        };
        await createUserData(newUser);
      });
    } on AuthException catch (e) {
      authExceptionsHandler(e);
    }
  }

  static Future<void> signInWithPassword(AuthUserModel user) async {
    try {
      await supabase.auth.signInWithPassword(
        email: user.email,
        password: user.password,
      );
    } on AuthException catch (e) {
      print(e);
      authExceptionsHandler(e);
    }
  }

  static Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  static Future<void> resetPassword({required String email}) async {
    await supabase.auth.resetPasswordForEmail(email);
  }

  // User Functions
  static Future<void> createUserData(Map<String, dynamic> user) async {
    try {
      await supabase.from('Users').insert(user);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<UserModel?> getUserData({required User user}) async {
    try {
      final Map<String, dynamic> response =
          await supabase.from('Users').select().eq('user_id', user.id).single();

      if (response.isNotEmpty) {
        final List<BuildingSummaryModel> buildings =
            await fetchBuildingsSummary();

        final List<ElevatorSummaryModel> elevators = (await Future.wait(
                buildings.map(
                    (b) => fetchElevatorsSummary(buildingId: b.buildingId))))
            .expand((list) => list)
            .toList();

        final UserModel userData = UserModel.fromJson(
            {...response, "buildings": buildings, "elevators": elevators});
        return userData;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  // App Functions
  static Future<List<BuildingSummaryModel>> fetchBuildingsSummary() async {
    try {
      final String userId = supabase.auth.currentUser!.id;
      final List<Map<String, dynamic>> response = await supabase
          .rpc("get_user_buildings_summary", params: {"user_id": userId});

      // await supabase
      //     .from('Buildings')
      //     .select("building_id,building_name")
      //     .eq("owner_id", userId);

      final List<BuildingSummaryModel> buildings =
          response.map((b) => BuildingSummaryModel.fromJson(b)).toList();
      //   await Future.wait(response.map((b) async {
      // var elevatorsCount = await supabase
      //     .from('Elevators')
      //     .select("elevator_id")
      //     .eq('building_id', b["building_id"])
      //     .count(CountOption.exact);

      // Map<String, dynamic>? activeReport = await supabase
      //     .from('Reports')
      //     .select("report_id")
      //     .eq('building_id', b["building_id"])
      //     .not('status', 'eq', 'Resolved')
      //     .maybeSingle();

      //   return BuildingSummaryModel.fromJson({
      //     ...b,
      //     "elevator_count": elevatorsCount.count,
      //     "active_report": activeReport == null ? false : true
      //   });
      // }));

      return buildings;
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  static Future<BuildingModel> fetchBuildingDetails(
      {required String buildingId}) async {
    try {
      final Map<String, dynamic> response = await supabase
          .rpc('get_building_by_id', params: {"b_id": buildingId}).single();

      List<ElevatorSummaryModel> elevators = (response["elevators"] as List)
          .map((e) => ElevatorSummaryModel.fromJson({
                ...e,
                "issue_type": e["active_issue"] != null
                    ? e["active_issue"]["issue_type"]
                    : null
              }))
          .toList();

      List<ReportModel> reports = (response["reports"] as List)
          .map((r) => ReportModel.fromJson(r))
          .toList();

      List<FloorModel> floors = (response["floors"] as List)
          .map((f) => FloorModel.fromJson(f))
          .toList();

      List<FloorModel> closedFloors = (response["closed_floors"] as List)
          .map((cf) => FloorModel.fromJson(cf))
          .toList();

      ReportModel? activeReport = response["active_report"] == null
          ? null
          : ReportModel.fromJson(response["active_report"]);

      return BuildingModel.fromJson({
        ...response,
        "elevators": elevators,
        "floors": floors,
        "closed_floors": closedFloors,
        "reports": reports,
        "active_report": activeReport
      });
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  static Future<List<ElevatorSummaryModel>> fetchElevatorsSummary(
      {required String buildingId}) async {
    try {
      final List<Map<String, dynamic>> response = await supabase.rpc(
        "get_building_elevators_summary",
        params: {"b_id": buildingId},
      );

      final List<ElevatorSummaryModel> elevators = response
          .map((e) => ElevatorSummaryModel.fromJson({
                ...e,
                "issue_type": e["active_issue"] != null
                    ? e["active_issue"]["issue_type"]
                    : null
              }))
          .toList();

      return elevators;
    } catch (e) {
      print("fetchElevatorsSummary error => $e");
      throw Exception(e.toString());
    }
  }

  static Future<ElevatorModel> fetchElevatorDetails(
      {required String elevatorId}) async {
    try {
      final Map<String, dynamic> response = await supabase
          .rpc("get_elevator_by_id", params: {"e_id": elevatorId});

      final List<IssueModel> issues = (response["issues"] as List)
          .map((i) => IssueModel.fromJson(i))
          .toList();

      final IssueModel? activeIssue = response["active_issue"] == null
          ? null
          : IssueModel.fromJson(response["active_issue"]);

      return ElevatorModel.fromJson(
          {...response, "issues": issues, "active_issue": activeIssue});
    } catch (e) {
      print("fetchElevatorDetails error => $e");
      throw Exception(e.toString());
    }
  }

  static Future<String> createReport({required String buildingId}) async {
    try {
      final String userId = supabase.auth.currentUser!.id;
      final Map<String, dynamic> reportData = {
        "reported_by": userId,
        "building_id": buildingId,
      };
      final Map<String, dynamic> report =
          await supabase.rpc('create_and_get_report', params: reportData);
      // .from('Reports')
      // .select("report_id")
      // .eq("building_id", buildingId)
      // .not("status", "eq", "Resolved")
      // .maybeSingle();

      // if (activeReport == null) {
      //   // final Map<String, dynamic> reportData = {
      //   //   "reported_by": userId,
      //   //   "building_id": buildingId,
      //   // };

      //   final Map<String, dynamic> response = await supabase
      //       .from('Reports')
      //       .insert(reportData)
      //       .select("report_id")
      //       .single();

      //   return response["report_id"];
      // }

      return report["report_id"];
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> createIssue(IssueModel issueModel) async {
    try {
      final String reportId =
          await createReport(buildingId: issueModel.buildingId!);

      await supabase
          .from('Issues')
          .insert(issueModel.copyWith(reportId: reportId).toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
