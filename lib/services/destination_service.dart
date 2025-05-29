import 'package:travel_guide/models/destination.dart';

class DestinationService {
  // Data dummy untuk testing
  final List<Destination> _destinations = [
    Destination(
      id: '1',
      name: 'Pantai Kuta',
      description: 'Pantai terkenal di Bali dengan pasir putih dan ombak yang cocok untuk berselancar.',
      location: 'Kuta, Bali',
      category: 'Pantai',
      rating: 4.5,
      price: 0,
      imageUrl: 'https://picsum.photos/200/300?random=1',
      images: [
        'https://picsum.photos/200/300?random=1',
        'https://picsum.photos/200/300?random=2',
        'https://picsum.photos/200/300?random=3',
      ],
      latitude: -8.7222,
      longitude: 115.1722,
    ),
    Destination(
      id: '2',
      name: 'Gunung Bromo',
      description: 'Gunung berapi aktif yang terkenal dengan pemandangan matahari terbit yang menakjubkan.',
      location: 'Probolinggo, Jawa Timur',
      category: 'Gunung',
      rating: 4.8,
      price: 50000,
      imageUrl: 'https://picsum.photos/200/300?random=4',
      images: [
        'https://picsum.photos/200/300?random=4',
        'https://picsum.photos/200/300?random=5',
        'https://picsum.photos/200/300?random=6',
      ],
      latitude: -7.9425,
      longitude: 112.9530,
    ),
    Destination(
      id: '3',
      name: 'Candi Borobudur',
      description: 'Candi Buddha terbesar di dunia yang menjadi warisan budaya UNESCO.',
      location: 'Magelang, Jawa Tengah',
      category: 'Budaya',
      rating: 4.7,
      price: 75000,
      imageUrl: 'https://picsum.photos/200/300?random=7',
      images: [
        'https://picsum.photos/200/300?random=7',
        'https://picsum.photos/200/300?random=8',
        'https://picsum.photos/200/300?random=9',
      ],
      latitude: -7.6079,
      longitude: 110.2038,
    ),
  ];

  Future<List<Destination>> getDestinations() async {
    // Simulasi loading data dari API
    await Future.delayed(const Duration(milliseconds: 500));
    return _destinations;
  }

  Future<Destination> getDestinationById(String id) async {
    // Simulasi loading data dari API
    await Future.delayed(const Duration(milliseconds: 500));
    return _destinations.firstWhere((d) => d.id == id);
  }

  Future<List<Destination>> getDestinationsByCategory(String category) async {
    // Simulasi loading data dari API
    await Future.delayed(const Duration(milliseconds: 500));
    return _destinations.where((d) => d.category == category).toList();
  }

  Future<List<Destination>> searchDestinations(String query) async {
    // Simulasi loading data dari API
    await Future.delayed(const Duration(milliseconds: 500));
    final lowercaseQuery = query.toLowerCase();
    return _destinations.where((d) {
      return d.name.toLowerCase().contains(lowercaseQuery) ||
          d.location.toLowerCase().contains(lowercaseQuery) ||
          d.description.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }
} 