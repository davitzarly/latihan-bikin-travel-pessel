import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../services/destination_service.dart';

class DestinationProvider with ChangeNotifier {
  final DestinationService _service;
  List<Destination> _destinations = [];
  List<String> _favorites = [];
  String _currentCategory = 'Semua';
  String _sortBy = 'name';
  String _searchQuery = '';
  bool _isLoading = false;
  String? _error;

  DestinationProvider(this._service) {
    _loadDestinations();
  }

  List<Destination> get destinations => _destinations;
  List<String> get favorites => _favorites;
  String get currentCategory => _currentCategory;
  String get sortBy => _sortBy;
  bool get isLoading => _isLoading;
  String? get error => _error;

  List<Destination> get popularDestinations {
    // Mengambil 5 destinasi dengan rating tertinggi
    final sorted = List<Destination>.from(_destinations);
    sorted.sort((a, b) => b.rating.compareTo(a.rating));
    return sorted.take(5).toList();
  }

  List<Destination> get nearbyDestinations {
    // TODO: Implementasi logika untuk mendapatkan destinasi terdekat
    // Untuk sementara, mengembalikan 5 destinasi pertama
    return _destinations.take(5).toList();
  }

  List<Destination> get filteredDestinations {
    var filtered = _destinations;

    // Filter berdasarkan kategori
    if (_currentCategory != 'Semua') {
      filtered = filtered.where((d) => d.category == _currentCategory).toList();
    }

    // Filter berdasarkan pencarian
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      filtered = filtered.where((d) {
        return d.name.toLowerCase().contains(query) ||
            d.location.toLowerCase().contains(query) ||
            d.description.toLowerCase().contains(query);
      }).toList();
    }

    // Urutkan hasil
      switch (_sortBy) {
        case 'rating':
        filtered.sort((a, b) => b.rating.compareTo(a.rating));
          break;
        case 'price':
        filtered.sort((a, b) => a.price.compareTo(b.price));
          break;
      case 'name':
        default:
        filtered.sort((a, b) => a.name.compareTo(b.name));
        break;
      }

    return filtered;
  }

  Future<void> _loadDestinations() async {
    try {
    _isLoading = true;
    _error = null;
    notifyListeners();

      _destinations = await _service.getDestinations();
      _error = null;
    } catch (e) {
      _error = 'Gagal memuat data destinasi: $e';
      debugPrint('Error loading destinations: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    await _loadDestinations();
  }

  void setCategory(String category) {
    if (_currentCategory != category) {
      _currentCategory = category;
    notifyListeners();
    }
  }

  void setSortBy(String sortBy) {
    if (_sortBy != sortBy) {
      _sortBy = sortBy;
    notifyListeners();
  }
  }

  void setSearchQuery(String query) {
    if (_searchQuery != query) {
    _searchQuery = query;
    notifyListeners();
  }
  }

  bool isFavorite(String destinationId) {
    return _favorites.contains(destinationId);
  }

  void toggleFavorite(String destinationId) {
    if (_favorites.contains(destinationId)) {
      _favorites.remove(destinationId);
    } else {
      _favorites.add(destinationId);
    }
    notifyListeners();
  }

  List<Destination> getFavoriteDestinations() {
    return _destinations.where((d) => _favorites.contains(d.id)).toList();
  }

  Future<Destination?> getDestinationById(String id) async {
    try {
      return await _service.getDestinationById(id);
    } catch (e) {
      debugPrint('Error getting destination: $e');
      return null;
    }
  }
} 