import 'dart:io';

import 'package:chat/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPg extends StatefulWidget {
  @override
  _ChatPgState createState() => _ChatPgState();
}

class _ChatPgState extends State<ChatPg> with TickerProviderStateMixin {
  final _txtMsj = TextEditingController();
  final _focusNode = FocusNode();

  List<ChatMessage> _messages = [];

  bool _estaEscribiendo = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(child: Text('Te'), backgroundColor: Colors.blue[100]),
            SizedBox(width: 10),
            Text('Ximena Sanchez', style: TextStyle(color: Colors.black87)),
          ],
        ),
        elevation: 1,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
                child: ListView.builder(
              physics: BouncingScrollPhysics(),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, i) => _messages[i],
            )),
            Divider(height: 1),
            Container(color: Colors.white, child: _inputChat())
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _txtMsj,
              onSubmitted: _onSubmit,
              onChanged: (v) =>
                  setState(() => _estaEscribiendo = (v.trim().length > 0)),
              decoration: InputDecoration.collapsed(hintText: 'Enviar mensaje'),
              focusNode: _focusNode,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: Platform.isIOS
                ? CupertinoButton(
                    child: Text('Enviar'),
                    onPressed: _estaEscribiendo
                        ? () => _onSubmit(_txtMsj.text.trim())
                        : null)
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconTheme(
                      data: IconThemeData(color: Colors.blue),
                      child: IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          icon: Icon(Icons.send),
                          onPressed: _estaEscribiendo
                              ? () => _onSubmit(_txtMsj.text.trim())
                              : null),
                    ),
                  ),
          ),
        ],
      ),
    ));
  }

  _onSubmit(String v) {
    if (!_estaEscribiendo) return;
    final newMsg = ChatMessage(
        id: '123',
        txt: v,
        aniCon: AnimationController(
            vsync: this, duration: Duration(milliseconds: 500)));
    _messages.insert(0, newMsg);
    newMsg.aniCon.forward();
    _focusNode.requestFocus();
    _estaEscribiendo = false;
    _txtMsj.clear();
    setState(() {});
  }

  @override
  void dispose() {
    for (ChatMessage msg in _messages) {
      msg.aniCon.dispose();
    }
    // TODO off socket
    super.dispose();
  }
}
