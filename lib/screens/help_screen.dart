import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bantuan')),
      body: ListView(
        children: const [
          ListTile(title: Text('Bagaimana cara memesan?'), subtitle: Text('Pilih destinasi, klik pesan, dan ikuti instruksi.')),
          ListTile(title: Text('Bagaimana menghubungi CS?'), subtitle: Text('Email ke support@travelguide.com')),
        ],
      ),
    );
  }
}