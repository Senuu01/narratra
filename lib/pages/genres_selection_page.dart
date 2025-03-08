import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// Import your Firebase service
import '../services/firebase_service.dart';
// If you have a user model, import that as well
import '../models/user_model.dart';

/// Simple data class for each genre
class GenreData {
  final String name;
  final IconData icon;
  final MaterialColor color;

  GenreData({
    required this.name,
    required this.icon,
    required this.color,
  });
}

// If you only have a user ID:
class GenresSelectionPage extends StatefulWidget {
  final String uid;

  const GenresSelectionPage({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  _GenresSelectionPageState createState() => _GenresSelectionPageState();
}

// If you have a full user model instead:
// class GenresSelectionPage extends StatefulWidget {
//   final UserModel user;
//
//   const GenresSelectionPage({
//     Key? key,
//     required this.user,
//   }) : super(key: key);
//
//   @override
//   _GenresSelectionPageState createState() => _GenresSelectionPageState();
// }

class _GenresSelectionPageState extends State<GenresSelectionPage> {
  final FirebaseService _firebaseService = FirebaseService();

  /// Only the 6 requested genres
  final List<GenreData> allGenres = [
    GenreData(
      name: "Children's literature",
      icon: Icons.menu_book,
      color: Colors.pink,
    ),
    GenreData(
      name: 'Thriller',
      icon: Icons.local_police,
      color: Colors.deepPurple,
    ),
    GenreData(
      name: 'Fantasy',
      icon: Icons.auto_awesome,
      color: Colors.blue,
    ),
    // Updated horror icon to use a ghost icon from FontAwesome
    GenreData(
      name: 'Horror',
      icon: FontAwesomeIcons.ghost,
      color: Colors.deepOrange,
    ),
    GenreData(
      name: 'Romance',
      icon: Icons.favorite,
      color: Colors.red,
    ),
    GenreData(
      name: 'Adventure',
      icon: Icons.flight_takeoff,
      color: Colors.green,
    ),
  ];

  /// Keep track of which genres are selected
  final Set<String> selectedGenres = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // If you want no title text, just shrink it:
        title: const SizedBox.shrink(),
        elevation: 0,
      ),
      body: Container(
        // A simple gradient background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text(
              "What Are You Into?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Pick the categories you love, so we can tailor your reading recommendations just for you.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 40),

            // Genre chips
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: allGenres.map((genre) {
                    final bool isSelected = selectedGenres.contains(genre.name);
                    return GenreButton(
                      genre: genre,
                      selected: isSelected,
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedGenres.remove(genre.name);
                          } else {
                            selectedGenres.add(genre.name);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            ),

            // Continue button
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: ElevatedButton(
                onPressed: () async {
                  // 1) Convert selectedGenres to a List
                  final genresList = selectedGenres.toList();

                  // 2) Update user doc in Firestore with these genres
                  await _firebaseService.updateUserGenres(
                    widget.uid, // or widget.user.uid if you have a user model
                    genresList,
                  );

                  // 3) Then navigate to home
                  Navigator.pushReplacementNamed(context, '/home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A custom widget for a single genre button with larger size and icon.
class GenreButton extends StatelessWidget {
  final GenreData genre;
  final bool selected;
  final VoidCallback onTap;

  const GenreButton({
    Key? key,
    required this.genre,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = genre.color;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          color: selected ? color.shade700 : color.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              genre.icon,
              color: selected ? Colors.white : color.shade700,
              size: 48,
            ),
            const SizedBox(height: 8),
            Text(
              genre.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: selected ? Colors.white : color.shade700,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
