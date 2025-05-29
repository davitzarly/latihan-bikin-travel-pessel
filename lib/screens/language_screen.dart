import 'package:flutter/material.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bahasa'),
      ),
      body: ListView(
        children: [
          _buildLanguageOption(context, 'Indonesia', true),
          _buildLanguageOption(context, 'English', false),
          _buildLanguageOption(context, '日本語', false),
          _buildLanguageOption(context, '한국어', false),
          _buildLanguageOption(context, '中文', false),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(BuildContext context, String language, bool isSelected) {
    return ListTile(
      title: Text(language),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: Colors.blue)
          : const Icon(Icons.circle_outlined),
      onTap: () {
        // Implementasi perubahan bahasa
      },
    );
  }
} 