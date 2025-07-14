import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> storeUserData(String firstName, String lastName, String gender, int age, String goal, String activityLevel) async {
  final supabase = Supabase.instance.client;
  final user = supabase.auth.currentUser;

  if (user == null) throw Exception('User not authenticated');

  String fullName = '$firstName $lastName';

  final response = await supabase.from('users').insert([
    {
      'id': user.id, // Add user ID
      'full_name': fullName, // Correct column name
      'gender': gender,
      'age': age,
      'goal': goal,
      'activity_level': activityLevel,
    }
  ]);

  if (response.error != null) {
    throw Exception('Error storing data: ${response.error!.message}');
  }
}

Future<PostgrestMap?> fetchUserData() async {
  final supabase = Supabase.instance.client;
  final user = supabase.auth.currentUser;

  if (user == null) throw Exception('User not authenticated');

  final response = await supabase
      .from('users')
      .select('full_name, gender, age, goal, activity_level')
      .eq('id', user.id)
      .maybeSingle();

  return response;
}