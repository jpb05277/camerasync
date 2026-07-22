import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget buildCard(BuildContext context, IconData icon, String title) {
    return Card(
      color: Colors.grey[900],
      elevation: 5,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("$title coming soon!")));
        },
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 45, color: Colors.amber),
              const SizedBox(height: 15),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "8Kount",
          style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Welcome!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 25),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                  buildCard(
                    context,
                    Icons.add_circle_outline,
                    "Create Session",
                  ),

                  buildCard(context, Icons.group_add, "Join Session"),

                  buildCard(context, Icons.groups, "My Groups"),

                  buildCard(context, Icons.calendar_month, "Calendar"),

                  buildCard(context, Icons.videocam, "Record"),

                  buildCard(context, Icons.cloud_upload, "Uploads"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
