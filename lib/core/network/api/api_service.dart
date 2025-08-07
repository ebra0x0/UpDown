import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:UpDown/core/network/api/api_constants.dart';
import 'package:UpDown/core/network/api/api_failure.dart';
import 'package:UpDown/core/network/api/api_init.dart';
import 'package:UpDown/core/network/network_manager.dart';
import 'package:UpDown/core/utils/helper/safe_request.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/helper/media_compressor.dart';
import 'package:UpDown/core/utils/model/media_models/media_request_model.dart';
import 'package:UpDown/features/auth/data/model/auth_response_model.dart';
import 'package:UpDown/features/profile/data/model/profile_request_model.dart';
import 'package:UpDown/core/utils/helper/storage_path.dart';
import 'package:UpDown/features/issues/data/models/issue_request_model.dart';
import 'package:UpDown/features/auth/data/model/auth_request_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ApiService {
  final ApiInitializer _apiInitializer;
  final NetworkManager _netManager;

  ApiService(this._netManager, this._apiInitializer);

  SupabaseClient get _supabase => _apiInitializer.client;
  User? get user => _supabase.auth.currentUser;
  Session? get session => _supabase.auth.currentSession;

  bool get isConnected => _netManager.isConnected;

  void _ensureInitialized() => _apiInitializer.ensureInitialized();

  // Auth Functions
  Stream<AuthResponseModel> authStateStream() async* {
    _ensureInitialized();
    if (!isConnected) {
      yield AuthResponseModel(
        status: AuthStatus.error,
        session: null,
        user: null,
      );
      return;
    }
    yield* _supabase.auth.onAuthStateChange
        .map((authState) => AuthResponseModel.fromAuthState(authState));
  }

  Future<AuthResponseModel> signUp(AuthRequestModel user) async {
    try {
      _ensureInitialized();
      final AuthResponse res = await safeRequest(
        networkManager: _netManager,
        request: () => _supabase.auth.signUp(
          email: user.email,
          password: user.password,
        ),
      );

      final AuthResponseModel authResponseModel =
          AuthResponseModel.fromAuthResponse(res);

      return authResponseModel;
    } on AuthException catch (e) {
      throw (SupabaseFailure.fromAuth(e));
    } on NetworkFailure catch (e) {
      throw (NetworkFailure(e.errMessage));
    } catch (e) {
      log(e.toString());
      throw (CustomFailure("تعذر انشاء الحساب"));
    }
  }

  Future<AuthResponseModel> signInWithPassword(AuthRequestModel user) async {
    try {
      _ensureInitialized();
      final AuthResponse res = await safeRequest(
        networkManager: _netManager,
        request: () => _supabase.auth.signInWithPassword(
          email: user.email,
          password: user.password,
        ),
      );

      final AuthResponseModel authResponseModel =
          AuthResponseModel.fromAuthResponse(res);

      return authResponseModel;
    } on AuthException catch (e) {
      throw (SupabaseFailure.fromAuth(e));
    } on NetworkFailure catch (e) {
      throw (NetworkFailure(e.errMessage));
    } catch (e) {
      throw (CustomFailure("تعذر تسجيل الدخول"));
    }
  }

  Future<void> signOut() async {
    try {
      _ensureInitialized();
      await safeRequest(
          networkManager: _netManager,
          request: () => _supabase.auth.signOut(),
          errorMessage: "تعذر تسجيل الخروج");
    } on AuthException catch (e) {
      throw (SupabaseFailure.fromAuth(e));
    } on NetworkFailure catch (e) {
      throw (NetworkFailure(e.errMessage));
    } catch (e) {
      log(e.toString());
      throw (CustomFailure("تعذر تسجيل الخروج"));
    }
  }

  Future<Session?> refreshSession(String refreshToken) async {
    try {
      _ensureInitialized();
      final AuthResponse newSession = await safeRequest(
        networkManager: _netManager,
        request: () => _supabase.auth.refreshSession(refreshToken),
      );

      return newSession.session;
    } on AuthException catch (e) {
      throw (SupabaseFailure.fromAuth(e));
    } on NetworkFailure catch (e) {
      throw (NetworkFailure(e.errMessage));
    } catch (e) {
      throw (CustomFailure("تعذر تحديث الجلسة"));
    }
  }

  Future<void> sendConfirmationEmail(String email) async {
    try {
      _ensureInitialized();

      await safeRequest(
          networkManager: _netManager,
          request: () =>
              _supabase.auth.resend(type: OtpType.signup, email: email),
          errorMessage: "تعذر ارسال رمز التفعيل");
    } on AuthException catch (e) {
      throw (SupabaseFailure.fromAuth(e));
    } on NetworkFailure catch (e) {
      throw (NetworkFailure(e.errMessage));
    } catch (e) {
      log(e.toString());
      throw (CustomFailure("تعذر ارسال رمز التفعيل"));
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      _ensureInitialized();

      await safeRequest(
          networkManager: _netManager,
          request: () => _supabase.auth.resetPasswordForEmail(email),
          errorMessage: "تعذر استعادة كلمة المرور");
    } on AuthException catch (e) {
      throw (SupabaseFailure.fromAuth(e));
    } on NetworkFailure catch (e) {
      throw (NetworkFailure(e.errMessage));
    } catch (e) {
      log(e.toString());
      throw (CustomFailure("تعذر استعادة كلمة المرور"));
    }
  }

  // User Functions
  Future<void> createProfile(ProfileRequestModel profile) async {
    try {
      _ensureInitialized();

      // Check if profile already exists
      final isNew = await isNewAccount();

      if (!isNew) {
        throw "المستخدم مسجل بالفعل";
      }

      // Upload avatar if exists

      if (profile.imagePath != null) {
        final uploadResult = await _uploadAvatar(XFile(profile.imagePath!));

        // Update profile model
        final String? userEmail = _supabase.auth.currentUser?.email;
        final String avatarPath =
            uploadResult.replaceFirst(RegExp(r'^[^/]+/[^/]+/'), '');

        profile = profile.copyWith(email: userEmail, imagePath: avatarPath);
      }

      // Insert profile into database
      await safeRequest(
        networkManager: _netManager,
        request: () => _supabase.from('Users').insert(profile.toJson()),
        errorMessage: "فشل الاتصال اثناء انشاء بيانات المستخدم. حاول مرة اخرى",
      );
    } on PostgrestException catch (e) {
      throw (SupabaseFailure.fromDatabase(e));
    } on NetworkFailure catch (e) {
      throw (NetworkFailure(e.errMessage));
    } catch (e) {
      throw (CustomFailure(e.toString()));
    }
  }

  Future<bool> isNewAccount() async {
    try {
      _ensureInitialized();
      final bool isNewAccount = await safeRequest(
        networkManager: _netManager,
        request: () => _supabase.rpc("is_new_account"),
      );

      return isNewAccount;
    } on PostgrestException catch (e) {
      throw (SupabaseFailure.fromDatabase(e));
    } on NetworkFailure catch (e) {
      throw (NetworkFailure(e.errMessage));
    } catch (e) {
      throw (CustomFailure(e.toString()));
    }
  }

  Stream<Map<String, dynamic>?> streamProfile() async* {
    _ensureInitialized();
    if (!isConnected) {
      yield null;
    }

    yield* _supabase
        .from("Users")
        .stream(primaryKey: ["id"])
        .eq("id", _supabase.auth.currentUser!.id)
        .asyncMap((stream) async {
          if (stream.isEmpty) {
            return null;
          }
          final Map<String, dynamic> res = stream.first;
          // Check if image_path exists and download it
          if (res["image_path"] != null) {
            // Download avatar
            final avatarPath = await _downloadAvatar(res["image_path"]);

            res["image_path"] = avatarPath;
          }

          return res;
        })
        .distinct();
  }

  Future<String> _downloadAvatar(String imagePath) async {
    try {
      final Uint8List response = await safeRequest(
          networkManager: _netManager,
          request: () => _supabase.storage
              .from(ApiConstants.avatarsBucket)
              .download("${ApiConstants.avatarsBucketFolder}/$imagePath"),
          errorMessage: "فشل الاتصال اثناء تحميل صورة الملف الشخصي.");

      final Directory dir = await getApplicationDocumentsDirectory();

      final String filePath = '${dir.path}/${imagePath.split('/').last}';

      final file = File(filePath);
      await file.writeAsBytes(response);

      return file.path;
    } on StorageException catch (e) {
      throw (SupabaseFailure.fromStorage(e));
    } on NetworkFailure catch (e) {
      throw (NetworkFailure(e.errMessage));
    } catch (_) {
      throw (CustomFailure("حدث خطاء اثناء تحميل صورة الملف الشخصي"));
    }
  }

  Future<String> _uploadAvatar(XFile file) async {
    try {
      // Upload avatar
      final uploadResult = await _uploadMedia(
        bucketName: ApiConstants.avatarsBucket,
        filePath: file.path,
        storagePath: StoragePath.fromAvatar(
                filePath: file.path, userId: _supabase.auth.currentUser!.id)
            .path,
        mediaType: MediaType.image,
      );

      return uploadResult;
    } catch (_) {
      throw "تعذر رفع صورة الملف الشخصي";
    }
  }

  Future<void> updateProfile(ProfileRequestModel profile) async {
    try {
      _ensureInitialized();
      if (profile.imagePath != null) {
        final uploadResult = await _uploadAvatar(XFile(profile.imagePath!));

        final String avatarPath = uploadResult.replaceFirst(
          RegExp(r'^[^/]+/[^/]+/'),
          '',
        );

        profile = profile.copyWith(imagePath: avatarPath);
      }

      await safeRequest(
          networkManager: _netManager,
          request: () => _supabase
              .from('Users')
              .update(profile.toJson())
              .eq("id", _supabase.auth.currentUser!.id));
    } on PostgrestException catch (e) {
      throw (SupabaseFailure.fromDatabase(e));
    } on NetworkFailure catch (e) {
      throw (NetworkFailure(e.errMessage));
    } catch (e) {
      throw (CustomFailure(e.toString()));
    }
  }

  // Buildings
  Stream<List<Map<String, dynamic>>> streamUserBuildings() async* {
    _ensureInitialized();
    if (!isConnected) {
      yield [];
    }
    yield* _supabase
        .from("Buildings")
        .stream(primaryKey: ["id"])
        .eq("owner_id", _supabase.auth.currentUser!.id)
        .distinct();
  }

  Stream<Map<String, dynamic>?> streamBuildingDetails(
      {required String buildingId}) async* {
    _ensureInitialized();
    if (!isConnected) {
      yield null;
    }
    yield* _supabase
        .from('Buildings')
        .stream(primaryKey: ["id"])
        .eq('id', buildingId)
        .map((list) => list.isNotEmpty ? list.first : null)
        .distinct();
  }

  // Elevators

  Stream<Map<String, dynamic>?> streamElevatorDetails(
      String elevatorId) async* {
    _ensureInitialized();

    if (!isConnected) {
      yield null;
    }
    yield* _supabase
        .from('Elevators')
        .stream(primaryKey: ["id"])
        .eq('id', elevatorId)
        .asyncMap((list) async {
          final buildingName = await _supabase
              .from("Buildings")
              .select("name")
              .eq("id", list.first["building_id"])
              .single();
          if (list.isEmpty) {
            return null;
          }
          return list.first..addAll({"building_name": buildingName["name"]});
        })
        .distinct();
  }

  Stream<List<Map<String, dynamic>>> streamBuildingElevators(
      String buildingId) async* {
    _ensureInitialized();
    if (!isConnected) {
      yield [];
    }
    yield* _supabase
        .from('Elevators')
        .stream(primaryKey: ["id"])
        .eq('building_id', buildingId)
        .distinct();
  }

  Stream<List<Map<String, dynamic>>> streamBuildingsElevators(
      List<String> buildingIds) async* {
    _ensureInitialized();
    if (!isConnected) {
      yield [];
    }

    yield* _supabase
        .from('Elevators')
        .stream(primaryKey: ["id"])
        .inFilter('building_id', buildingIds)
        .distinct();
  }

  // Issues
  Future<void> createIssue(IssueRequestModel issueReq) async {
    try {
      _ensureInitialized();
      // Create issue
      final Map<String, dynamic> issueIdRes = await safeRequest(
          networkManager: _netManager,
          request: () =>
              _supabase.rpc("create_issue", params: issueReq.toJson()).single(),
          errorMessage: "فشل الاتصال اثناء انشاء العطل.");
      //////

      // Update issue model with ids
      issueReq = issueReq.copyWith(
          id: issueIdRes["issue_id"], reportId: issueIdRes["report_id"]);

      if (issueReq.mediaList.isEmpty) return;
      //////

      try {
        // Upload and insert media list
        await _uploadAndInsertIssueMediaList(
          mediaList: issueReq.mediaList,
          issueId: issueReq.id!,
          reportId: issueReq.reportId!,
        );
      } catch (e) {
        // If media creation fails, delete issue
        try {
          await safeRequest(
            networkManager: _netManager,
            request: () =>
                _supabase.from('Issues').delete().eq('id', issueReq.id!),
          );
        } catch (_) {}
        throw (CustomFailure("حدث خطاء اثناء رفع الوسائط"));
      }
    } on PostgrestException catch (e) {
      throw (SupabaseFailure.fromDatabase(e));
    } on NetworkFailure catch (e) {
      throw (NetworkFailure(e.errMessage));
    } catch (_) {
      throw (CustomFailure("حدث خطأ أثناء إنشاء العطل"));
    }
  }

  Future<void> _uploadAndInsertIssueMediaList({
    required List<MediaRequestModel> mediaList,
    required String issueId,
    required String reportId,
  }) async {
    await Future.wait(mediaList.map((media) async {
      // 1. توليد مسار التخزين
      final String storagePath = StoragePath.withIssue(
        media: media,
        reportId: reportId,
        issueId: issueId,
      ).path;

      // 2. رفع الميديا
      final uploadResult = await _uploadMedia(
        bucketName: ApiConstants.reportsBucket,
        filePath: media.file!.path,
        storagePath: storagePath,
        mediaType: MediaType.image,
      );

      // 3. استخراج رابط الميديا بعد الرفع
      final String mediaUrl =
          uploadResult.replaceFirst(RegExp(r'^[^/]+/[^/]+/'), '');

      // 4. تحديث بيانات الميديا
      final MediaRequestModel mediaWithUrl =
          media.copyWith(url: mediaUrl, issueId: issueId);

      // 5. إدخال الميديا في قاعدة البيانات
      await safeRequest(
        networkManager: _netManager,
        request: () => _supabase.from('Media').insert(mediaWithUrl.toJson()),
      );
    }));
  }

  Future<String> _uploadMedia(
      {required String bucketName,
      required String filePath,
      required String storagePath,
      required MediaType mediaType}) async {
    // Compress file
    final MediaCompressor mediaCompressor = mediaType == MediaType.image
        ? ImageCompressorService()
        : VideoCompressorService();
    final String compressedPath = await mediaCompressor.compress(filePath);

    final File compressedFile = File(compressedPath);

    // Upload to bucket
    final String url = await safeRequest(
        networkManager: _netManager,
        request: () => _supabase.storage.from(bucketName).upload(
              storagePath,
              compressedFile,
              fileOptions: FileOptions(
                upsert: true,
              ),
            ),
        errorMessage: "فشل الاتصال اثناء رفع الملف.");

    return url;
  }

  Future<Map<String, dynamic>?> _fetchMedia(String mediaId) async {
    final Map<String, dynamic>? response = await safeRequest(
        networkManager: _netManager,
        request: () =>
            _supabase.from('Media').select().eq('id', mediaId).maybeSingle(),
        errorMessage: "فشل الاتصال اثناء جلب الملف.");

    return response;
  }

  Stream<List<Map<String, dynamic>>> streamBuildingActiveIssues(
      String buildingId) async* {
    _ensureInitialized();
    if (!isConnected) {
      yield [];
    }

    yield* _supabase
        .from('Issues')
        .stream(primaryKey: ["id"])
        .eq('building_id', buildingId)
        .distinct();
  }

  Stream<List<Map<String, dynamic>>> streamElevatorActiveIssues(
      String elevatorId) async* {
    _ensureInitialized();
    if (!isConnected) {
      yield [];
    }
    yield* _supabase
        .from('Issues')
        .stream(primaryKey: ["id"])
        .eq('elevator_id', elevatorId)
        .distinct();
  }

  Stream<List<Map<String, dynamic>>> streamAllActiveIssues() async* {
    _ensureInitialized();

    if (!isConnected) {
      yield [];
    }

    yield* _supabase
        .from('Issues')
        .stream(primaryKey: ["id"])
        .eq('user_id', _supabase.auth.currentUser!.id)
        .distinct();
  }

  Stream<Map<String, dynamic>?> fetchIssueDetails(String issueId) async* {
    _ensureInitialized();

    if (!isConnected) {
      yield null;
    }

    yield* _supabase
        .from('Issues')
        .stream(primaryKey: ["id"])
        .eq('id', issueId)
        .asyncMap((list) async {
          if (list.isEmpty) {
            return null;
          }
          final Map<String, dynamic> issue = list.first;

          // Fetch media for the issue
          final List<Map<String, dynamic>?> mediaList = await Future.wait(
              (issue["media_urls"] as List)
                  .map((mediaUrl) async => await _fetchMedia(mediaUrl)));

          issue["media_list"] = mediaList;

          return issue;
        })
        .distinct();
  }
}
