import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/color_boxes.dart';
import 'components/media_post.dart';
import 'components/grid_layout.dart';

void main() {
  runApp(const MyApp()); //INITIALIZE THE APP
}

// MAIN APP IS HERE
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //WRAP THE APP IN A PROVIDER
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      //USE MATERIAL APP
      child: MaterialApp(
          title: 'Tutorial 3',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 6, 250, 6),
              //Uncomment this line to change the theme
              //brightness: Brightness.dark,
            ),
            useMaterial3: true,
          ),
          //ENTRY POINT
          home: const MyHomePage(title: "Cheatsheat of Fluter")),
    );
  }
}

//HERE IS THE STATE, CONTEXT IS PASSED IN
class MyAppState extends ChangeNotifier {
  //states
  String caja1 = "Provider";

  //methods/getters/setters

  //change title and update the widgets that use it
  void getTitle(title) {
    caja1 = title;
    notifyListeners();
  }
}

//HOME PAGE made stateful for the sake of the example
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //variable to change the page
  int pageIndexSelector = 0;

  @override
  Widget build(BuildContext context) {
    //switch between widgets using the variable pageIndexSelector
    Widget page;
    switch (pageIndexSelector) {
      case 0:
        page = const ColorBoxes(
          caja2: 'Argumento',
        );
        break;
      case 1:
        page = const MediaPost();
        break;
      case 2:
        page = const GridLayout();
        break;
      default:
        throw UnimplementedError('no widget for $pageIndexSelector');
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(widget.title),
      ),
      body: ListView(children: [
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            //HERE IS WHERE THE MAIN WIDGET IS CALLED
            child: page),
        Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    pageIndexSelector = 0;
                  });
                },
                child: const Text('Color Boxes'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    pageIndexSelector = 1;
                  });
                },
                child: const Text('Media View'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    pageIndexSelector = 2;
                  });
                },
                child: const Text('Grid View'),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}
