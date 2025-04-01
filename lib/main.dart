import 'package:flutter/material.dart';
import 'package:gks_hymn/views/hymns_screen.dart';
import 'package:gks_hymn/views/preface_screen.dart';
import 'package:gks_hymn/views/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Theocratic Songs of Praise (GKS HYMN)',
        theme: ThemeData(
          primaryColor: Colors.white60,
        ),
        initialRoute: SplashScreen.route,
        routes: {
          SplashScreen.route: (context) => const SplashScreen(),
          PrefaceScreen.route: (context) => const PrefaceScreen(),
          HymnsScreen.route: (context) => const HymnsScreen(),
        });
  }
}
