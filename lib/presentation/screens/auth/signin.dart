import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class MovieDetailsScreen extends StatefulWidget {
  final dynamic movie;

  const MovieDetailsScreen({Key? key, required this.movie}) : super(key: key);

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  String? trailerKey;
  bool isLoadingTrailer = false;

  @override
  void initState() {
    super.initState();
    _fetchTrailer();
  }

  Future<void> _fetchTrailer() async {
    setState(() {
      isLoadingTrailer = true;
    });

    try {
      final response = await http.get(
        Uri.parse('https://api.themoviedb.org/3/movie/${widget.movie['id']}/videos?api_key=YOUR_API_KEY_HERE'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.statusCode as String);
        final results = data['results'] as List;

        final trailer = results.firstWhere(
          (video) => video['site'] == 'YouTube' && (video['type'] == 'Trailer' || video['type'] == 'Teaser'),
          orElse: () => null,
        );

        setState(() {
          trailerKey = trailer?['key'];
        });
      }
    } catch (e) {
      print('Error fetching trailer: $e');
    } finally {
      setState(() {
        isLoadingTrailer = false;
      });
    }
  }

  Future<void> _launchTrailer() async {
    if (trailerKey == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No trailer available'),
        ),
      );
      return;
    }

    final trailerUrl = 'https://www.youtube.com/watch?v=$trailerKey';
    if (await canLaunch(trailerUrl)) {
      await launch(trailerUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not launch trailer'),
        ),
      );
    }
  }

  Widget _buildTrailerButton() {
    if (isLoadingTrailer) {
      return ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurpleAccent,
        ),
        child: const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
        ),
      );
    }

    return ElevatedButton(
      onPressed: trailerKey != null ? _launchTrailer : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurpleAccent,
      ),
      child: Text(
        trailerKey != null ? 'Watch Trailer' : 'No Trailer Available',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildMetadataChip(String label) {
    return Chip(
      label: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
      backgroundColor: Colors.black.withOpacity(0.3),
      padding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  String _getGenres(dynamic movie) {
    return 'Drama, Action'; // Placeholder; Replace with actual genre list if available
  }

  void _showRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.black.withOpacity(0.8),
        child: RatingWidget(),
      ),
    );
  }

  void _addToFavorites(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Added to favorites!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = 'https://image.tmdb.org/t/p/w500${widget.movie['backdrop_path']}';

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.7),
              BlendMode.darken,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SafeArea(
            child: Stack(
              children: [
                Positioned.fill(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 56, 16, 80),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.movie['title'] ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            for (var i = 0; i < (widget.movie['vote_average'] / 2).round(); i++) const Icon(Icons.star, color: Colors.yellow, size: 24),
                            for (var i = 0; i < 5 - (widget.movie['vote_average'] / 2).round(); i++) const Icon(Icons.star_border, color: Colors.yellow, size: 24),
                            const SizedBox(width: 8),
                            Text(
                              '${widget.movie['vote_average']} / 10',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _buildMetadataChip('Quality: 4K'),
                            _buildMetadataChip('Release: ${widget.movie['release_date']}'),
                            _buildMetadataChip('Genre: ${_getGenres(widget.movie)}'),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Synopsis',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.movie['overview'] ?? 'No synopsis available',
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 16),
                        _buildTrailerButton(),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    //color: Colors.black.withOpacity(0.8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.favorite_border, color: Colors.white),
                          onPressed: () => _addToFavorites(context),
                        ),
                        ElevatedButton(
                          onPressed: () => _showRatingDialog(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurpleAccent,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 12,
                            ),
                          ),
                          child: const Text(
                            'Rate Movie',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RatingWidget extends StatefulWidget {
  @override
  _RatingWidgetState createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  double _rating = 3.0;
  final emojis = ['😢', '😕', '😐', '😊', '😍'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Rate the Movie',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            emojis[_rating.round() - 1],
            style: const TextStyle(fontSize: 48),
          ),
          Slider(
            value: _rating,
            min: 1,
            max: 5,
            divisions: 4,
            onChanged: (value) {
              setState(() {
                _rating = value;
              });
            },
            activeColor: Colors.deepPurpleAccent,
            inactiveColor: Colors.white24,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('You rated the movie ${_rating.round()} stars!'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurpleAccent,
            ),
            child: const Text(
              'Submit',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
