import 'package:flutter/material.dart';
import 'utils/colors.dart';

class Converter extends StatefulWidget {
  const Converter({super.key});

  @override
  State<Converter> createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  @override
  void initState() {
    setPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final myInputController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Converter",
          style: TextStyle(color: textColor),
        ),
        backgroundColor: buttonColor,
      ),
      body: Column(
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: TextField(
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(),
                      hintText: 'Enter your number and unit',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    ),
                    controller: myInputController,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("What would you like to convert to?",
                          style: TextStyle(color: textColor, fontSize: 18)),
                      content: FractionallySizedBox(
                        alignment: Alignment.center,
                        heightFactor: 0.5,
                        child: Column(
                          children: [
                            const Spacer(),
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.black),
                              child: const Center(
                                child: Text(
                                  "Select Unit Being Converted To",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      backgroundColor: buttonColor,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Icon(Icons.search_rounded, color: Colors.white),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
