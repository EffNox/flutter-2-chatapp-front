import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final String text;
  final Function onPress;

  const BotonAzul({@required this.text, @required this.onPress});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 2,
      highlightElevation: 5,
      color: Colors.blue,
      shape: StadiumBorder(),
      onPressed: onPress,
      child: Container(
        height: 55,
        width: double.infinity,
        child: Center(
          child:
              Text(text, style: TextStyle(color: Colors.white, fontSize: 25)),
        ),
      ),
    );
  }
}
