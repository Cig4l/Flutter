import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuage/data/repositories/auth_repository_impl.dart';
import 'package:nuage/presentation/controllers/onboarding_controller.dart';
import 'package:nuage/presentation/pages/start_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://xrtbvstaflwmuwwafyih.supabase.co',
    publishableKey: 'sb_publishable_5xyeAktbLOo2jp7CqtKYTA_R4uIMfcg',
  );

  final auth = AuthRepositoryImpl(Supabase.instance.client);
  await auth.ensureSignedIn();

  // print('Anon user id: ${Supabase.instance.client.auth.currentUser?.id}');

  await Supabase.instance.client.auth.signOut();    // test
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();                              // test

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nuage',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6C7CE8)),
      ),
      home: const StartPage(),
    );
  }
}
