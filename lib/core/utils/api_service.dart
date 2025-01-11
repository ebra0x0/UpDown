import 'package:UpDown/core/utils/model/user_model.dart';
import 'package:UpDown/features/auth/data/auth_user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ApiService {
  ApiService();
  final supabase = Supabase.instance.client;

  Future<void> signUp(AuthUserModel user) async {
    await supabase.auth
        .signUp(
      email: user.email,
      password: user.password,
    )
        .then((value) async {
      String? userId = value.user?.id;

      if (userId == null) return;
      try {
        UserModel newUser =
            UserModel(id: userId, email: value.user!.email, name: user.name);
        await createUserData(newUser);
      } catch (e) {
        throw Exception(e.toString());
      }
    });
  }

  Future<void> signInWithPassword(
      {required String email, required String password}) async {
    await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  Future<void> resetPassword({required String email}) async {
    await supabase.auth.resetPasswordForEmail(email);
  }

  Future<void> createUserData(UserModel user) async {
    await supabase.from('Users').insert({
      "id": user.id,
      'name': user.name,
      'email': user.email,
    });
  }
}
