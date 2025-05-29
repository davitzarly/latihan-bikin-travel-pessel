import 'package:flutter/material.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tema'),
      ),
      body: ListView(
        children: [
          _buildThemeOption(context, 'Sistem', true),
          _buildThemeOption(context, 'Terang', false),
          _buildThemeOption(context, 'Gelap', false),
          const Divider(),
          ListTile(
            title: const Text('Warna Tema'),
            subtitle: Wrap(
              spacing: 8,
              children: [
                _buildColorOption(Colors.blue),
                _buildColorOption(Colors.red),
                _buildColorOption(Colors.green),
                _buildColorOption(Colors.purple),
                _buildColorOption(Colors.orange),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption(BuildContext context, String theme, bool isSelected) {
    return ListTile(
      title: Text(theme),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: Colors.blue)
          : const Icon(Icons.circle_outlined),
      onTap: () {
        // Implementasi perubahan tema
      },
    );
  }

  Widget _buildColorOption(Color color) {
    return GestureDetector(
      onTap: () {
        // Implementasi perubahan warna tema
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey),
        ),
      ),
    );
  }
} 