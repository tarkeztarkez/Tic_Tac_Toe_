

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/Game/WinPainter.dart';
import 'package:tic_tac_toe/Game/Models/Cross.dart';
import 'package:tic_tac_toe/Game/Models/Circle.dart';


class GameStatefulWidget extends StatefulWidget {
  GameStatefulWidget({Key key,this.online}) : super(key: key);

  final bool online;
  @override
  _GameStatefulWidgetState createState() => _GameStatefulWidgetState(online);
}

class _GameStatefulWidgetState extends State<GameStatefulWidget> with SingleTickerProviderStateMixin {
  // 0 = no one
  // 1 = circle
  // 2 = cross

  bool online;

  Animation<double> winAnimation;
  AnimationController winAnimationController;

  WinPainter _winPainter = new WinPainter(0, Colors.black);

  bool _block = false;


  double _circleSize = 40.0;
  double _crossSize = 30.0;

  int _round = 1;

  List<Widget> _child = [Container(),Container(),Container(),Container(),Container(),Container(),Container(),Container(),Container(),Container(),Container()];

  List<String> _string = [" ", " ", " ", " ", " ", " ", " ", " ", " ",];
  List<Color> _colors = [Colors.black,Colors.black,Colors.black,Colors.black,Colors.black,Colors.black,Colors.black,Colors.black,Colors.black];
  int _circleScore = 0;
  int _crossScore = 0;
  int _currentIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  _GameStatefulWidgetState(this.online);

