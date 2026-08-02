import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';
import '../models/models.dart';
import 'create_group_page.dart';
import 'find_session_page.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final groups = <Group>[
      const Group(id: '1', name: 'Team Knights', color: AppColors.teamYellow, memberCount: 12),
      const Group(id: '2', name: 'Team Cheer', color: AppColors.teamRed, memberCount: 8),
      const Group(id: '3', name: 'Team Citronaut', color: AppColors.teamPurple, memberCount: 10),
      const Group(id: '4', name: 'Team Knights JV', color: AppColors.teamTeal, memberCount: 9),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Choose Your Group', style: TextStyle(
                color: AppColors.accent, fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text('Select a team to view sessions and recordings',
                  style: TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search groups',
                  prefixIcon: const Icon(Icons.search, color: Colors.white38),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.group_add, color: AppColors.accent),
                      label: const Text('Join a Group', style: TextStyle(color: AppColors.accent)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.accent),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const CreateGroupPage(joinMode: true)));
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.add),
                      label: const Text('Create'),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const CreateGroupPage(joinMode: false)));
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  itemCount: groups.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) {
                    final g = groups[i];
                    return _GroupTile(group: g);
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

class _GroupTile extends StatelessWidget {
  final Group group;
  const _GroupTile({required this.group});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const FindSessionPage()));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: group.color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                group.name,
                style: const TextStyle(
                    color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            Text('${group.memberCount} members',
                style: const TextStyle(color: Colors.black54, fontSize: 12)),
            const SizedBox(width: 6),
            const Icon(Icons.chevron_right, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}
