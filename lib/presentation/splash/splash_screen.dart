import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/core/utils/app_assets.dart';
import 'package:photo_gallery/presentation/albums/albums_screen.dart';
import 'package:photo_gallery/presentation/permission_request/permission_request_screen.dart';

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

    if (isPhotoPermissionGranted) {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AlbumsScreen()),
        );
      }
    } else {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PermissionRequestScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset(AppAssets.splashImage)),
    );
  }
}
