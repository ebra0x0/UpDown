import 'package:UpDown/core/errors/failures.dart';
import 'package:either_dart/either.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepo {
  Stream<Session?> get sessionMonitor;

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, Session>> signInWithPassword(
      {required String email, required String password});

  Future<Either<Failure, Session?>> signUp(
      {required String email, required String password});

  Future<Session?> refreshSession({String? refreshToken});

  Future<Either<Failure, void>> resetPassword({required String email});

  Future<Either<Failure, void>> sendConfirmationEmail(String email);

  Future<String?> getRefreshToken();

  void setRefreshToken(String refreshToken);

  Future<Either<Failure, bool>> isNewAccount();
}
