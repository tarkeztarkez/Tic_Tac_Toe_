import 'package:flutter/material.dart';
import 'package:tic_tac_toe/Game/Game.dart';
import 'package:tic_tac_toe/Online/OnlineList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainMenuStatelessWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainMenuStatelessWidget extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Tic Tac Toe',
          style: TextStyle(
            fontSize: 20
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
                child: Text('Offline'),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GameStatefulWidget(
                    online: false,
                  )));
                }
            ),
            RaisedButton(
                child: Text('Online'),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OnlineList(

                  )));
                }
            ),
          ],
        ),
      ),
    );
  }
}