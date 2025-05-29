import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_guide/providers/destination_provider.dart';
import 'package:travel_guide/providers/language_provider.dart';
import 'package:travel_guide/providers/theme_provider.dart';
import 'package:travel_guide/screens/main_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/search_screen.dart';
import 'screens/notification_screen.dart';
import 'screens/category_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/help_screen.dart' as help;
import 'screens/about_screen.dart' as about;
import 'screens/map_screen.dart';
import 'screens/booking_screen.dart';
import 'screens/history_screen.dart';
import 'screens/language_screen.dart';
import 'screens/theme_screen.dart';
import 'screens/feedback_screen.dart';
import 'screens/home_screen.dart';
import 'screens/favorites_screen.dart';
import 'package:travel_guide/theme/app_theme.dart';
import 'package:travel_guide/services/destination_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final prefs = await SharedPreferences.getInstance();
  final destinationService = DestinationService();
  
  runApp(MyApp(
    prefs: prefs,
    destinationService: destinationService,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final DestinationService destinationService;

  const MyApp({
    super.key,
    required this.prefs,
    required this.destinationService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DestinationProvider(destinationService),
        ),
        ChangeNotifierProvider(
          create: (_) => LanguageProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(prefs),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          final textTheme = GoogleFonts.poppinsTextTheme();
          
          return MaterialApp(
            title: 'Travel Guide',
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.light,
              ),
              textTheme: textTheme,
              appBarTheme: AppBarTheme(
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.black,
                titleTextStyle: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              cardTheme: CardTheme(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.dark,
              ),
              textTheme: textTheme,
              appBarTheme: AppBarTheme(
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                titleTextStyle: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              cardTheme: CardTheme(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            themeMode: themeProvider.themeMode,
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'Cari',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favorit',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Travel Guide',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: PopupMenuButton<String>(
          icon: const Icon(Icons.menu),
          onSelected: (value) {
            switch (value) {
              case 'peta':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapScreen()),
                );
                break;
              case 'pemesanan':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BookingScreen()),
                );
                break;
              case 'riwayat':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HistoryScreen()),
                );
                break;
              case 'pengaturan':
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsScreen(),
                  ),
                );
                break;
              case 'bahasa':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LanguageScreen()),
                );
                break;
              case 'tema':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ThemeScreen()),
                );
                break;
              case 'bantuan':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const help.HelpScreen()),
                );
                break;
              case 'umpan_balik':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FeedbackScreen()),
                );
                break;
              case 'tentang':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const about.AboutScreen()),
                );
                break;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'peta',
              child: Row(
                children: [
                  Icon(Icons.map),
                  SizedBox(width: 8),
                  Text('Peta'),
                ],
              ),
            ),
            const PopupMenuItem<String>(
              value: 'pemesanan',
              child: Row(
                children: [
                  Icon(Icons.book_online),
                  SizedBox(width: 8),
                  Text('Pemesanan'),
                ],
              ),
            ),
            const PopupMenuItem<String>(
              value: 'riwayat',
              child: Row(
                children: [
                  Icon(Icons.history),
                  SizedBox(width: 8),
                  Text('Riwayat'),
                ],
              ),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem<String>(
              value: 'pengaturan',
              child: Row(
                children: [
                  Icon(Icons.settings),
                  SizedBox(width: 8),
                  Text('Pengaturan'),
                ],
              ),
            ),
            const PopupMenuItem<String>(
              value: 'bahasa',
              child: Row(
                children: [
                  Icon(Icons.language),
                  SizedBox(width: 8),
                  Text('Bahasa'),
                ],
              ),
            ),
            const PopupMenuItem<String>(
              value: 'tema',
              child: Row(
                children: [
                  Icon(Icons.dark_mode),
                  SizedBox(width: 8),
                  Text('Tema'),
                ],
              ),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem<String>(
              value: 'bantuan',
              child: Row(
                children: [
                  Icon(Icons.help),
                  SizedBox(width: 8),
                  Text('Bantuan'),
                ],
              ),
            ),
            const PopupMenuItem<String>(
              value: 'umpan_balik',
              child: Row(
                children: [
                  Icon(Icons.feedback),
                  SizedBox(width: 8),
                  Text('Umpan Balik'),
                ],
              ),
            ),
            const PopupMenuItem<String>(
              value: 'tentang',
              child: Row(
                children: [
                  Icon(Icons.info),
                  SizedBox(width: 8),
                  Text('Tentang'),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NotificationScreen()),
                  );
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: const Text(
                    '3',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Popular Destinations
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Destinasi Populer',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      // Navigasi ke halaman semua destinasi
                    },
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Lihat Semua'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigasi ke detail destinasi
                    },
                    child: Container(
                      width: 180,
                      margin: const EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12),
                                  ),
                                  color: Colors.blue[100],
                                ),
                                child: const Center(
                                  child: Icon(Icons.image, size: 50),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.favorite_border,
                                    size: 16,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Destinasi ${index + 1}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on, size: 14, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    const Text(
                                      'Lokasi',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const Spacer(),
                                    const Icon(Icons.star, size: 14, color: Colors.amber),
                                    const SizedBox(width: 4),
                                    const Text(
                                      '4.5',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Categories
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Kategori',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.5,
              children: [
                _buildCategoryCard(context, Icons.beach_access, 'Pantai', Colors.blue[100]!),
                _buildCategoryCard(context, Icons.landscape, 'Gunung', Colors.green[100]!),
                _buildCategoryCard(context, Icons.church, 'Tempat Bersejarah', Colors.orange[100]!),
                _buildCategoryCard(context, Icons.water, 'Danau', Colors.cyan[100]!),
                _buildCategoryCard(context, Icons.museum, 'Museum', Colors.purple[100]!),
                _buildCategoryCard(context, Icons.directions_walk, 'Jalan', Colors.brown[100]!),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, IconData icon, String title, Color color) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryScreen(
              title: title,
              icon: icon,
              color: color,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blue[700]),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorit',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              switch (value) {
                case 'hapus_semua':
                  // Implementasi hapus semua favorit
                  break;
                case 'urutkan':
                  // Implementasi pengurutan
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'hapus_semua',
                child: Row(
                  children: [
                    Icon(Icons.delete_outline),
                    SizedBox(width: 8),
                    Text('Hapus Semua'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'urutkan',
                child: Row(
                  children: [
                    Icon(Icons.sort),
                    SizedBox(width: 8),
                    Text('Urutkan'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 5,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(8),
              leading: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.image),
              ),
              title: Text('Destinasi Favorit ${index + 1}'),
              subtitle: const Text('Lokasi'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, size: 16, color: Colors.amber),
                  const SizedBox(width: 4),
                  const Text('4.5'),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {
                      // Implementasi hapus dari favorit
                    },
                  ),
                ],
              ),
              onTap: () {
                // Navigasi ke detail destinasi
              },
            ),
          );
        },
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifikasi'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Implementasi pengaturan notifikasi
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Bahasa'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Implementasi pengaturan bahasa
            },
          ),
          ListTile(
            leading: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            title: Text(isDarkMode ? 'Mode Gelap' : 'Mode Terang'),
            trailing: Switch(
              value: isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Tentang Aplikasi'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Implementasi tentang aplikasi
            },
          ),
        ],
      ),
    );
  }
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        actions: [
          TextButton(
            onPressed: () {
              // Implementasi tandai semua sudah dibaca
            },
            child: const Text('Tandai Semua Dibaca'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final bool isUnread = index < 3;
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            color: isUnread ? Colors.blue[50] : Colors.white,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue[100],
                child: const Icon(Icons.notifications, color: Colors.blue),
              ),
              title: Text('Notifikasi ${index + 1}'),
              subtitle: Text('Deskripsi notifikasi ${index + 1}'),
              trailing: Text(
                '${index + 1} jam yang lalu',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              onTap: () {
                // Implementasi aksi notifikasi
              },
            ),
          );
        },
      ),
    );
  }
}

class CategoryScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const CategoryScreen({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: 10,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                      ),
                      child: const Center(
                        child: Icon(Icons.image, size: 50),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.favorite_border,
                          size: 16,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$title ${index + 1}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Deskripsi singkat tentang destinasi wisata ini...',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 16),
                          const SizedBox(width: 4),
                          const Text('Lokasi'),
                          const Spacer(),
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                          const SizedBox(width: 4),
                          const Text('4.5'),
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
    );
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _recentSearches = [
    'Pantai Kuta',
    'Candi Borobudur',
    'Gunung Bromo',
    'Danau Toba',
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Cari destinasi wisata...',
            border: InputBorder.none,
            hintStyle: TextStyle(
              color: isDarkMode ? Colors.grey[400] : Colors.grey,
            ),
          ),
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          autofocus: true,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_recentSearches.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Pencarian Terakhir',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _recentSearches.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.history),
                  title: Text(_recentSearches[index]),
                  onTap: () {
                    _searchController.text = _recentSearches[index];
                  },
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
