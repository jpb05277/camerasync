import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import 'recording_countdown_page.dart';

class SessionLobbyPage extends StatefulWidget {
  final PracticeSession session;
  const SessionLobbyPage({super.key, required this.session});

  @override
  State<SessionLobbyPage> createState() => _SessionLobbyPageState();
}

class _SessionLobbyPageState extends State<SessionLobbyPage> {
  @override
  Widget build(BuildContext context) {
    final s = widget.session;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Session Lobby')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              s.name,
              style: const TextStyle(
                  color: AppColors.accent, fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Session code: ${s.code}',
                style: const TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: Column(
                children: [
                  const Text('Looking for devices...',
                      style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 12),
                  Text(
                    '${s.devicesJoined} / ${s.devicesTotal} devices joined',
                    style: const TextStyle(
                        color: AppColors.accent, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: s.devicesTotal == 0 ? 0 : s.devicesJoined / s.devicesTotal,
                    backgroundColor: Colors.white12,
                    color: AppColors.accent,
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RecordingCountdownPage(sessionName: s.name),
                    ),
                  );
                },
                child: const Text('Start Recording'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.white30)),
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
