import 'package:flutter/material.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Metode Pembayaran')),
      body: ListView(
        children: [
          ListTile(leading: const Icon(Icons.credit_card), title: const Text('Kartu Kredit')),
          ListTile(leading: const Icon(Icons.account_balance_wallet), title: const Text('E-Wallet')),
        ],
      ),
    );
  }
}