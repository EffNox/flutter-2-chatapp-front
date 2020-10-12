import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String txt;
  final String id;
  final AnimationController aniCon;
  const ChatMessage(
      {@required this.txt,
      @required this.id,
      @required this.aniCon});
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: aniCon,
      child: SizeTransition(sizeFactor: CurvedAnimation(parent: aniCon, curve: Curves.easeInOut),child: Container(child: id == '123' ? _myMsg() : _notMyMsg())),
    );
  }

  _myMsg() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(bottom: 5.0, left: 50, right: 10),
        padding: EdgeInsets.all(8.0),
        child: Text(txt, style: TextStyle(color: Colors.white)),
        decoration: BoxDecoration(
            color: Color(0xff4D9EF6), borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  _notMyMsg() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 5.0, left: 10, right: 50),
        padding: EdgeInsets.all(8.0),
        child: Text(txt, style: TextStyle(color: Colors.black87)),
        decoration: BoxDecoration(
            color: Color(0xffE4E5E8), borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
