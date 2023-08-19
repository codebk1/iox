import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:statsfl/statsfl.dart';

import 'package:iox/rendering/value_dial.dart';

void main() {
  runApp(
    StatsFl(
      maxFps: 144,
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
          padding: const EdgeInsets.all(24),
          child: Column(
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
                  Expanded(
                    child: Slider(
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
        ),
      ),
    );
  }
}

class ValueDial extends LeafRenderObjectWidget {
  const ValueDial({
    super.key,
    required this.value,
    required this.color,
    required this.dividersColor,
    required this.diameter,
    required this.maxValue,
    required this.mainDividers,
    required this.subDividers,
    required this.mainDividersWidth,
    required this.subDividersWidth,
  });

  final int value;
  final Color color;
  final Color dividersColor;
  final double diameter;
  final int maxValue;
  final int mainDividers;
  final int subDividers;
  final double mainDividersWidth;
  final double subDividersWidth;

  @override
  RenderValueDial createRenderObject(BuildContext context) {
    final defaultTextStyle = DefaultTextStyle.of(context);

    return RenderValueDial(
      value: value,
      color: color,
      dividersColor: dividersColor,
      textStyle: defaultTextStyle.style,
      diameter: diameter,
      maxValue: maxValue,
      mainDividers: mainDividers,
      subDividers: subDividers,
      mainDividersWidth: mainDividersWidth,
      subDividersWidth: subDividersWidth,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderValueDial renderObject,
  ) {
    renderObject
      ..value = value
      ..color = color
      ..dividersColor = dividersColor
      ..diameter = diameter
      ..maxValue = maxValue
      ..mainDividers = mainDividers
      ..subDividers = subDividers
      ..mainDividersWidth = mainDividersWidth
      ..subDividersWidth = subDividersWidth;
  }
}
