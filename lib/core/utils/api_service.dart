import 'package:UpDown/core/utils/function/auth_exceptions_handler.dart';
import 'package:UpDown/features/create_report/data/model/issue_model.dart';
import 'package:UpDown/features/home/data/model/building_model.dart';
import 'package:UpDown/features/home/data/model/building_summary_model.dart';
import 'package:UpDown/features/home/data/model/elevator_model.dart';
import 'package:UpDown/core/utils/model/user_model.dart';
import 'package:UpDown/features/auth/data/model/auth_user_model.dart';
import 'package:UpDown/features/create_report/data/model/report_model.dart';
import 'package:UpDown/features/home/data/model/elevator_summary_model.dart';
import 'package:UpDown/features/home/data/model/floor_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ApiService {
  final supabase = Supabase.instance.client;
  ApiService();

  Future<void> signUp(AuthUserModel user) async {
    try {
      await supabase.auth.signUp(
        email: user.email,
        password: user.password,
      );
      //     .then((value) async {
      //   String? userId = value.user?.id;

      //   if (userId == null) return;
      //   UserModel newUser = UserModel(id: userId, email: value.user!.email);
      //   await createUserData(newUser);
      // });
    } on AuthException catch (e) {
      authExceptionsHandler(e);
    }
  }

  Future<void> signInWithPassword(AuthUserModel user) async {
    try {
      await supabase.auth.signInWithPassword(
        email: user.email,
        password: user.password,
      );
    } on AuthException catch (e) {
      authExceptionsHandler(e);
    }
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  Future<void> resetPassword({required String email}) async {
    await supabase.auth.resetPasswordForEmail(email);
  }

  Future<void> createUserData(UserModel user) async {
    try {
      final jsonData = user.toJson();
      await supabase.from('Users').insert(jsonData);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<UserModel?> getUserData(User user) async {
    try {
      final List<Map<String, dynamic>> response =
          await supabase.from('Users').select().eq('id', user.id).limit(1);

      if (response.isNotEmpty) {
        final UserModel userData = UserModel.fromJson(response[0]);
        return userData;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  Future<List<ReportModel>> fetchBuildingReports(
      {required String buildingId}) async {
    try {
      final List<Map<String, dynamic>> response =
          await supabase.from('Reports').select().eq("building_id", buildingId);

      return response.map((report) => ReportModel.fromJson(report)).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> createReport(ReportModel report) async {
    try {
      final String userId = supabase.auth.currentUser!.id.toString();
      final List<Map<String, dynamic>> response = await supabase
          .from('Users')
          .select()
          .eq("id", userId)
          .limit(1)
          .select("reports");
      response.add(report.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<BuildingSummary>> fetchBuildingsSummary() async {
    try {
      // final String userId = supabase.auth.currentUser!.id.toString();

      final List<Map<String, dynamic>> response = await supabase
          .from('Buildings')
          .select("building_id,building_name")
          .eq("owner_id", "17b33518-b78b-4f01-ab26-28ef24b46d5b");

      final List<BuildingSummary> buildings =
          await Future.wait(response.map((b) async {
        var elevatorsCount = await supabase
            .from('Elevators')
            .select("elevator_id")
            .eq('building_id', b["building_id"])
            .count(CountOption.exact);

        var activeReportsCount = await supabase
            .from('Reports')
            .select("report_id")
            .eq('building_id', b["building_id"])
            .eq('status', 'Resolved')
            .count(CountOption.exact);

        return BuildingSummary.fromJson({
          ...b,
          "elevator_count": elevatorsCount.count,
          "reports_count": activeReportsCount.count
        });
      }));

      return buildings;
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  Future<BuildingModel> fetchBuildingDetails(
      {required String buildingId}) async {
    try {
      final Map<String, dynamic> response = await supabase
          .from('Buildings')
          .select()
          .eq("building_id", buildingId)
          .single();

      List<ReportModel> reports =
          await fetchBuildingReports(buildingId: buildingId);

      List<ElevatorSummaryModel> elevators =
          await fetchBuildingElevators(buildingId: buildingId);

      if (reports.isEmpty) {
        reports = [];
      }
      return BuildingModel.fromJson(
          {...response, "elevators": elevators, "reports": reports});
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  Future<ElevatorModel> fetchElevatorDetails(
      {required String elevatorId}) async {
    try {
      final Map<String, dynamic> response = await supabase
          .from('Elevators')
          .select()
          .eq("elevator_id", elevatorId)
          .single();

      print(response);

      final List<IssueModel> issues =
          await fetchElevatorIssues(elevatorId: response["elevator_id"]);

      final List<FloorModel> floors =
          (response["floors"] as List<dynamic>? ?? [])
              .map((f) => FloorModel.fromJson(f))
              .toList();

      final List<FloorModel> closedFloors =
          (response["closed_floors"] as List<dynamic>? ?? [])
              .map((cf) => FloorModel.fromJson(cf))
              .toList();

      return ElevatorModel.fromJson({
        ...response,
        "issues": issues,
        "floors": floors,
        "closed_floors": closedFloors
      });
    } catch (e) {
      print("fetchElevatorDetails error => $e");
      throw Exception(e.toString());
    }
  }

  Future<List<IssueModel>> fetchElevatorIssues(
      {required String elevatorId}) async {
    try {
      final List<Map<String, dynamic>> response =
          await supabase.from('Issues').select().eq("elevator_id", elevatorId);

      if (response.isEmpty) return [];

      List<IssueModel> issues =
          response.map((issue) => IssueModel.fromJson(issue)).toList();

      return issues;
    } catch (e) {
      print("fetchElevatorIssues error => $e");
      throw Exception(e.toString());
    }
  }

  Future<List<ElevatorSummaryModel>> fetchBuildingElevators(
      {required String buildingId}) async {
    try {
      final List<Map<String, dynamic>> response = await supabase
          .from('Elevators')
          .select("elevator_id,elevator_number,status,next_maintenance_date")
          .eq("building_id", buildingId);

      if (response.isEmpty) return [];

      final List<ElevatorSummaryModel> elevators =
          response.map((e) => ElevatorSummaryModel.fromJson(e)).toList();

      return elevators;
    } catch (e) {
      print("fetchBuildingElevators error => $e");
      throw Exception(e.toString());
    }
  }
}
