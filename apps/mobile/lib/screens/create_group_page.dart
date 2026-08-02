import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'groups_page.dart';

class CreateGroupPage extends StatefulWidget {
  final bool joinMode;
  const CreateGroupPage({super.key, required this.joinMode});

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  void submit() {
    if ((widget.joinMode && codeController.text.isEmpty) ||
        (!widget.joinMode && nameController.text.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(widget.joinMode ? 'Joined group!' : 'Group created!')),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const GroupsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(widget.joinMode ? 'Join a Group' : 'Create A Group')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.joinMode ? 'Join a group' : 'Choose Your Group',
              style: const TextStyle(
                  color: AppColors.accent, fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            if (widget.joinMode) ...[
              TextField(
                controller: codeController,
                decoration: const InputDecoration(labelText: 'Invite Code'),
                style: const TextStyle(color: Colors.white),
              ),
            ] else ...[
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Group Name'),
                style: const TextStyle(color: Colors.white),
              ),
            ],
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: submit,
                child: Text(widget.joinMode ? 'Join' : 'Create'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
