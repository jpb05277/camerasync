import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import 'session_lobby_page.dart';

class CreateSessionPage extends StatefulWidget {
  const CreateSessionPage({super.key});

  @override
  State<CreateSessionPage> createState() => _CreateSessionPageState();
}

class _CreateSessionPageState extends State<CreateSessionPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController deviceCountController = TextEditingController(text: '2');

  void createSession() {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please name your session')),
      );
      return;
    }

    final total = int.tryParse(deviceCountController.text) ?? 1;
    final session = PracticeSession(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: nameController.text,
      code: (1000 + DateTime.now().second).toString(),
      devicesJoined: 1,
      devicesTotal: total,
      status: SessionStatus.waiting,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => SessionLobbyPage(session: session)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Create A Session')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Create A Session',
                style: TextStyle(
                    color: AppColors.accent, fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            TextField(
              controller: nameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: 'Session Name'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: deviceCountController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: 'Number of Devices'),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: createSession,
                child: const Text('Create'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
