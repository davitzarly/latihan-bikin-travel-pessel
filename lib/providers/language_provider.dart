import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  static const String _languageKey = 'language';
  String _currentLanguage = 'id';

  // Map untuk menyimpan terjemahan
  final Map<String, Map<String, String>> _translations = {
    'id': {
      // Navigasi
      'welcome': 'Selamat Datang',
      'home': 'Beranda',
      'search': 'Cari',
      'favorites': 'Favorit',
      'profile': 'Profil',
      'settings': 'Pengaturan',
      'language': 'Bahasa',
      'dark_mode': 'Mode Gelap',
      'logout': 'Keluar',

      // Destinasi
      'popular_destinations': 'Destinasi Populer',
      'nearby_places': 'Tempat Terdekat',
      'recent_searches': 'Pencarian Terakhir',
      'view_all': 'Lihat Semua',
      'search_hint': 'Cari destinasi wisata...',
      'no_results': 'Tidak ada hasil ditemukan',
      'error_occurred': 'Terjadi kesalahan',
      'try_again': 'Coba Lagi',
      'loading': 'Memuat...',

      // Aksi
      'save': 'Simpan',
      'cancel': 'Batal',
      'edit': 'Ubah',
      'delete': 'Hapus',
      'confirm': 'Konfirmasi',
      'success': 'Berhasil',
      'failed': 'Gagal',

      // Detail Destinasi
      'description': 'Deskripsi',
      'location': 'Lokasi',
      'rating': 'Rating',
      'reviews': 'Ulasan',
      'open_hours': 'Jam Buka',
      'ticket_price': 'Harga Tiket',
      'facilities': 'Fasilitas',
      'how_to_get_there': 'Cara Ke Sana',
      'nearby_hotels': 'Hotel Terdekat',
      'nearby_restaurants': 'Restoran Terdekat',

      // Profil
      'my_profile': 'Profil Saya',
      'edit_profile': 'Ubah Profil',
      'my_reviews': 'Ulasan Saya',
      'my_favorites': 'Favorit Saya',
      'my_bookings': 'Pemesanan Saya',
      'account_settings': 'Pengaturan Akun',
      'notifications': 'Notifikasi',
      'privacy_policy': 'Kebijakan Privasi',
      'terms_conditions': 'Syarat & Ketentuan',
      'help_center': 'Pusat Bantuan',
    },
    'en': {
      // Navigation
      'welcome': 'Welcome',
      'home': 'Home',
      'search': 'Search',
      'favorites': 'Favorites',
      'profile': 'Profile',
      'settings': 'Settings',
      'language': 'Language',
      'dark_mode': 'Dark Mode',
      'logout': 'Logout',

      // Destinations
      'popular_destinations': 'Popular Destinations',
      'nearby_places': 'Nearby Places',
      'recent_searches': 'Recent Searches',
      'view_all': 'View All',
      'search_hint': 'Search for destinations...',
      'no_results': 'No results found',
      'error_occurred': 'An error occurred',
      'try_again': 'Try Again',
      'loading': 'Loading...',

      // Actions
      'save': 'Save',
      'cancel': 'Cancel',
      'edit': 'Edit',
      'delete': 'Delete',
      'confirm': 'Confirm',
      'success': 'Success',
      'failed': 'Failed',

      // Destination Details
      'description': 'Description',
      'location': 'Location',
      'rating': 'Rating',
      'reviews': 'Reviews',
      'open_hours': 'Opening Hours',
      'ticket_price': 'Ticket Price',
      'facilities': 'Facilities',
      'how_to_get_there': 'How to Get There',
      'nearby_hotels': 'Nearby Hotels',
      'nearby_restaurants': 'Nearby Restaurants',

      // Profile
      'my_profile': 'My Profile',
      'edit_profile': 'Edit Profile',
      'my_reviews': 'My Reviews',
      'my_favorites': 'My Favorites',
      'my_bookings': 'My Bookings',
      'account_settings': 'Account Settings',
      'notifications': 'Notifications',
      'privacy_policy': 'Privacy Policy',
      'terms_conditions': 'Terms & Conditions',
      'help_center': 'Help Center',
    },
  };

  String get currentLanguage => _currentLanguage;
  bool get isEnglish => _currentLanguage == 'en';

  LanguageProvider() {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    _currentLanguage = prefs.getString(_languageKey) ?? 'id';
    notifyListeners();
  }

  Future<void> setLanguage(String language) async {
    if (_currentLanguage != language) {
      _currentLanguage = language;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, language);
      notifyListeners();
    }
  }

  String getText(String key) {
    return _translations[_currentLanguage]?[key] ?? key;
  }

  // Helper method untuk mendapatkan daftar bahasa yang tersedia
  List<Map<String, String>> get availableLanguages => [
    {'code': 'id', 'name': 'Bahasa Indonesia'},
    {'code': 'en', 'name': 'English'},
  ];
}