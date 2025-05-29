import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:travel_guide/providers/destination_provider.dart';
import 'package:travel_guide/providers/language_provider.dart';
import 'package:travel_guide/screens/map_screen.dart';
import 'package:travel_guide/widgets/destination_card.dart';
import 'package:travel_guide/widgets/article_card.dart';
import 'package:travel_guide/widgets/category_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final destinationProvider = Provider.of<DestinationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(languageProvider.getText('home')),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // TODO: Navigasi ke halaman notifikasi
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Navigasi ke halaman pengaturan
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // TODO: Implementasi refresh data
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Banner Promosi dengan PageView
              SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Theme.of(context).primaryColor.withOpacity(0.1),
                          ),
                          child: Center(
                            child: Text(
                              '${languageProvider.getText('promo')} ${index + 1}',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (index) {
                          return Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentPage == index
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey.withOpacity(0.5),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),

              // Kategori Destinasi
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      languageProvider.getText('categories'),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 4,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      children: [
                        CategoryItem(
                          icon: Icons.beach_access,
                          label: languageProvider.getText('beach'),
                          onTap: () {
                            // TODO: Navigasi ke kategori pantai
                          },
                        ),
                        CategoryItem(
                          icon: Icons.landscape,
                          label: languageProvider.getText('mountain'),
                          onTap: () {
                            // TODO: Navigasi ke kategori gunung
                          },
                        ),
                        CategoryItem(
                          icon: Icons.restaurant,
                          label: languageProvider.getText('culinary'),
                          onTap: () {
                            // TODO: Navigasi ke kategori kuliner
                          },
                        ),
                        CategoryItem(
                          icon: Icons.museum,
                          label: languageProvider.getText('culture'),
                          onTap: () {
                            // TODO: Navigasi ke kategori budaya
                          },
                        ),
                        CategoryItem(
                          icon: Icons.hotel,
                          label: languageProvider.getText('hotel'),
                          onTap: () {
                            // TODO: Navigasi ke kategori hotel
                          },
                        ),
                        CategoryItem(
                          icon: Icons.shopping_bag,
                          label: languageProvider.getText('shopping'),
                          onTap: () {
                            // TODO: Navigasi ke kategori belanja
                          },
                        ),
                        CategoryItem(
                          icon: Icons.nature,
                          label: languageProvider.getText('nature'),
                          onTap: () {
                            // TODO: Navigasi ke kategori alam
                          },
                        ),
                        CategoryItem(
                          icon: Icons.more_horiz,
                          label: languageProvider.getText('more'),
                          onTap: () {
                            // TODO: Navigasi ke kategori lainnya
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Destinasi Populer
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          languageProvider.getText('popular_destinations'),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        TextButton(
                          onPressed: () {
                            // TODO: Navigasi ke halaman semua destinasi
                          },
                          child: Text(languageProvider.getText('view_all')),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 220,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: destinationProvider.popularDestinations.length,
                        itemBuilder: (context, index) {
                          final destination = destinationProvider.popularDestinations[index];
                          return DestinationCard(
                            destination: destination,
                            onTap: () {
                              // TODO: Navigasi ke detail destinasi
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Destinasi Terdekat
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          languageProvider.getText('nearby_places'),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        TextButton(
                          onPressed: () {
                            // TODO: Navigasi ke halaman peta
                          },
                          child: Text(languageProvider.getText('view_all')),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 220,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: destinationProvider.nearbyDestinations.length,
                        itemBuilder: (context, index) {
                          final destination = destinationProvider.nearbyDestinations[index];
                          return DestinationCard(
                            destination: destination,
                            onTap: () {
                              // TODO: Navigasi ke detail destinasi
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Artikel & Tips
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      languageProvider.getText('articles_tips'),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return ArticleCard(
                          title: 'Judul Artikel ${index + 1}',
                          description: 'Deskripsi singkat artikel...',
                          imageUrl: 'https://picsum.photos/100/100?random=$index',
                          date: '1 Januari 2024',
                          onTap: () {
                            // TODO: Navigasi ke detail artikel
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MapScreen()),
          );
        },
        icon: const Icon(Icons.map),
        label: Text(languageProvider.getText('view_map')),
      ),
    );
  }
}