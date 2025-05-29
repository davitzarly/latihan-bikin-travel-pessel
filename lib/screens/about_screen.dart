import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 120,
                  height: 120,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.travel_explore,
                      size: 120,
                      color: Colors.grey,
                    );
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'Travel Guide',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  'Versi 1.0.0',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.7),
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Deskripsi',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Travel Guide adalah aplikasi yang membantu Anda menemukan destinasi wisata terbaik di Indonesia. Dengan fitur pencarian, favorit, dan ulasan, Anda dapat dengan mudah menemukan tempat wisata yang sesuai dengan keinginan Anda.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          Text(
            'Kontak',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Email'),
            subtitle: const Text('support@travelguide.com'),
            onTap: () {
              _launchUrl('mailto:support@travelguide.com');
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Website'),
            subtitle: const Text('www.travelguide.com'),
            onTap: () {
              _launchUrl('https://www.travelguide.com');
            },
          ),
          const SizedBox(height: 24),
          Text(
            'Sosial Media',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.facebook),
                onPressed: () {
                  _launchUrl('https://www.facebook.com/travelguide');
                },
              ),
              IconButton(
                icon: const Icon(Icons.camera_alt),
                onPressed: () {
                  _launchUrl('https://www.instagram.com/travelguide');
                },
              ),
              IconButton(
                icon: const Icon(Icons.chat),
                onPressed: () {
                  _launchUrl('https://twitter.com/travelguide');
                },
              ),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            '© 2024 Travel Guide. All rights reserved.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withOpacity(0.7),
                ),
          ),
        ],
      ),
    );
  }
} 