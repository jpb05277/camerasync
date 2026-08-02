import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';
import '../models/models.dart';
import 'session_lobby_page.dart';
import 'watch_page.dart';

class FindSessionPage extends StatelessWidget {
  const FindSessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sessions = [
      PracticeSession(
        id: 's1',
        name: 'Session XTZH',
        code: 'XTZH',
        devicesJoined: 3,
        devicesTotal: 3,
        status: SessionStatus.live,
      ),
      PracticeSession(
        id: 's2',
        name: 'Session QRPL',
        code: 'QRPL',
        devicesJoined: 2,
        devicesTotal: 4,
        status: SessionStatus.ended,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: const AppBottomNav(currentIndex: 3),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Find your session',
                  style: TextStyle(
                      color: AppColors.accent, fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter session code or name',
                  prefixIcon: const Icon(Icons.search, color: Colors.white38),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  itemCount: sessions.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) {
                    final s = sessions[i];
                    return _SessionTile(session: s);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SessionTile extends StatelessWidget {
  final PracticeSession session;
  const _SessionTile({required this.session});

  void _showActions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(session.name,
                style: const TextStyle(
                    color: AppColors.accent, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => WatchPage(sessionName: session.name)));
                },
                child: const Text('Watch Session'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.accent)),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => SessionLobbyPage(session: session)));
                },
                child: const Text('Record Session', style: TextStyle(color: AppColors.accent)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLive = session.status == SessionStatus.live;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => _showActions(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isLive ? AppColors.accent : AppColors.cardBorder),
        ),
        child: Row(
          children: [
            Icon(Icons.videocam, color: isLive ? AppColors.accent : Colors.white38),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(session.name, style: const TextStyle(color: Colors.white, fontSize: 16)),
                  Text(
                    isLive ? 'Live · ${session.devicesJoined} devices' : 'Ended',
                    style: TextStyle(
                        color: isLive ? AppColors.accent : Colors.white38, fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white38),
          ],
        ),
      ),
    );
  }
}
