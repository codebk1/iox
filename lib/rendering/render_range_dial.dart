import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';

class RenderRangeDial extends RenderBox {
  RenderRangeDial({
    required Color color,
    required Color dividersColor,
    required Color startHandleColor,
    required Color endHandleColor,
    required TextStyle textStyle,
    required double diameter,
    required double valueDialDiameter,
    required double handleRadius,
    required int maxValue,
    required int mainDividers,
    required int subDividers,
    required double mainDividersWidth,
    required double subDividersWidth,
    required DeviceGestureSettings gestureSettings,
  })  : _color = color,
        _dividersColor = dividersColor,
        _startHandleColor = startHandleColor,
        _endHandleColor = endHandleColor,
        _textStyle = textStyle,
        _diameter = diameter,
        _valueDialDiameter = valueDialDiameter,
        _handleRadius = handleRadius,
        _maxValue = maxValue,
        _mainDividers = mainDividers,
        _subDividers = subDividers,
        _mainDividersWidth = mainDividersWidth,
        _subDividersWidth = subDividersWidth,
        _startHandleValue = 0,
        _endHandleValue = 50 {
    _drag = HorizontalDragGestureRecognizer()
      ..onStart = _handleDragStart
      ..onUpdate = _handleDragUpdate
      ..onEnd = _handleDragEnd
      ..gestureSettings = gestureSettings;
    _tap = TapGestureRecognizer()
      ..onTapDown = _handleTapDown
      ..gestureSettings = gestureSettings;
  }

  late HorizontalDragGestureRecognizer _drag;
  late TapGestureRecognizer _tap;
  bool _dragging1 = false;
  bool _dragging2 = false;
  Path? _startHandle;
  Path? _endHandle;

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

  Color _startHandleColor;
  Color get startHandleColor => _startHandleColor;
  set startHandleColor(Color value) {
    if (value == _startHandleColor) return;

    _startHandleColor = startHandleColor;

    markNeedsPaint();
  }

