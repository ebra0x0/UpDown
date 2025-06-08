import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> apiSetup() async {
  const String supabaseUrl = "https://oanydzbrdjasqbxvobhu.supabase.co";
  const String supabaseKey =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9hbnlkemJyZGphc3FieHZvYmh1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzYwOTgzODAsImV4cCI6MjA1MTY3NDM4MH0.PwKij6KclXUD3lmJdYErbqYFQ3WbxUe4iP_K3Fkxveo";

  try {
    Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseKey,
    );
  } catch (e) {
    throw Exception(e.toString());
  }
}
