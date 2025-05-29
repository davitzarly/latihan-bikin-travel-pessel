import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pemesanan'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Aktif'),
            Tab(text: 'Selesai'),
            Tab(text: 'Dibatalkan'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBookingList(true),
          _buildBookingList(false),
          _buildBookingList(false),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showBookingDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBookingList(bool isActive) {
    return ListView.builder(
      itemCount: 5,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Column(
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
                child: const Center(
                  child: Icon(Icons.image, size: 50),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Destinasi ${index + 1}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: isActive ? Colors.green[100] : Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            isActive ? 'Aktif' : 'Selesai',
                            style: TextStyle(
                              color: isActive ? Colors.green[700] : Colors.grey[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Tanggal Kunjungan: 15 Juni 2023',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Jumlah Tiket: 2',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Total: Rp 200.000',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            // Implementasi lihat detail
                          },
                          icon: const Icon(Icons.visibility),
                          label: const Text('Lihat Detail'),
                        ),
                        if (isActive)
                          ElevatedButton.icon(
                            onPressed: () {
                              // Implementasi batalkan pemesanan
                            },
                            icon: const Icon(Icons.cancel),
                            label: const Text('Batalkan'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[50],
                              foregroundColor: Colors.red,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showBookingDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Pemesanan Baru',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Destinasi',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.place),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Tanggal Kunjungan',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.calendar_today),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Jumlah Tiket',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.confirmation_number),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Implementasi proses pemesanan
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Pesan Sekarang'),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
} 