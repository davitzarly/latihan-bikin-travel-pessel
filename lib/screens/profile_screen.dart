import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy, nanti bisa diganti dengan data user dari provider atau backend
    final String name = "Nama Pengguna";
    final String email = "user@email.com";
    final String photoUrl = ""; // Kosong = default avatar

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Navigasi ke halaman edit profil
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundColor: Colors.blue[100],
                  backgroundImage: photoUrl.isNotEmpty ? NetworkImage(photoUrl) : null,
                  child: photoUrl.isEmpty
                      ? const Icon(Icons.person, size: 48, color: Colors.blue)
                      : null,
                ),
                const SizedBox(height: 16),
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                ),
                const SizedBox(height: 16),
                // Statistik sederhana
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStat('Kunjungan', '12'),
                    _buildStat('Favorit', '5'),
                    _buildStat('Ulasan', '3'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Menu profil
          _buildMenuItem(context, Icons.history, 'Riwayat Kunjungan', () {}),
          _buildMenuItem(context, Icons.book_online, 'Pesanan Saya', () {}),
          _buildMenuItem(context, Icons.payment, 'Metode Pembayaran', () {}),
          _buildMenuItem(context, Icons.lock, 'Ubah Password', () {}),
          _buildMenuItem(context, Icons.help, 'Bantuan', () {}),
          _buildMenuItem(context, Icons.delete_forever, 'Hapus Akun', () {
            // TODO: Konfirmasi hapus akun
          }, color: Colors.red),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Logout
            },
            icon: const Icon(Icons.logout),
            label: const Text('Keluar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(48),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, VoidCallback onTap, {Color? color}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icon, color: color ?? Theme.of(context).iconTheme.color),
        title: Text(title, style: TextStyle(color: color)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}