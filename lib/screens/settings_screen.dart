import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_guide/providers/theme_provider.dart';
import 'package:travel_guide/providers/user_provider.dart';
import 'package:image_picker/image_picker.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // TODO: Implementasi upload gambar ke server
      context.read<UserProvider>().updateProfile(
            profileImage: pickedFile.path,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => _pickImage(context),
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: userProvider.profileImage != null
                                ? NetworkImage(userProvider.profileImage!)
                                : null,
                            child: userProvider.profileImage == null
                                ? const Icon(Icons.person, size: 50)
                                : null,
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      userProvider.name ?? 'Pengguna',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    if (userProvider.email != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        userProvider.email!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.7),
                            ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 32),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit Profil'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // TODO: Navigasi ke halaman edit profil
                },
              ),
              ListTile(
                leading: const Icon(Icons.language),
                title: const Text('Bahasa'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // TODO: Navigasi ke halaman pengaturan bahasa
                },
              ),
              ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text('Notifikasi'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // TODO: Navigasi ke halaman pengaturan notifikasi
                },
              ),
              const Divider(),
              Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
                  return SwitchListTile(
                    secondary: const Icon(Icons.dark_mode),
                    title: const Text('Mode Gelap'),
                    value: themeProvider.isDarkMode,
                    onChanged: (value) {
                      themeProvider.toggleTheme();
                    },
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Keluar'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Keluar'),
                      content: const Text('Apakah Anda yakin ingin keluar?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Batal'),
                        ),
                        TextButton(
                          onPressed: () {
                            userProvider.logout();
                            Navigator.pop(context);
                            // TODO: Navigasi ke halaman login
                          },
                          child: const Text('Keluar'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
} 