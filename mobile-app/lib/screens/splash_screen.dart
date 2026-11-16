import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../theme/billy_colors.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() {
    _controller = VideoPlayerController.asset('assets/animations/billyv.mp4')
      ..initialize().then((_) {
        setState(() {
          _initialized = true;
        });
        _controller.play();
        _controller.setLooping(false);
        
        // Listen for video end
        _controller.addListener(() {
          if (_controller.value.position >= _controller.value.duration) {
            _navigateToHome();
          }
        });
      }).catchError((error) {
        debugPrint("Error initializing video: $error");
        // Fallback navigation if video fails
        Timer(const Duration(seconds: 3), _navigateToHome);
      });
  }

  void _navigateToHome() {
    // Prevent multiple navigations
    if (!mounted) return;
    
    // Navigate to Login Screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BillyColors.background,
      body: Center(
        child: _initialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : const CircularProgressIndicator(
                color: BillyColors.primary, // Purple loader while video inits
              ),
      ),
    );
  }
}


