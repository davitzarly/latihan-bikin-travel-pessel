import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        actions: [
          TextButton(
            onPressed: () {
              // Implementasi tandai semua sudah dibaca
            },
            child: const Text('Tandai Semua Dibaca'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final bool isUnread = index < 3;
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            color: isUnread ? Colors.blue[50] : Colors.white,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue[100],
                child: const Icon(Icons.notifications, color: Colors.blue),
              ),
              title: Text('Notifikasi ${index + 1}'),
              subtitle: Text('Deskripsi notifikasi ${index + 1}'),
              trailing: Text(
                '${index + 1} jam yang lalu',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              onTap: () {
                // Implementasi aksi notifikasi
              },
            ),
          );
        },
      ),
    );
  }
} 