  Color _endHandleColor;
  Color get endHandleColor => _endHandleColor;
  set endHandleColor(Color value) {
    if (value == _endHandleColor) return;

    _endHandleColor = endHandleColor;

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

  double _valueDialDiameter;
  double get valueDialDiameter => _valueDialDiameter;
  set valueDialDiameter(double value) {
    if (value == _valueDialDiameter) return;

    _valueDialDiameter = value;

    markNeedsLayout();
  }

  double _handleRadius;
  double get handleRadius => _handleRadius;
  set handleRadius(double value) {
    if (value == _handleRadius) return;

    _handleRadius = value;

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

  int _startHandleValue;
  int get startHandleValue => _startHandleValue;
  set startHandleValue(int value) {
    if (value == _startHandleValue) return;

    _startHandleValue = value;

    markNeedsPaint();
  }

  int _endHandleValue;
  int get endHandleValue => _endHandleValue;
  set endHandleValue(int value) {
    if (value == _endHandleValue) return;

    _endHandleValue = value;

    markNeedsPaint();
  }

  DeviceGestureSettings? get gestureSettings => _drag.gestureSettings;
  set gestureSettings(DeviceGestureSettings? gestureSettings) {
    _drag.gestureSettings = gestureSettings;
    _tap.gestureSettings = gestureSettings;
  }

  void _startInteraction(Offset globalPosition) {
    //print(globalToLocal(globalPosition));
    //print(globalPosition);
  }

  void _endInteraction() {
    _dragging1 = false;
    _dragging2 = false;
  }

  void _handleTapDown(TapDownDetails details) {
    _startInteraction(details.globalPosition);
  }

  void _handleDragStart(DragStartDetails details) {
    _startInteraction(details.globalPosition);
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    final angle = atan2(
      details.localPosition.dx - size.width / 2,
      details.localPosition.dy - size.height / 2,
    );

    final atan2degrees = (angle >= 0 ? angle : (2 * pi + angle)) * 180 / pi;

    const snap = 1;
    final snappedValue = (atan2degrees / snap).round() * snap;

    if (_startHandle!.contains(details.localPosition) && !_dragging2) {
      _dragging1 = true;
    } else if (_endHandle!.contains(details.localPosition) && !_dragging1) {
      _dragging2 = true;
    }

    const offset = 15;

    if (_dragging1) {
      final distance = endHandleValue - snappedValue;
      final t = distance < 0 ? 360 - distance.abs() : distance;

      if (t <= offset || t >= 360 - offset) {
        endHandleValue =
            (t <= offset ? snappedValue + offset : snappedValue - offset) % 360;
      }

      startHandleValue = snappedValue;
    } else if (_dragging2) {
      final distance = startHandleValue - snappedValue;
      final t = distance < 0 ? 360 - distance.abs() : distance;

      if (t <= offset || t >= 360 - offset) {
        startHandleValue =
            (t <= offset ? snappedValue + offset : snappedValue - offset) % 360;
      }

      endHandleValue = snappedValue;
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    _endInteraction();
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
  bool hitTestSelf(Offset position) {
    return (_startHandle?.contains(position) ?? false) ||
        (_endHandle?.contains(position) ?? false);
  }

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry));

    if (event is PointerDownEvent) {
      //print({"EVENT", event});
      _drag.addPointer(event);
      _tap.addPointer(event);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    final subValue = _maxValue ~/ _mainDividers;

    _drawMainDial(canvas);
    _drawValueDial(canvas);

    _drawValueText(canvas);

    for (var i = 1; i <= _mainDividers; i++) {
      var angle = 3 * pi / 2 + (i * pi / 6);

      _drawDivider(
        canvas,
        angle: angle,
        width: _mainDividersWidth,
        color: _dividersColor,
      );

      _drawSubValueText(
        canvas,
        text: (subValue * i).toString(),
        angle: angle,
      );
    }

    // HANDLES
    const gap = 5;
    final rangeArcDiameter = _valueDialDiameter + (_handleRadius * 2 + 5) + gap;

    _drawRangeArc(
      canvas,
      diameter: rangeArcDiameter,
      startAngle: (-_startHandleValue + 90) * pi / 180,
      sweepAngle: (_startHandleValue - _endHandleValue) % 360 * pi / 180,
    );

    // HANDLE 1
    _startHandle = Path();
    final x1 = rangeArcDiameter / 2 * sin(_startHandleValue * pi / 180);
    final y1 = rangeArcDiameter / 2 * cos(_startHandleValue * pi / 180);

    _drawHandle(
      canvas,
      handle: _startHandle!,
      x: x1,
      y: y1,
      color: _startHandleColor,
    );

    // HANDLE 2
    _endHandle = Path();
    final x2 = rangeArcDiameter / 2 * sin(_endHandleValue * pi / 180);
    final y2 = rangeArcDiameter / 2 * cos(_endHandleValue * pi / 180);

    _drawHandle(
      canvas,
      handle: _endHandle!,
      x: x2,
      y: y2,
      color: _endHandleColor,
    );

    // canvas.drawRect(
    //   Rect.fromLTWH(0, 0, size.width, size.height),
    //   Paint()
    //     ..style = PaintingStyle.stroke
    //     ..strokeWidth = 5,
    // );
  }

  void _drawRangeArc(
    Canvas canvas, {
    required double diameter,
    required double startAngle,
    required double sweepAngle,
  }) {
    Paint paint = Paint()
      ..color = _color.withAlpha(100)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = _handleRadius * 2 + 5;

    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: diameter / 2,
      ),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  void _drawHandle(
    Canvas canvas, {
    required Path handle,
    required double x,
    required double y,
    required Color color,
  }) {
    Paint paint = Paint()..color = color;

    handle.addOval(
      Rect.fromCircle(
        center: Offset(size.width / 2 + x, size.height / 2 + y),
        radius: _handleRadius,
      ),
    );

    canvas.drawPath(handle, paint);
  }

  void _drawValueDial(Canvas canvas) {
    final paint = Paint()
      ..color = color
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 15);

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      _valueDialDiameter / 2,
      paint,
    );
  }

  void _drawMainDial(Canvas canvas) {
    Paint glass = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color.fromARGB(255, 41, 40, 48),
          Color.fromARGB(100, 41, 40, 48),
        ],
        stops: [0.0, 1.0],
      ).createShader(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: _diameter / 2,
      ));

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      _diameter / 2,
      glass,
    );
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
        ..strokeWidth = 1.5
        ..color = color,
    );
  }

  void _drawValueText(Canvas canvas) {
    final distance = startHandleValue - endHandleValue;
    final value = distance < 0 ? 360 - distance.abs() : distance;

    final textPainter = TextPainter(
      text: TextSpan(
        text: '$value',
        style: _textStyle.copyWith(
          color: const Color.fromARGB(255, 255, 255, 255),
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
}
