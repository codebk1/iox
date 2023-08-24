import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:iox/widgets/range_dial.dart';
import 'package:statsfl/statsfl.dart';

import 'package:iox/widgets/value_dial.dart';

void main() {
  runApp(
    StatsFl(
      maxFps: 144,
      align: Alignment.topRight,
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final backgroundColor = const Color.fromARGB(255, 44, 42, 51);
  final _colors = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.purple,
  ];

  var _selectedColor = Colors.blue;
  var _value = 0.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.robotoCondensedTextTheme(),
      ),
      home: Scaffold(
        backgroundColor: backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const RangeDial(
                color: Color.fromARGB(255, 30, 58, 138),
                dividersColor: Color.fromARGB(255, 255, 255, 255),
                startHandleColor: Color.fromARGB(255, 30, 58, 138),
                endHandleColor: Color.fromARGB(255, 30, 58, 138),
                diameter: 350,
                valueDialDiameter: 150,
                handleRadius: 15,
                maxValue: 12,
                mainDividers: 12,
                subDividers: 9,
                mainDividersWidth: 20,
                subDividersWidth: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ValueDial(
                    value: _value.toInt(),
                    color: _selectedColor,
                    dividersColor: const Color.fromARGB(255, 81, 80, 87),
                    diameter: 300,
                    maxValue: 2000,
                    mainDividers: 8,
                    subDividers: 9,
                    mainDividersWidth: 30,
                    subDividersWidth: 20,
                  ),
                  Row(
                    children: [
                      Slider(
                        value: _value,
                        max: 2000,
                        divisions: 80,
                        activeColor: _selectedColor,
                        label: _value.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            _value = value;
                          });
                        },
                      ),
                      for (var c in _colors)
                        IconButton(
                          color: c,
                          icon: const Icon(Icons.radio_button_off),
                          selectedIcon: const Icon(Icons.radio_button_checked),
                          isSelected: c == _selectedColor,
                          onPressed: () {
                            setState(() {
                              _selectedColor = c;
                            });
                          },
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
