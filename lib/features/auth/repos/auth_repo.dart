import 'package:UpDown/core/network/api_failure.dart';
import 'package:UpDown/core/utils/model/user_credentials_model.dart';
import 'package:either_dart/either.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepo {
  Stream<Session?> get sessionMonitor;

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, Session>> signInWithPassword(
      {required UserCredentialsModel credentials});

  Future<Either<Failure, Session?>> signUp(
      {required UserCredentialsModel credentials});

  Future<Session?> refreshSession(String refreshToken);

  Future<Either<Failure, void>> resetPassword({required String email});

  Future<Either<Failure, void>> sendConfirmationEmail(String email);

  Future<String?> getRefreshToken();

  void setRefreshToken(String refreshToken);

  Future<Either<Failure, bool>> isNewAccount();
}
