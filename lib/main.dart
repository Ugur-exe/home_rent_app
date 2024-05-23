import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home_rent/firebase_options.dart';
import 'package:home_rent/res/theme.dart';
import 'package:home_rent/view/startedscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rent Home App',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const StartedScreen(),
    );
  }
}
