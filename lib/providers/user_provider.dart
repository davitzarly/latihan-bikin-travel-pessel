import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  static const String _userKey = 'user_data';
  late SharedPreferences _prefs;
  
  String? _name;
  String? _email;
  String? _profileImage;
  List<String> _recentSearches = [];
  List<String> _favoriteDestinations = [];
  bool _isDarkMode = false;

  String? get name => _name;
  String? get email => _email;
  String? get profileImage => _profileImage;
  List<String> get recentSearches => _recentSearches;
  List<String> get favoriteDestinations => _favoriteDestinations;
  bool get isDarkMode => _isDarkMode;

  UserProvider() {
    _loadUserData();
    _loadRecentSearches();
  }

  Future<void> _loadUserData() async {
    _prefs = await SharedPreferences.getInstance();
    _name = _prefs.getString('${_userKey}_name');
    _email = _prefs.getString('${_userKey}_email');
    _profileImage = _prefs.getString('${_userKey}_profile_image');
    _recentSearches = _prefs.getStringList('${_userKey}_recent_searches') ?? [];
    _favoriteDestinations = _prefs.getStringList('${_userKey}_favorites') ?? [];
    _isDarkMode = _prefs.getBool('${_userKey}_is_dark_mode') ?? false;
    notifyListeners();
  }

  Future<void> _loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    _recentSearches = prefs.getStringList('${_userKey}_recent_searches') ?? [];
    notifyListeners();
  }

  Future<void> updateProfile({
    String? name,
    String? email,
    String? profileImage,
  }) async {
    if (name != null) {
      _name = name;
      await _prefs.setString('${_userKey}_name', name);
    }
    if (email != null) {
      _email = email;
      await _prefs.setString('${_userKey}_email', email);
    }
    if (profileImage != null) {
      _profileImage = profileImage;
      await _prefs.setString('${_userKey}_profile_image', profileImage);
    }
    notifyListeners();
  }

  Future<void> addRecentSearch(String search) async {
    if (!_recentSearches.contains(search)) {
      _recentSearches.insert(0, search);
      if (_recentSearches.length > 10) {
        _recentSearches.removeLast();
      }
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('${_userKey}_recent_searches', _recentSearches);
      notifyListeners();
    }
  }

  Future<void> removeRecentSearch(String search) async {
    _recentSearches.remove(search);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('${_userKey}_recent_searches', _recentSearches);
    notifyListeners();
  }

  Future<void> clearRecentSearches() async {
    _recentSearches.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('${_userKey}_recent_searches', _recentSearches);
    notifyListeners();
  }

  Future<void> toggleFavorite(String destinationId) async {
    if (_favoriteDestinations.contains(destinationId)) {
      _favoriteDestinations.remove(destinationId);
    } else {
      _favoriteDestinations.add(destinationId);
    }
    await _prefs.setStringList('${_userKey}_favorites', _favoriteDestinations);
    notifyListeners();
  }

  bool isFavorite(String destinationId) {
    return _favoriteDestinations.contains(destinationId);
  }

  Future<void> toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    await _prefs.setBool('${_userKey}_is_dark_mode', _isDarkMode);
    notifyListeners();
  }

  Future<void> logout() async {
    await _prefs.clear();
    _name = null;
    _email = null;
    _profileImage = null;
    _recentSearches = [];
    _favoriteDestinations = [];
    _isDarkMode = false;
    notifyListeners();
  }
} 