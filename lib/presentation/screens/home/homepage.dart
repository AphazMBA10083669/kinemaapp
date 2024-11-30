import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kinemaapp/presentation/screens/home/movie_details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String apiKey = 'ebbcfe3e6f63e6460806b681dbf2e649';
  String selectedCategory = 'popular';
  List movies = [];
  List filteredMovies = [];
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;

  final Map<String, String> categories = {
    'popular': 'Popular',
    'top_rated': 'Top Rated',
    'upcoming': 'Upcoming',
    'now_playing': 'Now Playing',
  };

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    setState(() {
      isLoading = true;
    });

    try {
      final url = Uri.parse('https://api.themoviedb.org/3/movie/$selectedCategory?api_key=$apiKey');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          movies = json.decode(response.body)['results'];
          filteredMovies = movies;
        });
      }
    } catch (e) {
      print('Error fetching movies: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      setState(() {
        filteredMovies = movies;
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final url = Uri.parse('https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=${Uri.encodeComponent(query)}');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          filteredMovies = json.decode(response.body)['results'];
        });
      }
    } catch (e) {
      print('Error searching movies: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void changeCategory(String category) {
    setState(() {
      selectedCategory = category;
      searchController.clear();
    });
    fetchMovies();
  }

  Widget _buildSearchField() {
    return TextField(
      controller: searchController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Search movies...',
        hintStyle: const TextStyle(color: Colors.white70),
        prefixIcon: const Icon(Icons.search, color: Colors.white70),
        suffixIcon: searchController.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear, color: Colors.white70),
                onPressed: () {
                  searchController.clear();
                  searchMovies('');
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white24,
      ),
      onChanged: (value) {
        searchMovies(value);
      },
    );
  }

  Widget _buildDrawerItem(IconData icon, String text) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      onTap: () {
        // Handle navigation or functionality here
      },
    );
  }

  Widget _buildCategoryChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: categories.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              label: Text(
                entry.value,
                style: TextStyle(
                  color: selectedCategory == entry.key ? Colors.purple : Colors.purple,
                ),
              ),
              selected: selectedCategory == entry.key,
              selectedColor: Colors.grey,
              backgroundColor: Colors.white24,
              onSelected: (bool selected) {
                if (selected) {
                  changeCategory(entry.key);
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFFaf00c2),
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ), // The icon to open the drawer
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer(); // Open the drawer using the key
          },
        ),
        title: Center(
            child: const Text(
          'Kinema',
          style: TextStyle(color: Colors.white),
        )),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {
              // Implement notification functionality here
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFaf00c2), // Purple
                Color(0xFF71027d), // Dark Purple
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              // Drawer Header with profile information
              UserAccountsDrawerHeader(
                accountName: const Text(
                  'User Name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                accountEmail: const Text(
                  'user@example.com',
                  style: TextStyle(
                    color: Colors.white60,
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Color(0xFFaf00c2)),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF71027d),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                  ),
                ),
              ),

              // Drawer Items with icons and modern styling
              _buildDrawerItem(Icons.account_circle, 'Account'),
              _buildDrawerItem(Icons.notifications, 'Notifications'),
              _buildDrawerItem(Icons.favorite, 'Favourites'),
              _buildDrawerItem(Icons.people, 'Community'),
              _buildDrawerItem(Icons.language, 'Language'),
              _buildDrawerItem(Icons.settings, 'Settings'),

              const Spacer(),

              // Logout and Version Info at the very bottom
              _buildDrawerItem(Icons.exit_to_app, 'Logout'),
              _buildDrawerItem(Icons.info, 'Version 1.0.0'),
            ],
          ),
        ),
      ),

// Helper method to create modern drawer items

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFaf00c2), Color(0xFF71027d)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: _buildSearchField(),
            ),
            _buildCategoryChips(),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator(color: Colors.white))
                  : filteredMovies.isEmpty
                      ? const Center(
                          child: Text(
                            'No movies found',
                            style: TextStyle(color: Colors.white70, fontSize: 16),
                          ),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.all(8),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: filteredMovies.length,
                          itemBuilder: (context, index) {
                            final movie = filteredMovies[index];
                            return MovieCard(movie: movie);
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

class MovieCard extends StatelessWidget {
  final dynamic movie;

  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageUrl = movie['poster_path'] != null ? 'https://image.tmdb.org/t/p/w500${movie['poster_path']}' : 'https://via.placeholder.com/500x750?text=No+Image';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsScreen(movie: movie),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.error, color: Colors.red),
                  );
                },
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie['title'] ?? movie['name'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      movie['release_date'] ?? 'N/A',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
