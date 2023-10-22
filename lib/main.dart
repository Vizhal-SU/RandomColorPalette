import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

void main() {
  runApp(const ColorPaletteApp());
}

class ColorPaletteApp extends StatefulWidget {
  const ColorPaletteApp({super.key});

  @override
  _ColorPaletteAppState createState() => _ColorPaletteAppState();
}

class _ColorPaletteAppState extends State<ColorPaletteApp> {
  final RandomColor _randomColor = RandomColor();
  List<Color> colorPalette = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Color Palette Generator'),
          centerTitle: true,
          backgroundColor: const Color(0xFF812c96),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              color: const Color(0xFFF5F5F5),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      children: colorPalette.map((color) {
                        final hexColor = color.toString().split('(0x')[1].split(')')[0];
                        return ColorBox(hexColor: hexColor);
                      }).toList(),
                    ),
                  ),
                  // SizedBox(height: 70),  // Empty space at the end (height of button)
                ],
              ),
            ),
            Positioned(
              bottom: 10,  // Adjust position
              left: 110,
              right: 110,
              child: ElevatedButton(
                onPressed: generateColorPalette,
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple,  // Transparent Button
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),  // Reduced width
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),  // Rounded corners for the button
                    side: const BorderSide(
                      color: Color(0xFF000000),  // Border color
                    ),
                  ),
                ),
                child: const Text('Generate Palette'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void generateColorPalette() {
    colorPalette.clear();
    for (int i = 0; i < 5; i++) {
      final randomColor = _randomColor.randomColor();
      colorPalette.add(randomColor);
    }
    setState(() {});
  }
}

class ColorBox extends StatelessWidget {
  final String hexColor;

  const ColorBox({super.key, required this.hexColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 142,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(int.parse(hexColor, radix: 16)),
        borderRadius: BorderRadius.circular(10),  // Rounded rectangle
      ),
      child: Align(
        alignment: Alignment.bottomRight,  // Align the ASCII code to the bottom right
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            "#$hexColor",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}





