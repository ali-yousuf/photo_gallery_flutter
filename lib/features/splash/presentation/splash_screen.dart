import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      _navigateToNextScreen();
    });
  }

  Future<void> _navigateToNextScreen() async {
    final isPhotoPermissionGranted = await Permission.photos.isGranted;
    debugPrint(isPhotoPermissionGranted.toString());
    if (isPhotoPermissionGranted) {
      // TODO: navigate to albums screen
    } else {
      // TODO: navigate to permission request screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset("assets/images/splash.png")),
    );
  }
}
