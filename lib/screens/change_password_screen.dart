import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ubah Password')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(obscureText: true, decoration: const InputDecoration(labelText: 'Password Lama')),
            const SizedBox(height: 16),
            TextField(obscureText: true, decoration: const InputDecoration(labelText: 'Password Baru')),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: () {}, child: const Text('Simpan')),
          ],
        ),
      ),
    );
  }
}