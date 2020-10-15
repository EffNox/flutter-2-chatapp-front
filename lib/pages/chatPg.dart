import 'dart:io';

import 'package:chat/models/rs_mensaje.dart';
import 'package:chat/services/auth.dart';
import 'package:chat/services/schat.dart';
import 'package:chat/services/ssocket.dart';
import 'package:chat/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPg extends StatefulWidget {
  @override
  _ChatPgState createState() => _ChatPgState();
}

class _ChatPgState extends State<ChatPg> with TickerProviderStateMixin {
  final _txtMsj = TextEditingController();
  final _focusNode = FocusNode();
  SChat svChat;
  SSocket svSock;
  SAuth svAuth;

  List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    svChat = Provider.of<SChat>(context, listen: false);
    svSock = Provider.of<SSocket>(context, listen: false);
    svAuth = Provider.of<SAuth>(context, listen: false);
    svSock.socket.on('private-msg', _listenMsg);
    _loadHistory(svChat.usuarioTo.id);
  }

  _loadHistory(String id) async {
    List<Mensaje> chats = await svChat.getByFrom(id);
    final history = chats.map((m) => ChatMessage(
        txt: m.msg,
        id: m.from,
        aniCon: AnimationController(
            vsync: this, duration: Duration(milliseconds: 600))
          ..forward()));
    _messages.insertAll(0, history);
    setState(() {});
  }

  _listenMsg(dt) {
    ChatMessage msg = ChatMessage(
      id: dt['from'],
      txt: dt['msg'],
      aniCon: AnimationController(
          vsync: this, duration: Duration(milliseconds: 500)),
    );
    setState(() {
      _messages.insert(0, msg);
    });
    msg.aniCon.forward();
  }

  bool _estaEscribiendo = false;
  @override
  Widget build(BuildContext context) {
    final uTo = svChat.usuarioTo;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
                child: Text(uTo.nom.substring(0, 2)),
                backgroundColor: Colors.blue[100]),
            SizedBox(width: 10),
            Text(uTo.nom, style: TextStyle(color: Colors.black87)),
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
        id: svAuth.usuario.id,
        txt: v,
        aniCon: AnimationController(
            vsync: this, duration: Duration(milliseconds: 500)));
    _messages.insert(0, newMsg);
    newMsg.aniCon.forward();
    _focusNode.requestFocus();
    _estaEscribiendo = false;
    _txtMsj.clear();
    setState(() {});
    svSock.emit('private-msg',
        {'from': svAuth.usuario.id, 'to': svChat.usuarioTo.id, 'msg': v});
    // svSock.emit('private-msg', {'to': svChat.usuarioTo.id, 'msg': v});
  }

  @override
  void dispose() {
    for (ChatMessage msg in _messages) {
      msg.aniCon.dispose();
    }
    svSock.socket.off('private-msg');
    super.dispose();
  }
}
