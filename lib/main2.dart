import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

void main() {
  runApp(const ColorPaletteApp());
}

class ColorPaletteApp extends StatefulWidget {
  const ColorPaletteApp({Key? key}) : super(key: key);

  @override
  _ColorPaletteAppState createState() => _ColorPaletteAppState();
}

class _ColorPaletteAppState extends State<ColorPaletteApp> {
  final RandomColor _randomColor = RandomColor();
  List<Color> colorPalette = [];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
                children: <Widget>[
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final numColumns = screenWidth < 600 ? 2 : 3;
                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: numColumns,
                          ),
                          itemBuilder: (context, index) {
                            if (index < colorPalette.length) {
                              final color = colorPalette[index];
                              final hexColor = color.value.toRadixString(16);
                              return ColorBox(hexColor: hexColor);
                            } else {
                              return Container();
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              left: 110,
              right: 110,
              child: ElevatedButton(
                onPressed: generateColorPalette,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(
                      color: Color(0xFF000000),
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

  const ColorBox({Key? key, required this.hexColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 142,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(int.parse(hexColor, radix: 16)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          padding: const EdgeInsets.all(8),
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