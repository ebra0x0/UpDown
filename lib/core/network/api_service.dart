import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:UpDown/core/network/api_constants.dart';
import 'package:UpDown/core/network/api_failure.dart';
import 'package:UpDown/core/utils/helper/safe_request.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/helper/media_compressor.dart';
import 'package:UpDown/core/utils/model/media_models/media_request_model.dart';
import 'package:UpDown/features/profile/data/model/profile_request_model.dart';
import 'package:UpDown/features/profile/data/model/profile_response_model.dart';
import 'package:UpDown/core/utils/storage_path.dart';
import 'package:UpDown/features/elevators/data/models/unit_model.dart';
import 'package:UpDown/features/elevators/data/models/unit_model_factory.dart';
import 'package:UpDown/features/issues/data/models/issue_request_model.dart';
import 'package:UpDown/features/buildings/data/models/building_model.dart';
import 'package:UpDown/features/buildings/data/models/building_summary_model.dart';
import 'package:UpDown/features/elevators/data/models/elevator_model.dart';
import 'package:UpDown/core/utils/model/user_credentials_model.dart';
import 'package:UpDown/features/elevators/data/models/elevator_summary_response_model.dart';
import 'package:UpDown/features/issues/data/models/issue_response_model.dart';
import 'package:UpDown/features/issues/data/models/issue_summary_response_model.dart';
import 'package:UpDown/core/utils/model/media_models/media_response_model.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/transformers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ApiService {
  final SupabaseClient _supabase;
  User? get _user => _supabase.auth.currentUser;
  Session? get _session => _supabase.auth.currentSession;

  ApiService(this._supabase);

  // Auth Functions

  Stream<Session?> get onAuthStateChanged {
    return _supabase.auth.onAuthStateChange
        .map((data) => data.session)
        .doOnError((_, __) {
      throw CustomFailure("حدث خطأ أثناء مراقبة حالة المصادقة");
    });
  }

  Future<Either<Failure, Session?>> signUp(UserCredentialsModel user) async {
    try {
      final AuthResponse res = await safeRequest(
          request: () => _supabase.auth.signUp(
                email: user.email,
                password: user.password,
              ),
          errorMessage: "فشل الاتصال اثناء التسجيل. حاول مرة اخرى.");

      return Right(res.session);
    } on AuthException catch (e) {
      return Left(SupabaseFailure.fromAuth(e));
    } on NetworkFailure catch (e) {
      return Left(NetworkFailure(e.errMessage));
    } catch (_) {
      return Left(CustomFailure("حدث خطاء اثناء التسجيل"));
    }
  }

  Future<Either<Failure, Session>> signInWithPassword(
      UserCredentialsModel user) async {
    try {
      final AuthResponse res = await safeRequest(
          request: () => _supabase.auth.signInWithPassword(
                email: user.email,
                password: user.password,
              ),
          errorMessage: "فشل الاتصال اثناء تسجيل الدخول. حاول مرة اخرى.");

      if (res.session == null) {
        return Left(CustomFailure("حدث خطاء اثناء تسجيل الدخول"));
      }

      return Right(res.session!);
    } on AuthException catch (e) {
      return Left(SupabaseFailure.fromAuth(e));
    } on NetworkFailure catch (e) {
      return Left(NetworkFailure(e.errMessage));
    } catch (_) {
      return Left(CustomFailure("حدث خطأ أثناء تسجيل الدخول"));
    }
  }

  Future<Either<Failure, void>> signOut() async {
    try {
      await safeRequest(
          request: () => _supabase.auth.signOut(),
          errorMessage: "فشل الاتصال اثناء تسجيل الخروج. حاول مرة اخرى.");
      return const Right(null);
    } on AuthException catch (e) {
      return Left(SupabaseFailure.fromAuth(e));
    } on NetworkFailure catch (e) {
      return Left(NetworkFailure(e.errMessage));
    } catch (_) {
      return Left(CustomFailure("حدث خطأ أثناء تسجيل الخروج"));
    }
  }

  Future<Either<Failure, Session?>> refreshToken(String refreshToken) async {
    try {
      if (_session == null) return const Right(null);
      final AuthResponse newSession = await safeRequest(
          request: () => _supabase.auth.refreshSession(refreshToken),
          errorMessage: "فشل الاتصال اثناء تحديث الجلسة. حاول مرة اخرى.");

      return Right(newSession.session);
    } on AuthException catch (e) {
      return Left(SupabaseFailure.fromAuth(e));
    } on NetworkFailure catch (e) {
      return Left(NetworkFailure(e.errMessage));
    } catch (_) {
      return Left(CustomFailure("حدث خطاء اثناء تحديث الجلسة"));
    }
  }

  Future<Either<Failure, void>> sendConfirmationEmail(String email) async {
    try {
      if (email.isEmpty) {
        return Left(CustomFailure("يرجى إرفاق البريد الإلكتروني"));
      }

      await safeRequest(
          request: () =>
              _supabase.auth.resend(type: OtpType.signup, email: email),
          errorMessage: "فشل الاتصال اثناء إرسال رمز التفعيل. حاول مرة اخرى.");
      return const Right(null);
    } on AuthException catch (e) {
      return Left(SupabaseFailure.fromAuth(e));
    } on NetworkFailure catch (e) {
      return Left(NetworkFailure(e.errMessage));
    } catch (_) {
      return Left(CustomFailure("حدث خطاء اثناء إرسال رمز التفعيل"));
    }
  }

  Future<Either<Failure, void>> resetPassword({required String email}) async {
    try {
      if (email.isEmpty) {
        return Left(CustomFailure("يرجى إدخال البريد الإلكتروني"));
      }

      await safeRequest(
          request: () => _supabase.auth.resetPasswordForEmail(email),
          errorMessage:
              "فشل الاتصال اثناء استعادة كلمة المرور. حاول مرة اخرى.");
      return const Right(null);
    } on AuthException catch (e) {
      return Left(SupabaseFailure.fromAuth(e));
    } on NetworkFailure catch (e) {
      return Left(NetworkFailure(e.errMessage));
    } catch (_) {
      return Left(CustomFailure("حدث خطاء اثناء استعادة كلمة المرور"));
    }
  }

  // User Functions
  Future<Either<Failure, void>> createProfile(
      ProfileRequestModel profile) async {
    try {
      // Check if profile already exists

      final isNew = await isNewAccount();

      if (isNew.isLeft) return Left(isNew.left);

      if (!isNew.right) {
        return Left(CustomFailure("الملف الشخصي موجود بالفعل"));
      }

      // Upload avatar if exists

      if (profile.imagePath != null) {
        final uploadResult = await _uploadAvatar(XFile(profile.imagePath!));

        if (uploadResult.isLeft) return Left(uploadResult.left);

        // Update profile model
        final String? userEmail = _user?.email;
        final String avatarPath =
            uploadResult.right.replaceFirst(RegExp(r'^[^/]+/[^/]+/'), '');

        profile = profile.copyWith(email: userEmail, imagePath: avatarPath);
      }

      // Insert profile into database
      await safeRequest(
        request: () => _supabase.from('Users').insert(profile.toJson()),
        errorMessage: "فشل الاتصال اثناء انشاء بيانات المستخدم. حاول مرة اخرى.",
      ); // removed is remote
      return const Right(null);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } on NetworkFailure catch (e) {
      return Left(NetworkFailure(e.errMessage));
    } catch (_) {
      return Left(CustomFailure("حدث خطاء اثناء انشاء بيانات المستخدم"));
    }
  }

  Future<Either<Failure, bool>> isNewAccount() async {
    try {
      final bool isNewAccount = await safeRequest(
        request: () => _supabase.rpc("check_new_account"),
      );

      return Right(isNewAccount);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } on NetworkFailure catch (e) {
      return Left(NetworkFailure(e.errMessage));
    } catch (_) {
      return Left(CustomFailure("حدث خطاء اثناء التحقق من حالة الحساب"));
    }
  }

  Future<Either<Failure, ProfileResponseModel>> fetchProfile() async {
    try {
      final Map<String, dynamic> response = await safeRequest(
          request: () =>
              _supabase.from('Users').select().eq('id', _user!.id).single(),
          errorMessage:
              "فشل الاتصال اثناء جلب بيانات المستخدم. حاول مرة اخرى.");

      // Check if image_path exists and download it
      if (response["image_path"] != null) {
        // Download avatar
        final avatarPath = await _downloadAvatar(response["image_path"]);

        if (avatarPath.isLeft) return Left(avatarPath.left);

        response["image_path"] = avatarPath.right;
      }

      final ProfileResponseModel profile =
          ProfileResponseModel.fromJson(response);

      return Right(profile);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } on NetworkFailure catch (e) {
      return Left(NetworkFailure(e.errMessage));
    } catch (_) {
      return Left(CustomFailure("حدث خطاء اثناء جلب بيانات المستخدم"));
    }
  }

  Future<Either<Failure, String>> _downloadAvatar(String imagePath) async {
    try {
      final Uint8List response = await safeRequest(
          request: () => _supabase.storage
              .from(ApiConstants.avatarsBucket)
              .download("${ApiConstants.avatarsBucketFolder}/$imagePath"),
          errorMessage:
              "فشل الاتصال اثناء تحميل صورة الملف الشخصي. حاول مرة اخرى.");

      final Directory dir = await getApplicationDocumentsDirectory();

      final String filePath = '${dir.path}/${imagePath.split('/').last}';

      final file = File(filePath);
      await file.writeAsBytes(response);

      return Right(file.path);
    } on StorageException catch (e) {
      return Left(SupabaseFailure.fromStorage(e));
    } on NetworkFailure catch (e) {
      return Left(NetworkFailure(e.errMessage));
    } catch (_) {
      return Left(CustomFailure("حدث خطاء اثناء تحميل صورة الملف الشخصي"));
    }
  }

  Future<Either<Failure, String>> _uploadAvatar(XFile file) async {
    try {
      // Upload avatar
      final uploadResult = await _uploadMedia(
        bucketName: ApiConstants.avatarsBucket,
        filePath: file.path,
        storagePath:
            StoragePath.fromAvatar(filePath: file.path, userId: _user!.id).path,
        mediaType: MediaType.image,
      );

      if (uploadResult.isLeft) return Left(uploadResult.left);

      final String url = uploadResult.right;

      return Right(url);
    } catch (_) {
      return Left(CustomFailure("حدث خطاء اثناء رفع صورة الملف الشخصي"));
    }
  }

  Future<Either<Failure, ProfileResponseModel>> updateProfile(
      ProfileRequestModel profile) async {
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

      final res = await safeRequest(
          request: () => _supabase
              .from('Users')
              .update(profile.toJson())
              .eq("id", _user!.id)
              .single(),
          errorMessage:
              "فشل الاتصال اثناء تحديث بيانات المستخدم. حاول مرة اخرى.");

      final ProfileResponseModel updatedProfile =
          ProfileResponseModel.fromJson(res);

      return Right(updatedProfile);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } on NetworkFailure catch (e) {
      return Left(NetworkFailure(e.errMessage));
    } catch (_) {
      return Left(CustomFailure("حدث خطاء اثناء تحديث بيانات المستخدم"));
    }
  }

  // Buildings
  Future<Either<Failure, List<BuildingSummaryModel>>> fetchBuildings() async {
    try {
      final List<dynamic> response = await safeRequest(
          request: () =>
              _supabase.rpc("get_buildings", params: {"user_id": _user!.id}),
          errorMessage: "فشل الاتصال اثناء جلب بيانات الأبنية. حاول مرة اخرى.");

      final List<BuildingSummaryModel> buildings =
          response.map((b) => BuildingSummaryModel.fromJson(b)).toList();

      return Right(buildings);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } on NetworkFailure catch (e) {
      return Left(NetworkFailure(e.errMessage));
    } catch (_) {
      return Left(CustomFailure("حدث خطاء اثناء جلب بيانات الأبنية"));
    }
  }

  Future<Either<Failure, BuildingModel>> fetchBuildingDetails(
      {required String buildingId}) async {
    try {
      final Map<String, dynamic> response = await safeRequest(
          request: () => _supabase
              .from('Buildings')
              .select()
              .eq('id', buildingId)
              .single(),
          errorMessage: "فشل الاتصال اثناء جلب بيانات المبنى. حاول مرة اخرى.");

      return Right(BuildingModel.fromJson(response));
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } on NetworkFailure catch (e) {
      return Left(NetworkFailure(e.errMessage));
    } catch (_) {
      return Left(CustomFailure("حدث خطاء اثناء جلب بيانات المبنى"));
    }
  }

  // Elevators

  Future<Either<Failure, ElevatorModel>> fetchElevatorDetails(
      {required String elevatorId}) async {
    try {
      final Map<String, dynamic> response = await safeRequest(
          request: () => _supabase
              .from('Elevators')
              .select()
              .eq('id', elevatorId)
              .single(),
          errorMessage: "فشل الاتصال اثناء جلب بيانات المصعد. حاول مرة اخرى.");

      return Right(ElevatorModel.fromJson(response));
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } on NetworkFailure catch (e) {
      return Left(NetworkFailure(e.errMessage));
    } catch (_) {
      return Left(CustomFailure("حدث خطاء اثناء جلب بيانات المصعد"));
    }
  }

  Future<Either<Failure, List<ElevatorSummaryResponseModel>>>
      fetchElevatorsByBuilding({required String buildingId}) async {
    try {
      final List<Map<String, dynamic>> response = await safeRequest(
          request: () => _supabase
              .from('elevators_summary_view')
              .select()
              .eq('building_id', buildingId),
          errorMessage: "فشل الاتصال اثناء جلب بيانات المصاعد. حاول مرة اخرى.");

      final List<ElevatorSummaryResponseModel> elevators = response.map((e) {
        return ElevatorSummaryResponseModel.fromJson(e);
      }).toList();

      return Right(elevators);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } on NetworkFailure catch (e) {
      return Left(NetworkFailure(e.errMessage));
    } catch (_) {
      return Left(CustomFailure("حدث خطاء اثناء جلب بيانات المصاعد"));
    }
  }

  Future<Either<Failure, List<ElevatorSummaryResponseModel>>>
      fetchElevatorsByBuildings({required List<String> buildingIds}) async {
    try {
      final List<Map<String, dynamic>> response = await safeRequest(
          request: () => _supabase
              .from('elevators_summary_view')
              .select()
              .inFilter('building_id', buildingIds),
          errorMessage: "فشل الاتصال اثناء جلب بيانات المصاعد. حاول مرة اخرى.");

      final List<ElevatorSummaryResponseModel> elevators = response.map((e) {
        return ElevatorSummaryResponseModel.fromJson(e);
      }).toList();

      return Right(elevators);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } on NetworkFailure catch (e) {
      return Left(NetworkFailure(e.errMessage));
    } catch (_) {
      return Left(CustomFailure("حدث خطاء اثناء جلب بيانات المصاعد"));
    }
  }

  Future<Either<Failure, List<UnitModel>>> fetchElevatorUnits(
      {required String elevatorId}) async {
    try {
      final List<Map<String, dynamic>> response = await safeRequest(
          request: () => _supabase
              .from('elevator_units_summary_view')
              .select()
              .eq('elevator_id', elevatorId),
          errorMessage:
              "فشل الاتصال اثناء جلب بيانات وحدات المصعد. حاول مرة اخرى.");

      final List<UnitModel> units = response.map((u) {
        return UnitModel.fromJson(u);
      }).toList();

      return Right(units);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } on NetworkFailure catch (e) {
      return Left(NetworkFailure(e.errMessage));
    } catch (_) {
      return Left(CustomFailure("حدث خطاء اثناء طلب وحدات المصعد"));
    }
  }

  Future<Either<Failure, UnitModel>> fetchUnitDetails(
      {required String unitId}) async {
    try {
      final Map<String, dynamic> response = await safeRequest(
          request: () => _supabase
              .from('Elevator_Units')
              .select()
              .eq('id', unitId)
              .single(),
          errorMessage: "فشل الاتصال اثناء جلب بيانات الوحدة. حاول مرة اخرى.");

      return Right(UnitModelFactory.createUnitModel(response));
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } on NetworkFailure catch (e) {
      return Left(NetworkFailure(e.errMessage));
    } catch (_) {
      return Left(CustomFailure("حدث خطاء اثناء جلب بيانات المصاعد"));
    }
  }

  // Issues
  Future<Either<Failure, void>> createIssue(IssueRequestModel issueReq) async {
    try {
      // Create issue
      final Map<String, dynamic> issueIdRes = await safeRequest(
          request: () =>
              _supabase.rpc("create_issue", params: issueReq.toJson()).single(),
          errorMessage: "فشل الاتصال اثناء انشاء العطل. حاول مرة اخرى.");

      // if (issueIdRes == null) {
      //   return Left(CustomFailure("تعذر إنشاء العطل"));
      // }

      // Update issue model with ids
      issueReq = issueReq.copyWith(
          id: issueIdRes["issue_id"], reportId: issueIdRes["report_id"]);

      if (issueReq.media == null) return const Right(null);

      // Create media
      final mediaResponse = await _createIssueMedia(
        media: issueReq.media!,
        issueId: issueReq.id!,
        reportId: issueReq.reportId,
      );

      // If media creation fails, delete issue
      if (mediaResponse.isLeft) {
        await safeRequest(
          request: () =>
              _supabase.from('Issues').delete().eq('id', issueReq.id!),
        );
        return Left(mediaResponse.left);
      }

      return const Right(null);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } on NetworkFailure catch (e) {
      return Left(NetworkFailure(e.errMessage));
    } catch (_) {
      return Left(CustomFailure("حدث خطأ أثناء إنشاء العطل"));
    }
  }

  Future<Either<Failure, void>> _createIssueMedia(
      {required MediaRequestModel media,
      required String issueId,
      reportId}) async {
    try {
      // Create storage path for media
      final String storagePath = StoragePath.withIssue(
              media: media, reportId: reportId, issueId: issueId)
          .path;

      // Upload media
      final uploadResult = await _uploadMedia(
        bucketName: ApiConstants.reportsBucket,
        filePath: media.file!.path,
        storagePath: storagePath,
        mediaType: MediaType.image,
      );

      if (uploadResult.isLeft) return Left(uploadResult.left);

      final String mediaUrl =
          uploadResult.right.replaceFirst(RegExp(r'^[^/]+/[^/]+/'), '');

      final MediaRequestModel mediaWithUrl =
          media.copyWith(url: mediaUrl, issueId: issueId);

      // Create media in db
      await safeRequest(
        request: () => _supabase.from('Media').insert(mediaWithUrl.toJson()),
      );

      return const Right(null);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } on NetworkFailure catch (e) {
      return Left(NetworkFailure(e.errMessage));
    } catch (_) {
      return Left(CustomFailure("حدث خطأ أثناء إنشاء وسائط العطل"));
    }
  }

  Future<Either<Failure, String>> _uploadMedia(
      {required String bucketName,
      required String filePath,
      required String storagePath,
      required MediaType mediaType}) async {
    try {
      // Compress file
      final File? compressedFile =
          await prepareMediaFile(File(filePath), mediaType);

      if (compressedFile == null) {
        return Left(CustomFailure("حدث خطاء اثناء معالجة الملف"));
      }

      // Upload to bucket
      final String url = await safeRequest(
          request: () => _supabase.storage.from(bucketName).upload(
                storagePath,
                File(filePath),
              ),
          errorMessage: "فشل الاتصال اثناء رفع الملف. حاول مرة اخرى.");

      return Right(url);
    } on StorageException catch (e) {
      return Left(SupabaseFailure.fromStorage(e));
    } on NetworkFailure catch (e) {
      return Left(NetworkFailure(e.errMessage));
    } catch (_) {
      return Left(CustomFailure("حدث خطاء اثناء رفع الملف"));
    }
  }

  Future<Either<Failure, List<IssueSummaryResponseModel>?>>
      fetchActiveIssuesForBuilding(String buildingId) async {
    try {
      final List<Map<String, dynamic>> response = await safeRequest(
          request: () => _supabase
              .from('active_issues_summary_view')
              .select()
              .eq('building_id', buildingId),
          errorMessage:
              "فشل الاتصال اثناء جلب بيانات الأعطال النشطة. حاول مرة اخرى.");

      if (response.isEmpty) {
        return Right(null);
      }

      final List<IssueSummaryResponseModel> issues = response.map((e) {
        return IssueSummaryResponseModel.fromJson(e);
      }).toList();

      return Right(issues);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } on NetworkFailure catch (e) {
      return Left(NetworkFailure(e.errMessage));
    } catch (_) {
      return Left(CustomFailure("حدث حطأ اثناء جلب بيانات الأعطال النشطة"));
    }
  }

  Future<Either<Failure, List<IssueSummaryResponseModel>?>>
      fetchActiveIssuesForElevator(String elevatorId) async {
    try {
      final List<Map<String, dynamic>> response = await safeRequest(
          request: () => _supabase
              .from('active_issues_summary_view')
              .select()
              .eq('elevator_id', elevatorId),
          errorMessage:
              "فشل الاتصال اثناء جلب بيانات الأعطال النشطة. حاول مرة اخرى.");

      if (response.isEmpty) {
        return Right(null);
      }

      final List<IssueSummaryResponseModel> issues = response.map((e) {
        return IssueSummaryResponseModel.fromJson(e);
      }).toList();

      return Right(issues);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } on NetworkFailure catch (e) {
      return Left(NetworkFailure(e.errMessage));
    } catch (_) {
      return Left(CustomFailure("حدث خطأ أثناء جلب بيانات الأعطال النشطة"));
    }
  }

  Future<Either<Failure, List<IssueSummaryResponseModel>?>>
      fetchAllActiveIssues() async {
    try {
      final List<Map<String, dynamic>> response = await safeRequest(
          request: () => _supabase
              .from('active_issues_summary_view')
              .select()
              .eq("user_id", _user!.id),
          errorMessage:
              "فشل الاتصال اثناء جلب بيانات الأعطال النشطة. حاول مرة اخرى.");

      if (response.isEmpty) {
        return Right(null);
      }

      final List<IssueSummaryResponseModel> issues = response.map((e) {
        return IssueSummaryResponseModel.fromJson(e);
      }).toList();

      return Right(issues);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } on NetworkFailure catch (e) {
      return Left(NetworkFailure(e.errMessage));
    } catch (_) {
      return Left(CustomFailure("حدث خطأ أثناء جلب بيانات الأعطال النشطة"));
    }
  }

  Future<Either<Failure, IssueResponseModel>> fetchIssueDetails(
      String issueId) async {
    try {
      final Map<String, dynamic> response = await safeRequest(
          request: () =>
              _supabase.from('Issues').select().eq('id', issueId).single(),
          errorMessage: "فشل الاتصال اثناء جلب بيانات العطل. حاول مرة اخرى.");

      final IssueResponseModel issue = IssueResponseModel.fromJson(response);

      // Fetch media if exists
      final Map<String, dynamic>? mediaResponse = await safeRequest(
          request: () => _supabase
              .from('Media')
              .select()
              .eq('issue_id', issue.id)
              .maybeSingle(),
          errorMessage: "فشل الاتصال اثناء جلب وسائط العطل. حاول مرة اخرى.");

      IssueResponseModel updatedIssue = issue;
      if (mediaResponse != null) {
        updatedIssue = issue.copyWith(
          media: MediaResponseModel.fromJson(mediaResponse),
        );
      }
      return Right(updatedIssue);
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure.fromDatabase(e));
    } on NetworkFailure catch (e) {
      return Left(NetworkFailure(e.errMessage));
    } catch (_) {
      return Left(CustomFailure("حدث خطأ أثناء جلب بيانات العطل"));
    }
  }
}
