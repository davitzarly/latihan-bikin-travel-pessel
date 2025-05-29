import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat'),
      ),
      body: ListView.builder(
        itemCount: 10,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.history, color: Colors.blue),
              ),
              title: Text('Riwayat Kunjungan ${index + 1}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  const Text('Tanggal: 15 Juni 2023'),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      const Text(
                        'Lokasi',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const Spacer(),
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      const Text(
                        '4.5',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward_ios, size: 16),
                onPressed: () {
                  // Implementasi lihat detail riwayat
                },
              ),
            ),
          );
        },
      ),
    );
  }
} 