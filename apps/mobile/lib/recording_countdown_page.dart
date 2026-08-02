import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'recording_page.dart';

class RecordingCountdownPage extends StatefulWidget {
  final String sessionName;
  const RecordingCountdownPage({super.key, required this.sessionName});

  @override
  State<RecordingCountdownPage> createState() => _RecordingCountdownPageState();
}

class _RecordingCountdownPageState extends State<RecordingCountdownPage> {
  int count = 3;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        if (count <= 1) {
          t.cancel();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => RecordingPage(sessionName: widget.sessionName),
            ),
          );
        } else {
          count--;
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Placeholder for live camera preview; wire up the `camera`
          // package's CameraPreview widget here once a controller is ready.
          Container(color: Colors.grey.shade900),
          Center(
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.black87,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.accent, width: 3),
              ),
              child: Center(
                child: Text(
                  '$count',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: const Text(
              'Recording Starts in',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
