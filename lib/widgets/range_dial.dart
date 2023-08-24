import 'package:flutter/widgets.dart';
import 'package:iox/rendering/render_range_dial.dart';

class RangeDial extends LeafRenderObjectWidget {
  const RangeDial({
    super.key,
    required this.color,
    required this.dividersColor,
    required this.startHandleColor,
    required this.endHandleColor,
    required this.diameter,
    required this.valueDialDiameter,
    required this.handleRadius,
    required this.maxValue,
    required this.mainDividers,
    required this.subDividers,
    required this.mainDividersWidth,
    required this.subDividersWidth,
  });

  final Color color;
  final Color dividersColor;
  final Color startHandleColor;
  final Color endHandleColor;
  final double diameter;
  final double valueDialDiameter;
  final double handleRadius;
  final int maxValue;
  final int mainDividers;
  final int subDividers;
  final double mainDividersWidth;
  final double subDividersWidth;

  @override
  RenderRangeDial createRenderObject(BuildContext context) {
    final defaultTextStyle = DefaultTextStyle.of(context);

    return RenderRangeDial(
      color: color,
      dividersColor: dividersColor,
      startHandleColor: startHandleColor,
      endHandleColor: endHandleColor,
      textStyle: defaultTextStyle.style,
      diameter: diameter,
      valueDialDiameter: valueDialDiameter,
      handleRadius: handleRadius,
      maxValue: maxValue,
      mainDividers: mainDividers,
      subDividers: subDividers,
      mainDividersWidth: mainDividersWidth,
      subDividersWidth: subDividersWidth,
      gestureSettings: MediaQuery.gestureSettingsOf(context),
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderRangeDial renderObject,
  ) {
    renderObject
      ..color = color
      ..dividersColor = dividersColor
      ..startHandleColor = startHandleColor
      ..endHandleColor = endHandleColor
      ..diameter = diameter
      ..valueDialDiameter = valueDialDiameter
      ..handleRadius = handleRadius
      ..maxValue = maxValue
      ..mainDividers = mainDividers
      ..subDividers = subDividers
      ..mainDividersWidth = mainDividersWidth
      ..subDividersWidth = subDividersWidth
      ..gestureSettings = MediaQuery.gestureSettingsOf(context);
  }
}