  @override
  void initState() {
    super.initState();
    winAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    winAnimation = Tween<double>(begin: 0.0,end: 1.0).animate(winAnimationController)
      ..addListener((){
        setState(() {
          _winPainter.animation = winAnimation.value;
        });
      });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: new RichText(
            text: new TextSpan(
                style: new TextStyle(
                    color: Colors.white
                ),
                children: [
                  new TextSpan(
                      text: "O ", style: new TextStyle(fontSize: _circleSize)),
                  new TextSpan(text: '$_circleScore:$_crossScore',
                      style: TextStyle(fontSize: 35.0)),
                  new TextSpan(
                      text: " X", style: new TextStyle(fontSize: _crossSize)),
                ]
            )
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _bottomNavigationBarTab,
          items: [
            BottomNavigationBarItem(
                icon: Container(width: 10, height: 10,),
                title: Text(
                  "Clear",
                  style: new TextStyle(
                      color: Colors.black54,
                      fontSize: 20.0
                  ),
                )
            ),
            BottomNavigationBarItem(
              icon: Container(width: 10, height: 10),
              title: Text(
                "Reset Score",
                style: new TextStyle(
                    color: Colors.black54,
                    fontSize: 20.0
                ),
              ),
            ),
          ]
      ),
      body: Center(
        child: CustomPaint(
            painter: _winPainter,
            child: Table(
              border: TableBorder.all(width: 1.0, color: Colors.black),
              children: [
                _buildRow(_buildCell(0), _buildCell(1), _buildCell(2)),
                _buildRow(_buildCell(3), _buildCell(4), _buildCell(5)),
                _buildRow(_buildCell(6), _buildCell(7), _buildCell(8)),
              ],
            )
        ),
      ),
    );
  }

  //Build 1 row for 3 cells
  TableRow _buildRow(TableCell cell1, TableCell cell2, TableCell cell3) {
    return TableRow(
        children: [
          cell1,
          cell2,
          cell3,
        ]
    );
  }


  // Build one TableCell
  TableCell _buildCell(int number) {
    return TableCell(
        child: Container(
          width: 90.0,
          height: 90.0,
          child: MaterialButton(
              child: Container(
                width: 60,
                  height: 60,
                  child:_child[number]
              ),
              onPressed: () {
                if (_string[number] == " ") {
                  if (_block == false) {
                    setState(() {
                      if (_round == 1) {
                        _string[number] = "O";
                        _colors[number] = Colors.orange;
                        _round = 2;
                      } else {
                        _string[number] = "X";
                        _colors[number] = Colors.blue;
                        _round = 1;
                      }
                      Sign(number);
                    });
                    if (_checkWin(1) != 0) _win(1, _checkWin(1));
                    if (_checkWin(2) != 0) _win(2, _checkWin(2));
                    if (_checkFull() == true) _full();
                    _updateSize();
                  }
                }
              }
          ),
        )
    );
  }


  int _checkWin(int side) {
    String _strside;
    if (side == 1) _strside = "O";
    if (side == 2) _strside = "X";
    if (_string[0] == _strside && _string[8] == _strside &&
        _string[4] == _strside) return 048;
    if (_string[0] == _strside && _string[1] == _strside &&
        _string[2] == _strside) return 012;
    if (_string[0] == _strside && _string[3] == _strside &&
        _string[6] == _strside) return 036;
    if (_string[8] == _strside && _string[7] == _strside &&
        _string[6] == _strside) return 678;
    if (_string[8] == _strside && _string[2] == _strside &&
        _string[5] == _strside) return 258;
    if (_string[4] == _strside && _string[1] == _strside &&
        _string[7] == _strside) return 147;
    if (_string[4] == _strside && _string[3] == _strside &&
        _string[5] == _strside) return 345;
    if (_string[4] == _strside && _string[6] == _strside &&
        _string[2] == _strside) return 246;
    return 0;
  }

  bool _checkFull() {
    if (_string[0] != " " && _string[1] != " " && _string[2] != " " &&
        _string[3] != " " && _string[4] != " " && _string[5] != " " &&
        _string[6] != " " && _string[7] != " " && _string[8] != " ") {
      return true;
    } else
      return false;
  }

  bool _checkEmpty() {
    if (_string[0] == " " && _string[1] == " " && _string[2] == " " &&
        _string[3] == " " && _string[4] == " " && _string[5] == " " &&
        _string[6] == " " && _string[7] == " " && _string[8] == " ") {
      return true;
    } else
      return false;
  }

  void _full() {
    _showSnackBar("Draw!!!");
    _clear();
  }

  void _win(int side, int code) {
    setState(() {
      _block = true;
      if (side == 1) {
        _showSnackBar("Circle has scored a point!!!");
        winAnimationController.forward();
        _winPainter.code = code;
        _winPainter.color = Colors.orangeAccent;
        _circleScore++;
      } else if (side == 2) {
        _showSnackBar("Cross has scored a point!!!");
        _crossScore++;
        winAnimationController.forward();
        _winPainter.code = code;
        _winPainter.color = Colors.blueAccent;
      }
    });
  }

  void _clear() {
    setState(() {
      _string = [" ", " ", " ", " ", " ", " ", " ", " ", " ",];
      _winPainter.code = 0;
      _winPainter.color = Colors.black;
      _colors = [Colors.black,Colors.black,Colors.black,Colors.black,Colors.black,Colors.black,Colors.black,Colors.black,Colors.black];
      winAnimationController.reset();
      _block = false;
      _child = [Container(),Container(),Container(),Container(),Container(),Container(),Container(),Container(),Container()];
    });
  }

  void _showSnackBar(String info) {
    final snackBar = SnackBar(
        duration: new Duration(
            milliseconds: 600
        ),
        content:
        Text(
          info,
          style: new TextStyle(
            fontSize: 20.0,
          ),
          textAlign: TextAlign.center,
        )
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void _bottomNavigationBarTab(int index) {
    if (index == 0) {
      if (!_checkEmpty()) {
        _clear();
        _showSnackBar("Cleared!!! ");
      }
    } else if (index == 1) {
      if (!_checkEmpty()) {
        _clear();
        setState(() {
          _crossScore = 0;
          _circleScore = 0;
          _round = 1;
        });
        _updateSize();
        _showSnackBar("All scores reseted!!!");
      }
    }
  }

  void _updateSize() {
    if (_round == 1) {
      setState(() {
        _circleSize = 40.0;
        _crossSize = 30.0;
      });
    }
    if (_round == 2) {
      setState(() {
        _circleSize = 30.0;
        _crossSize = 40.0;
      });
    }
  }


  void Sign(int number){
    if(_string[number] == "X"){
      setState(() {
        _child[number] = Cross();
      });
    }else if (_string[number] == 'O'){
      setState(() {
        _child[number] = Circle();
      });
    }else
      return null;
  }



}