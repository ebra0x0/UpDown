import 'dart:io';
import 'dart:typed_data';
import 'package:UpDown/core/utils/localization/constants.dart';
import 'package:UpDown/core/errors/failures.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/function/media_compressor.dart';
import 'package:UpDown/core/utils/model/profile_model.dart';
import 'package:UpDown/core/utils/storage_path.dart';
import 'package:UpDown/features/elevators/data/models/unit_model.dart';
import 'package:UpDown/features/elevators/data/models/unit_model_factory.dart';
import 'package:UpDown/features/issues/data/models/create_issue_model.dart';
import 'package:UpDown/features/buildings/data/models/building_model.dart';
import 'package:UpDown/features/buildings/data/models/building_summary_model.dart';
import 'package:UpDown/features/elevators/data/models/elevator_model.dart';
import 'package:UpDown/core/utils/model/user_credentials_model.dart';
import 'package:UpDown/features/elevators/data/models/elevator_summary_model.dart';
import 'package:UpDown/features/issues/data/models/issue_summary_model.dart';
import 'package:UpDown/features/issues/data/models/media_model.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ApiService {
  final SupabaseClient _supabase;
  User? get _user => _supabase.auth.currentUser;

  ApiService(this._supabase);

  // Auth Functions

  Stream<Session?> get onAuthStateChanged =>
      _supabase.auth.onAuthStateChange.map((data) => data.session);

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
      final AuthResponse newSession =
          await _supabase.auth.refreshSession(refreshToken);

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

  Future<Either<Failure, bool>> isNewAccount() async {
    try {
      final bool isNewAccount = await _supabase.rpc("check_new_account");

      return Right(isNewAccount);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } catch (e) {
      return Left(CustomFailure("حدث خطاء اثناء التحقق من حالة الحساب"));
    }
  }

  // User Functions
  Future<Either<Failure, void>> createProfile(ProfileModel profile) async {
    try {
      // Check if profile already exists
      final Map<String, dynamic>? existingProfile = await _supabase
          .from('Users')
          .select()
          .eq('user_id', _user!.id)
          .maybeSingle();

      if (existingProfile != null) {
        return Left(CustomFailure("الملف الشخصي موجود بالفعل"));
      }

      // Upload avatar if exists
      if (profile.imagePath != null) {
        final uploadResult = await _uploadAvatar(XFile(profile.imagePath!));
        if (uploadResult.isLeft) return Left(uploadResult.left);

        // Update profile model
        final String? userEmail = _supabase.auth.currentUser?.email;
        final String avatarPath =
            uploadResult.right.replaceFirst(RegExp(r'^[^/]+/[^/]+/'), '');

        profile = profile.copyWith(email: userEmail, imagePath: avatarPath);
      }

      await _supabase
          .from('Users')
          .insert(profile.toJson()); // removed is remote
      return const Right(null);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } catch (e) {
      return Left(CustomFailure("حدث خطاء اثناء انشاء بيانات المستخدم"));
    }
  }

  Future<Either<Failure, ProfileModel>> fetchProfile() async {
    try {
      final Map<String, dynamic> response =
          await _supabase.from('Users').select().eq('id', _user!.id).single();

      if (response["image_path"] != null) {
        final String? avatarPath =
            await _downloadAvatar(response["image_path"]);

        if (avatarPath != null) {
          response["image_path"] = avatarPath;
        }
      }

      final ProfileModel profile = ProfileModel.fromJson(response);

      return Right(profile);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } catch (e) {
      return Left(CustomFailure("حدث خطاء اثناء جلب بيانات المستخدم"));
    }
  }

  Future<String?> _downloadAvatar(String imagePath) async {
    try {
      final Uint8List response = await _supabase.storage
          .from(kAvatarsBucket)
          .download("$kAvatarsBucketFolder/$imagePath");

      final Directory dir = await getApplicationDocumentsDirectory();

      final String filePath = '${dir.path}/${imagePath.split('/').last}';

      final file = File(filePath);
      await file.writeAsBytes(response);

      return file.path;
    } catch (e) {
      return null;
    }
  }

  Future<Either<Failure, String>> _uploadAvatar(XFile file) async {
    try {
      final User? user = _supabase.auth.currentUser;
      if (user == null) {
        return Left(CustomFailure("المستخدم غير مسجل"));
      }

      // Compress file
      final File? compressedFile =
          await prepareMediaFile(File(file.path), MediaType.image);

      if (compressedFile == null) {
        return Left(CustomFailure("حدث خطاء اثناء تحديث صورة المستخدم"));
      }

      // Upload avatar
      final uploadResult = await _uploadMedia(
        bucketName: kAvatarsBucket,
        filePath: compressedFile.path,
        path: StoragePath.fromAvatar(
                filePath: compressedFile.path, userId: user.id)
            .path,
      );

      if (uploadResult.isLeft) return Left(uploadResult.left);

      final String url = uploadResult.right;

      return Right(url);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } catch (e) {
      return Left(CustomFailure("حدث خطاء اثناء تحديث صورة المستخدم"));
    }
  }

  Future<Either<Failure, void>> updateProfile(ProfileModel profile) async {
    try {
      if (profile.imagePath != null) {
        final uploadResult = await _uploadAvatar(XFile(profile.imagePath!));
        if (uploadResult.isLeft) return Left(uploadResult.left);

        final String avatarPath = uploadResult.right.replaceFirst(
          RegExp(r'^[^/]+/[^/]+/'),
          '',
        );

        profile = profile.copyWith(imagePath: avatarPath);
      }

      await _supabase
          .from('Users')
          .update(profile.toJson())
          .eq("user_id", _user!.id);

      return const Right(null);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } catch (e) {
      return Left(CustomFailure("حدث خطاء اثناء تحديث بيانات المستخدم"));
    }
  }

  // Buildings
  Future<Either<Failure, List<BuildingSummaryModel>>> fetchBuildings() async {
    try {
      final User user = _supabase.auth.currentUser!;

      final List<dynamic> response =
          await _supabase.rpc("get_buildings", params: {"user_id": user.id});

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
      final Map<String, dynamic> response = await _supabase
          .from('Buildings')
          .select()
          .eq('id', buildingId)
          .single();

      return Right(BuildingModel.fromJson(response));
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } catch (e) {
      return Left(CustomFailure("حدث خطاء اثناء جلب بيانات المبنى"));
    }
  }

  // Elevators

  Future<Either<Failure, ElevatorModel>> fetchElevatorDetails(
      {required String elevatorId}) async {
    try {
      final Map<String, dynamic> response = await _supabase
          .from('Elevators')
          .select()
          .eq('id', elevatorId)
          .single();

      return Right(ElevatorModel.fromJson(response));
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } catch (e) {
      return Left(CustomFailure("حدث خطاء اثناء جلب بيانات المصعد"));
    }
  }

  Future<Either<Failure, List<ElevatorSummaryModel>>> fetchElevatorsByBuilding(
      {required String buildingId}) async {
    try {
      final List<Map<String, dynamic>> response = await _supabase
          .from('elevators_summary_view')
          .select()
          .eq('building_id', buildingId);

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

  Future<Either<Failure, List<ElevatorSummaryModel>>> fetchElevatorsByBuildings(
      {required List<String> buildingIds}) async {
    try {
      final List<Map<String, dynamic>> response = await _supabase
          .from('elevators_summary_view')
          .select()
          .inFilter('building_id', buildingIds);

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

  Future<Either<Failure, List<UnitModel>>> fetchElevatorUnits(
      {required String elevatorId}) async {
    try {
      final List<Map<String, dynamic>> response = await _supabase
          .from('elevator_units_summary_view')
          .select()
          .eq('elevator_id', elevatorId);

      final List<UnitModel> units = response.map((u) {
        return UnitModel.fromJson(u);
      }).toList();

      return Right(units);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } catch (e) {
      return Left(CustomFailure("حدث خطاء اثناء طلب وحدات المصعد"));
    }
  }

  Future<Either<Failure, UnitModel>> fetchUnitDetails(
      {required String unitId}) async {
    try {
      final Map<String, dynamic> response = await _supabase
          .from('Elevator_Units')
          .select()
          .eq('id', unitId)
          .single();

      return Right(UnitModelFactory.createUnitModel(response));
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } catch (e) {
      return Left(CustomFailure("حدث خطاء اثناء جلب بيانات المصاعد"));
    }
  }

  // Issues
  Future<Either<Failure, void>> createIssue(CreateIssueModel issueModel) async {
    try {
      // Create issue
      final Map<String, dynamic>? issueIdRes = await _supabase
          .rpc("create_issue", params: issueModel.toJson())
          .maybeSingle();

      if (issueIdRes == null) {
        return Left(CustomFailure("تعذر إنشاء العطل"));
      }

      issueModel = issueModel.copyWith(
          id: issueIdRes["issue_id"], reportId: issueIdRes["report_id"]);

      if (issueModel.media == null) return const Right(null);

      // Create media
      final mediaResponse = await _createIssueMedia(issueModel);

      if (mediaResponse.isLeft) return Left(mediaResponse.left);

      return const Right(null);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } catch (_) {
      return Left(CustomFailure("حدث خطأ أثناء إنشاء العطل"));
    }
  }

  Future<Either<Failure, void>> _createIssueMedia(
      CreateIssueModel issue) async {
    try {
      // Compress file
      final File? compressedFile =
          await prepareMediaFile(issue.media!.file!, issue.media!.type);

      if (compressedFile == null) {
        return Left(CustomFailure("حدث خطاء اثناء ضغط الملف"));
      }

      // Create storage path for media
      final String storagePath = StoragePath.fromIssue(issue: issue).path;

      // Upload media
      final uploadResult = await _uploadMedia(
        bucketName: kReportsBucket,
        filePath: compressedFile.path,
        path: storagePath,
      );

      if (uploadResult.isLeft) return Left(uploadResult.left);

      final String mediaUrl =
          uploadResult.right.replaceFirst(RegExp(r'^[^/]+/[^/]+/'), '');

      final MediaModel mediaWithUrl =
          issue.media!.copyWith(url: mediaUrl, issueId: issue.id);

      // Create media in db
      issue = issue.copyWith(media: mediaWithUrl);

      await _supabase.from('Media').insert(issue.media!.toJson());

      return const Right(null);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } catch (e) {
      return Left(CustomFailure("حدث خطأ أثناء إنشاء وسائط العطل"));
    }
  }

  Future<Either<Failure, String>> _uploadMedia(
      {required String bucketName,
      required String filePath,
      required String path}) async {
    try {
      // Upload to bucket
      final String url = await _supabase.storage.from(bucketName).upload(
            path,
            File(filePath),
          );

      return Right(url);
    } on StorageException catch (e) {
      return Left(SupabaseFailure.fromStorage(e));
    } catch (e) {
      return Left(CustomFailure("حدث خطاء اثناء حفظ الملف"));
    }
  }

  Future<Either<Failure, List<IssueSummaryModel>?>>
      fetchActiveIssuesForBuilding(String buildingId) async {
    try {
      final List<Map<String, dynamic>> response = await _supabase
          .from('active_issues_summary_view')
          .select()
          .eq('building_id', buildingId);

      if (response.isEmpty) {
        return Right(null);
      }

      final List<IssueSummaryModel> issues = response.map((e) {
        return IssueSummaryModel.fromJson(e);
      }).toList();

      return Right(issues);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } catch (e) {
      return Left(CustomFailure("حدث حطأ اثناء جلب بيانات الأعطال النشطة"));
    }
  }

  Future<Either<Failure, List<IssueSummaryModel>?>>
      fetchActiveIssuesForElevator(String elevatorId) async {
    try {
      final List<Map<String, dynamic>> response = await _supabase
          .from('active_issues_summary_view')
          .select()
          .eq('elevator_id', elevatorId);

      if (response.isEmpty) {
        return Right(null);
      }

      final List<IssueSummaryModel> issues = response.map((e) {
        return IssueSummaryModel.fromJson(e);
      }).toList();

      return Right(issues);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } catch (e) {
      return Left(CustomFailure("حدث حطاء اثناء جلب بيانات الأعطال النشطة"));
    }
  }

  Future<Either<Failure, List<IssueSummaryModel>?>>
      fetchAllActiveIssues() async {
    try {
      final List<Map<String, dynamic>> response = await _supabase
          .from('active_issues_summary_view')
          .select()
          .eq("user_id", _supabase.auth.currentUser!.id);

      if (response.isEmpty) {
        return Right(null);
      }

      final List<IssueSummaryModel> issues = response.map((e) {
        return IssueSummaryModel.fromJson(e);
      }).toList();

      return Right(issues);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } catch (e) {
      return Left(CustomFailure("حدث حطاء اثناء جلب بيانات الأعطال النشطة"));
    }
  }
}
