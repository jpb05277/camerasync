import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';
import '../models/models.dart';
import 'session_lobby_page.dart';
import 'create_session_page.dart';
import 'watch_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String userName = 'Ryan';

  @override
  Widget build(BuildContext context) {
    final recentRecordings = <Recording>[
      const Recording(id: '1', title: 'Team Run', duration: Duration(minutes: 12)),
      const Recording(id: '2', title: 'Solo Cam', duration: Duration(minutes: 8)),
      const Recording(id: '3', title: 'Group #4', duration: Duration(minutes: 15)),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: const AppBottomNav(currentIndex: 2),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good afternoon, $userName',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Let's capture something great today",
                style: TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 20),
              _LiveSessionCard(
                session: PracticeSession(
                  id: 'live-1',
                  name: 'Dance Practice',
                  code: 'XTZH',
                  devicesJoined: 3,
                  devicesTotal: 3,
                  status: SessionStatus.live,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.fiber_manual_record),
                  label: const Text('Record a practice'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CreateSessionPage()),
                    );
                  },
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Recent Recordings',
                style: TextStyle(
                  color: AppColors.accent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 90,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: recentRecordings.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, i) {
                    final r = recentRecordings[i];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const WatchPage(sessionName: 'Session Review')),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 70,
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppColors.card,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.cardBorder),
                            ),
                            child: const Icon(Icons.play_circle_fill, color: AppColors.accent),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            r.title,
                            style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 28),
              Row(
                children: const [
                  _StatBlock(value: '4', label: 'Groups'),
                  SizedBox(width: 12),
                  _StatBlock(value: '18', label: 'Sessions'),
                  SizedBox(width: 12),
                  _StatBlock(value: '127', label: 'Videos'),
                ],
              ),
              const SizedBox(height: 28),
              const Text(
                'Notifications',
                style: TextStyle(
                  color: AppColors.accent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              const _NotificationTile(text: 'John invited you to Elite Crew'),
              const _NotificationTile(text: 'Practice starts in 15 min'),
              const SizedBox(height: 8),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text('View all', style: TextStyle(color: AppColors.accent)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LiveSessionCard extends StatelessWidget {
  final PracticeSession session;
  const _LiveSessionCard({required this.session});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.circle, color: Colors.red, size: 10),
                    SizedBox(width: 6),
                    Text('Live now', style: TextStyle(color: Colors.black87, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  session.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${session.devicesTotal} Devices connected',
                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: AppColors.accent,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SessionLobbyPage(session: session)),
              );
            },
            child: const Text('Join'),
          ),
        ],
      ),
    );
  }
}

class _StatBlock extends StatelessWidget {
  final String value;
  final String label;
  const _StatBlock({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Column(
          children: [
            Text(value,
                style: const TextStyle(
                    color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final String text;
  const _NotificationTile({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        children: [
          const Icon(Icons.notifications, color: AppColors.accent, size: 18),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(color: Colors.white70))),
        ],
      ),
    );
  }
}
