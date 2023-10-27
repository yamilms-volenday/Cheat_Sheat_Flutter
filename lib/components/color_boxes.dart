import 'package:flutter/material.dart';
import 'package:flutter_application_3/main.dart';
import 'package:provider/provider.dart';

class ColorBoxes extends StatelessWidget {
  const ColorBoxes({Key? key, required this.caja2}) : super(key: key);
  //GET ARGUMENT FROM PARENT
  final String caja2;

  @override
  Widget build(BuildContext context) {
    //GET THE STATE
    var appState = context.watch<MyAppState>();

    return Center(
      child: LayoutBuilder(builder: (context, constraints) {
        Axis direction =
            constraints.maxWidth > 600 ? Axis.horizontal : Axis.vertical;
        return Container(
          width: 800,
          height: 600,
          color: Colors.grey,
          child: Flex(
            direction: direction,
            children: [
              Flexible(
                child: Container(
                  color: Colors.red,
                  child: Center(
                    child: Text(appState.caja1,
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  color: Colors.green,
                  child: Center(
                    child: Text(caja2,
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  color: Colors.blue,
                  child: const Center(
                    child: Text('Hardcoded',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
