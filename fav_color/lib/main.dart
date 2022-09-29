import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Picker',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0x282A36),
        primaryColor: const Color(0x282A36),
      ),
      home: MyHomePage(title: 'Color Picker'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Map<String, Color> colors = {
    'red': Colors.red,
    'orange': Colors.orange,
    'yellow': Colors.yellow,
    'green': Colors.green,
    'blue': Colors.blue,
    'indigo': Colors.indigo,
    'purple': Colors.purple,
    'pink': Colors.pink,
  };

  Future<void> _copyToClipboard(String color) async {
    await Clipboard.setData(ClipboardData(text: color));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard'),
      ),
    );
  }

  Color? selectedColor;

  @override
  void initState() {
    _getStoredColor();
    super.initState();
  }

  void _getStoredColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // get stored color
    int? storedColor = prefs.getInt('color');
    // set state
    setState(() {
      selectedColor = Color(storedColor!);
    });
  }

  void _setColor(Color color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // convert color to int
    int colorInt = color.value;
    await prefs.setInt('color', colorInt);
    _animateColorChange(color);
  }

  void _animateColorChange(Color color) {
    // Get the current color
    Color currentColor = selectedColor ?? Colors.white;
    // make array of colors in between current and new color as hex values
    List<int> colorList = List<int>.generate(
        100,
        (i) => Color.lerp(currentColor, color, i / 100)!
            .value); // make a list of colors in between current and new color
    // loop through the list of colors and set the state to each color
    for (int i = 0; i < colorList.length; i++) {
      Future.delayed(Duration(milliseconds: i * 5), () {
        setState(() {
          selectedColor = Color(colorList[i]);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Pick a color!'),
                        content: SingleChildScrollView(
                          child: ColorPicker(
                            pickerColor: selectedColor ?? Colors.black,
                            onColorChanged: _setColor,
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Close'),
                          ),
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.color_lens))
        ],
        title: Text(widget.title),
        backgroundColor: selectedColor ?? Colors.black,
        centerTitle: true,
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // height: 100,
              margin: const EdgeInsets.all(10),
              child: const Text(
                'Values',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              // list the color as hex, rgb, and hsl
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  // if text clicked, copy to clipboard and on hover, underline
                  TextButton(
                    onPressed: () {
                      _copyToClipboard(
                          "#${selectedColor?.value.toRadixString(16).substring(2).toUpperCase()}");
                    },
                    child: Text(
                      "Hex #" +
                          (selectedColor?.value
                                  .toRadixString(16)
                                  .substring(2)
                                  .toUpperCase() ??
                              'FFFFFF'),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _copyToClipboard(
                          "(${selectedColor?.red}, ${selectedColor?.green}, ${selectedColor?.blue})");
                    },
                    child: Text(
                      "RGB: (${selectedColor?.red}, ${selectedColor?.green}, ${selectedColor?.blue})",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            for (var entry in colors.entries)
              Container(
                margin: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 10,
                    // if last color, add bottom margin
                    bottom: entry.key == colors.keys.last ? 5 : 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: entry.value, minimumSize: Size(100, 50)),
                  child: Text(entry.key),
                  onPressed: () => _setColor(entry.value),
                ),
              ),
          ]),
    );
  }
}
