import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peta'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: () {
              // Implementasi lokasi saat ini
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Placeholder untuk peta
          Container(
            color: Colors.grey[200],
            child: const Center(
              child: Icon(
                Icons.map,
                size: 100,
                color: Colors.grey,
              ),
            ),
          ),
          // Panel pencarian
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Cari lokasi...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        // Implementasi hapus pencarian
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Panel destinasi terdekat
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
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
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Destinasi Terdekat',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Lihat Semua',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(16),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 150,
                          margin: const EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12),
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(Icons.image, size: 40),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Destinasi ${index + 1}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on, size: 12, color: Colors.grey),
                                        const SizedBox(width: 4),
                                        const Text(
                                          '1.2 km',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Filter Peta'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.category),
                title: const Text('Kategori'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Implementasi filter kategori
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.star),
                title: const Text('Rating'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Implementasi filter rating
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.attach_money),
                title: const Text('Harga'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Implementasi filter harga
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.access_time),
                title: const Text('Jam Operasional'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Implementasi filter jam operasional
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                // Implementasi terapkan filter
                Navigator.pop(context);
              },
              child: const Text('Terapkan'),
            ),
          ],
        );
      },
    );
  }
} 