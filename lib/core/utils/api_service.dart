import 'package:UpDown/core/utils/function/auth_exceptions_handler.dart';
import 'package:UpDown/features/home/data/model/building_model.dart';
import 'package:UpDown/features/home/data/model/elevator_model.dart';
import 'package:UpDown/core/utils/model/user_model.dart';
import 'package:UpDown/features/auth/data/model/auth_user_model.dart';
import 'package:UpDown/features/create_report/data/model/report_model.dart';

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

  Future<List<ReportModel>> getReports() async {
    try {
      final String userId = supabase.auth.currentUser!.id.toString();
      final List<Map<String, dynamic>> response = await supabase
          .from('Users')
          .select()
          .eq("id", userId)
          .limit(1)
          .select("reports");
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

  Future<List<ReportModel>> getActiveReports() async {
    try {
      final String userId = supabase.auth.currentUser!.id.toString();
      final List<Map<String, dynamic>> response = await supabase
          .from('Users')
          .select()
          .eq("id", userId)
          .limit(1)
          .select("reports");
      final List<Map<String, dynamic>> activeReports =
          response.where((r) => r["status"] == "active").toList();

      return activeReports
          .map((report) => ReportModel.fromJson(report))
          .toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<BuildingModel>> getBuildings() async {
    try {
      // final String userId = supabase.auth.currentUser!.id.toString();

      final List<Map<String, dynamic>> response = await supabase
          .from('Buildings')
          .select()
          .eq("owner_id", "17b33518-b78b-4f01-ab26-28ef24b46d5b");

      final List<BuildingModel> buildings =
          await Future.wait(response.map((b) async {
        List<ElevatorModel> elevators = await getElevators(b["building_id"]);

        return BuildingModel.fromJson({...b, "elevators": elevators});
      }));

      return buildings;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<ElevatorModel>> getElevators(String buildingId) async {
    try {
      final List<Map<String, dynamic>> response = await supabase
          .from('Elevators')
          .select()
          .eq("building_id", buildingId);

      if (response.isEmpty) return [];

      List<ElevatorModel> elevators =
          response.map((elevator) => ElevatorModel.fromJson(elevator)).toList();

      return elevators;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
