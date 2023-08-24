import 'package:flutter/widgets.dart';

import 'package:iox/rendering/render_value_dial.dart';

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
