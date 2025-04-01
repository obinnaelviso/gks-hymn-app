import 'package:flutter/material.dart';
import 'package:gks_hymn/views/preface_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const route = "/splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void exitSplash() async {
    await Future.delayed(const Duration(
      milliseconds: 3000,
    ));
    if (mounted) {
      Navigator.pushReplacementNamed(context, PrefaceScreen.route);
    }
  }

  @override
  void initState() {
    super.initState();
    exitSplash();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/tsp-logo.png",
            width: 100,
            height: 100,
          ),
          const SizedBox(height: 20.0),
          const Center(
            child: Text(
              "THEOCRATIC SONGS OF PRAISE",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.black87,
                  fontSize: 18),
            ),
          ),
          const Center(
            child: Text(
              "(GKS HYMN)",
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.black87,
                  fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
