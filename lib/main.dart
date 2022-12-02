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

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Theocratic Songs of Praise (GKS HYMN)',
        theme: ThemeData(
          primarySwatch: createMaterialColor(Colors.white60),
        ),
        initialRoute: SplashScreen.route,
        routes: {
          SplashScreen.route: (context) => const SplashScreen(),
          PrefaceScreen.route: (context) => const PrefaceScreen(),
          HymnsScreen.route: (context) => const HymnsScreen(),
        });
  }
}
