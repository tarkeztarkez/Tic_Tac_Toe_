
import 'package:flutter/material.dart';

class WinPainter extends CustomPainter{
  Paint _paint = Paint();
  int _code;
  double _one = 10;
  Color _color;
  double _animation;

  WinPainter(this._code, this._color);

  @override
  void paint(Canvas canvas, Size size) {
    _paint.color = _color;
    _paint.strokeWidth = 7;
    _paint.strokeCap = StrokeCap.round;
    if (_code == 012) canvas.drawLine(Offset(_one, (size.height / 6) * 1),
        Offset((size.width - _one) * _animation, (size.height / 6) * 1), _paint);
    if (_code == 345) canvas.drawLine(Offset(_one, (size.height / 6) * 3),
        Offset((size.width - _one) * _animation, (size.height / 6) * 3), _paint);
    if (_code == 678) canvas.drawLine(Offset(_one, (size.height / 6) * 5),
        Offset((size.width - _one) * _animation, (size.height / 6) * 5), _paint);
    if (_code == 036) canvas.drawLine(Offset((size.width / 6) * 1, _one),
        Offset((size.width / 6) * 1, (size.height - _one) * _animation), _paint);
    if (_code == 147) canvas.drawLine(Offset((size.width / 6) * 3, _one),
        Offset((size.width / 6) * 3, (size.height - _one)  * _animation), _paint);
    if (_code == 258) canvas.drawLine(Offset((size.width / 6) * 5, _one),
        Offset((size.width / 6) * 5, (size.height - _one)  * _animation), _paint);
    if (_code == 048) canvas.drawLine(Offset(_one,_one),
        Offset((size.width - _one) * _animation, (size.height - _one) * _animation), _paint);
    if (_code == 246) canvas.drawLine(Offset(size.width - _one,_one),
        Offset(_one * _animation, (size.height - _one)), _paint);
}

  @override
  bool shouldRepaint(WinPainter oldDelegate) {
    return (oldDelegate._code != _code) && (oldDelegate._animation != _animation);
  }

  set code(int value) {
    _code = value;
  }

  set color(Color value) {
    _color = value;
  }

  set animation(double value) {
    _animation = value;
  }


}