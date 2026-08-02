import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';

class WatchPage extends StatefulWidget {
  final String sessionName;
  const WatchPage({super.key, required this.sessionName});

  @override
  State<WatchPage> createState() => _WatchPageState();
}

class _WatchPageState extends State<WatchPage> {
  bool isPlaying = false;
  double progress = 0.0; // 0..1
  final Duration total = const Duration(minutes: 10, seconds: 23);
  final TextEditingController commentController = TextEditingController();

  final List<Comment> comments = [
    const Comment(author: 'Coach J', text: 'Nice sync on the turn here', timestamp: '2:14'),
    const Comment(author: 'Maya', text: 'Should we be more to the right?', timestamp: '3:02'),
  ];

  Duration get currentPosition => total * progress;

  String _format(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(widget.sessionName)),
      body: Column(
        children: [
          // 2x3 grid of camera angles
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                  childAspectRatio: 1.4,
                ),
                itemCount: 6,
                itemBuilder: (context, i) {
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.cardBorder),
                    ),
                    child: Center(
                      child: Icon(Icons.videocam, color: Colors.white24, size: 28),
                    ),
                  );
                },
              ),
            ),
          ),
          // Player controls
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.skip_previous, color: Colors.white70),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                      color: AppColors.accent, size: 36),
                  onPressed: () => setState(() => isPlaying = !isPlaying),
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next, color: Colors.white70),
                  onPressed: () {},
                ),
                Expanded(
                  child: Slider(
                    value: progress,
                    activeColor: AppColors.accent,
                    inactiveColor: Colors.white12,
                    onChanged: (v) => setState(() => progress = v),
                  ),
                ),
                Text(
                  '${_format(currentPosition)} / ${_format(total)}',
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          const Divider(color: AppColors.cardBorder, height: 1),
          // Comments panel
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${comments.length} comments',
                      style: const TextStyle(color: AppColors.accent, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, i) {
                        final c = comments[i];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 14,
                                backgroundColor: AppColors.accent,
                                child: Text(c.author[0],
                                    style: const TextStyle(color: Colors.black, fontSize: 12)),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(c.author,
                                            style: const TextStyle(
                                                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                                        const SizedBox(width: 6),
                                        Text(c.timestamp,
                                            style: const TextStyle(color: Colors.white38, fontSize: 11)),
                                      ],
                                    ),
                                    Text(c.text, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: commentController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(hintText: 'Add a new comment'),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send, color: AppColors.accent),
                        onPressed: () {
                          final text = commentController.text.trim();
                          if (text.isEmpty) return;
                          setState(() {
                            comments.add(Comment(
                              author: 'You',
                              text: text,
                              timestamp: _format(currentPosition),
                            ));
                          });
                          commentController.clear();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
