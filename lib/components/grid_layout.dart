import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// This widget displays a grid layout.
class GridLayout extends StatefulWidget {
  const GridLayout({Key? key}) : super(key: key);

  @override
  State<GridLayout> createState() => _GridLayoutState();
}

class _GridLayoutState extends State<GridLayout> {
  List<String> pokemonNames = [];

  @override
  void initState() {
    super.initState();
    fetchPokemonNames();
  }

  Future<void> fetchPokemonNames() async {
    final response = await http
        .get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=40&offset=0'));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (var item in data['results']) {
        pokemonNames.add(item['name']);
      }
      setState(() {}); // Rebuild UI
    } else {
      throw Exception('Failed to load Pokémon data');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Set fixed dimensions for the grid
    return SizedBox(
      width: 500,
      height: 500,
      child: OrientationBuilder(
        builder: (context, orientation) {
          // Return a GridView based on screen orientation
          return GridView.builder(
            // Set scroll direction based on orientation
            scrollDirection: orientation == Orientation.portrait
                ? Axis.horizontal
                : Axis.vertical,
            // Define grid structure
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
            ),
            itemBuilder: (BuildContext context, int index) {
              // Generate a random color for the item
              Color itemColor = getRandomColor();
              // Return a colored container with tap functionality
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    // Navigate to the detail container when tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailContainer(
                          color: itemColor, // Pass the color to the next screen
                          index: index,
                          pokemon: pokemonNames[index],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        // Add border here
                        color: Colors.black,
                        width: 1.0,
                      ),
                      color: itemColor,
                    ),
                    child: Center(
                      child: Text(
                        pokemonNames.isNotEmpty
                            ? pokemonNames[index]
                            : 'Loading',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: 40, // Number of items in grid
          );
        },
      ),
    );
  }

  // Generates a random color
  Color getRandomColor() {
    Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }
}

// This widget displays the detail view for each item in the grid
class DetailContainer extends StatelessWidget {
  final String pokemon;
  final Color color; // Color for the detail container
  final int index; // Index for identification

  // Constructor to initialize color and index
  const DetailContainer(
      {Key? key,
      required this.color,
      required this.index,
      required this.pokemon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: color, // Use the color passed from the grid item
          child: Center(
            child: Text(
              pokemon,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      // Button to navigate back to the previous screen
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
