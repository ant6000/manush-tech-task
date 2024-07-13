import 'dart:io';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();
    checkInternetConnection();
  }

  Future<void> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // If connected to the internet, navigate to HomePage
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // If not connected, show an alert dialog
        _showNoInternetDialog();
      }
    } on SocketException catch (_) {
      // If an error occurs, show an alert dialog
      _showNoInternetDialog();
    }
  }

  void _showNoInternetDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("No Internet Connection"),
          content: const Text("Please check your internet connection and try again."),
          actions: [
            TextButton(
              child: const Text("Retry"),
              onPressed: () {
                Navigator.of(context).pop();
                checkInternetConnection(); // Retry connection check
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Icon(Icons.photo_rounded, color: Colors.blue, size: 200),
      ),
    );
  }
}
