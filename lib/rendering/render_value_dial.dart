import 'dart:math';
import 'dart:ui';

import 'package:flutter/rendering.dart';

class RenderValueDial extends RenderBox {
  RenderValueDial({
    required int value,
    required Color color,
    required Color dividersColor,
    required TextStyle textStyle,
    required double diameter,
    required int maxValue,
    required int mainDividers,
    required int subDividers,
    required double mainDividersWidth,
    required double subDividersWidth,
  })  : _value = value,
        _color = color,
        _dividersColor = dividersColor,
        _textStyle = textStyle,
        _diameter = diameter,
        _maxValue = maxValue,
        _mainDividers = mainDividers,
        _subDividers = subDividers,
        _mainDividersWidth = mainDividersWidth,
        _subDividersWidth = subDividersWidth;

  int _value;
  int get value => _value;
  set value(int value) {
    if (value == _value) return;

    _value = value;

    markNeedsPaint();
  }

  Color _color;
  Color get color => _color;
  set color(Color value) {
    if (value == _color) return;

    _color = value;

    markNeedsPaint();
  }

  Color _dividersColor;
  Color get dividersColor => _dividersColor;
  set dividersColor(Color value) {
    if (value == _dividersColor) return;

    _dividersColor = dividersColor;

    markNeedsPaint();
  }

  TextStyle _textStyle;
  TextStyle get textStyle => _textStyle;
  set textStyle(TextStyle value) {
    if (value == _textStyle) return;

    _textStyle = textStyle;

    markNeedsPaint();
  }

  double _diameter;
  double get diameter => _diameter;
  set diameter(double value) {
    if (value == _diameter) return;

    _diameter = value;

    markNeedsLayout();
  }

  int _maxValue;
  int get maxValue => _maxValue;
  set maxValue(int value) {
    if (value == _maxValue) return;

    _maxValue = value;

    markNeedsPaint();
  }

  int _mainDividers;
  int get mainDividers => _mainDividers;
  set mainDividers(int value) {
    if (value == _mainDividers) return;

    _mainDividers = value;

    markNeedsPaint();
  }

  int _subDividers;
  int get subDividers => _subDividers;
  set subDividers(int value) {
    if (value == _subDividers) return;

    _subDividers = value;

    markNeedsPaint();
  }

  double _mainDividersWidth;
  double get mainDividersWidth => _mainDividersWidth;
  set mainDividersWidth(double value) {
    if (value == _mainDividersWidth) return;

    _mainDividersWidth = value;

    markNeedsPaint();
  }

  double _subDividersWidth;
  double get subDividersWidth => _subDividersWidth;
  set subDividersWidth(double value) {
    if (value == _subDividersWidth) return;

    _subDividersWidth = value;

    markNeedsPaint();
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return Size(_diameter, _diameter);
  }

  @override
  bool get sizedByParent => true;

  @override
  bool get isRepaintBoundary => true;

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    final subValue = _maxValue ~/ _mainDividers;
    final mainDivisionSpacing = 2 * pi / _mainDividers;
    final subDivisionSpacing = mainDivisionSpacing / (_subDividers + 1);

    _drawValueText(canvas);
    _drawOuterRing(canvas, strokeWidth: 20);

    if (_value == _maxValue) {
      _drawOuterPoint(
        canvas,
        angle: 0,
        color: _color,
      );
    }

    for (var i = 0; i < _mainDividers; i++) {
      var c = i * subValue <= _value ? _color : _dividersColor;
      var angle = i * mainDivisionSpacing;

      _drawDivider(
        canvas,
        angle: angle,
        width: _mainDividersWidth,
        color: c,
      );

      _drawMainDividerPoint(
        canvas,
        angle: angle,
        color: c,
      );

      _drawSubValueText(
        canvas,
        text: (subValue * i).toString(),
        angle: angle,
      );

      if (_value == i * subValue) {
        _drawOuterPoint(
          canvas,
          angle: angle,
          color: c,
        );
      }

      for (var j = 1; j <= _subDividers; j++) {
        final currentDividerValue =
            i * subValue + subValue / (_subDividers + 1) * j;

        var c = currentDividerValue <= _value ? _color : _dividersColor;

        _drawDivider(
          canvas,
          angle: angle + (subDivisionSpacing * j),
          width: _subDividersWidth,
          color: c,
        );

        if (currentDividerValue == _value) {
          _drawOuterPoint(
            canvas,
            angle: angle + (subDivisionSpacing * j),
            color: c,
          );
        }
      }
    }
  }

  void _drawDivider(
    Canvas canvas, {
    required double angle,
    required double width,
    required Color color,
  }) {
    var x0 = _diameter / 2 * cos(angle) + size.width / 2;
    var y0 = _diameter / 2 * sin(angle) + size.height / 2;

    var x1 = (_diameter - width) / 2 * cos(angle) + size.width / 2;
    var y1 = (_diameter - width) / 2 * sin(angle) + size.height / 2;

    Path path = Path();
    path.moveTo(x0, y0);
    path.lineTo(x1, y1);

    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        //..strokeCap = StrokeCap.round
        ..strokeWidth = 1.5
        ..color = color,
    );
  }

  void _drawValueText(Canvas canvas) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: _value.toString(),
        style: _textStyle.copyWith(
          color: color,
          fontSize: 38,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (size.width - textPainter.width) / 2,
        (size.height - textPainter.height) / 2,
      ),
    );
  }

  void _drawSubValueText(
    Canvas canvas, {
    required String text,
    required double angle,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: _textStyle.copyWith(
          color: _dividersColor,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    var dx = (_diameter - (_mainDividersWidth * 2.8)) / 2 * cos(angle) +
        size.width / 2;
    var dy = (_diameter - (_mainDividersWidth * 2.8)) / 2 * sin(angle) +
        size.height / 2;

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        dx - (textPainter.width / 2),
        dy - (textPainter.height / 2),
      ),
    );
  }

  void _drawMainDividerPoint(
    Canvas canvas, {
    required double angle,
    required Color color,
  }) {
    var dx = (_diameter - (_mainDividersWidth * 1.5)) / 2 * cos(angle) +
        size.width / 2;
    var dy = (_diameter - (_mainDividersWidth * 1.5)) / 2 * sin(angle) +
        size.height / 2;

    canvas.drawPoints(
      PointMode.points,
      [Offset(dx, dy)],
      Paint()
        ..strokeCap = StrokeCap.round
        ..color = color
        ..strokeWidth = 4,
    );
  }

  void _drawOuterRing(
    Canvas canvas, {
    required double strokeWidth,
  }) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = const LinearGradient(
        colors: [
          Color.fromARGB(255, 41, 40, 48),
          Color.fromARGB(100, 41, 40, 48),
        ],
      ).createShader(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: _diameter / 2 + _mainDividersWidth,
      ));

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      _diameter / 2 + _mainDividersWidth,
      paint,
    );
  }

  void _drawOuterPoint(
    Canvas canvas, {
    required double angle,
    required Color color,
  }) {
    var dx = (_diameter / 2 + _mainDividersWidth) * cos(angle) + size.width / 2;
    var dy =
        (_diameter / 2 + _mainDividersWidth) * sin(angle) + size.height / 2;

    canvas.drawPoints(
      PointMode.points,
      [Offset(dx, dy)],
      Paint()
        ..strokeCap = StrokeCap.round
        ..color = color
        ..strokeWidth = 7
        ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 5),
    );
  }
}
