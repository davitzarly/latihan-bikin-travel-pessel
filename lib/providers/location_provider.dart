import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider extends ChangeNotifier {
  Position? _currentPosition;
  String? _errorMessage;

  Position? get currentPosition => _currentPosition;
  String? get errorMessage => _errorMessage;

  Future<void> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _errorMessage = 'Layanan lokasi tidak aktif';
        notifyListeners();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _errorMessage = 'Izin lokasi ditolak';
          notifyListeners();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _errorMessage = 'Izin lokasi ditolak secara permanen';
        notifyListeners();
        return;
      }

      _currentPosition = await Geolocator.getCurrentPosition();
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Gagal mendapatkan lokasi: $e';
      notifyListeners();
    }
  }

  double calculateDistance(double lat, double lng) {
    if (_currentPosition == null) return -1;

    return Geolocator.distanceBetween(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
      lat,
      lng,
    );
  }
} 