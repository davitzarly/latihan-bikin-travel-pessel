import 'package:flutter/material.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pesanan Saya')),
      body: ListView(
        children: List.generate(3, (i) => ListTile(
          leading: const Icon(Icons.receipt_long),
          title: Text('Pesanan #00${i + 1}'),
          subtitle: const Text('Status: Selesai'),
        )),
      ),
    );
  }
}