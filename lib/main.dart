import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:random_chat/services/auth/auth_gate.dart';
import 'package:random_chat/firebase_options.dart';
import 'package:random_chat/theme/light_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      home: const AuthGate(),
    );
  }
}
