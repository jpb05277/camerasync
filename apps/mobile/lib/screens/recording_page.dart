import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'watch_page.dart';

class RecordingPage extends StatefulWidget {
  final String sessionName;
  const RecordingPage({super.key, required this.sessionName});

  @override
  State<RecordingPage> createState() => _RecordingPageState();
}

class _RecordingPageState extends State<RecordingPage> {
  bool isRecording = true;
  Duration elapsed = Duration.zero;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (isRecording) {
        setState(() => elapsed += const Duration(seconds: 1));
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String _format(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void _stopRecording() {
    setState(() => isRecording = false);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.card,
        title: const Text('Recording Saved', style: TextStyle(color: Colors.white)),
        content: Text(
          'Your ${_format(elapsed)} recording for ${widget.sessionName} has been saved.',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // close dialog
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => WatchPage(sessionName: widget.sessionName),
                ),
              );
            },
            child: const Text('Review Now', style: TextStyle(color: AppColors.accent)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Placeholder for live camera preview; wire up the `camera`
            // package's CameraPreview widget here once a controller is ready.
            Container(color: Colors.grey.shade900),
            if (isRecording)
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.circle, color: Colors.red, size: 10),
                      const SizedBox(width: 6),
                      Text(_format(elapsed), style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: _stopRecording,
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: Center(
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
