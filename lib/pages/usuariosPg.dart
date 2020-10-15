import 'package:chat/models/usuario.dart';
import 'package:chat/services/auth.dart';
import 'package:chat/services/schat.dart';
import 'package:chat/services/ssocket.dart';
import 'package:chat/services/susuario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPg extends StatefulWidget {
  @override
  _UsuariosPgState createState() => _UsuariosPgState();
}

class _UsuariosPgState extends State<UsuariosPg> {
  RefreshController _rfCon = RefreshController(initialRefresh: false);
  final svUsu = SUsuario();

  List<Usuario> usuarios = [];
  @override
  void initState() {
    _cargarUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final svAuth = Provider.of<SAuth>(context);
    final svSocket = Provider.of<SSocket>(context);
    final u = svAuth.usuario;
    return Scaffold(
      appBar: AppBar(
        title: Text(u.nom, style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.grey, size: 35),
            onPressed: () {
              svSocket.disconnect();
              Navigator.pushReplacementNamed(context, 'login');
              SAuth.deleteTk();
            }),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: svSocket.svrSt == ServerStatus.Online
                ? Icon(Icons.check_circle, color: Colors.blue, size: 45)
                : Icon(Icons.cancel, color: Colors.red, size: 45),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _rfCon,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue),
          waterDropColor: Colors.blue[400],
        ),
        child: _usuariosListView(),
      ),
    );
  }

  ListView _usuariosListView() {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, i) => _usuariosListTile(usuarios[i]),
        separatorBuilder: (_, i) => Divider(),
        itemCount: usuarios.length);
  }

  ListTile _usuariosListTile(Usuario u) {
    return ListTile(
      title: Text(u.nom),
      subtitle: Text(u.cor),
      leading: CircleAvatar(
        child: Text(u.nom.substring(0, 2)),
        backgroundColor: Colors.blue[100],
      ),
      trailing: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
            color: u.online ? Colors.lightGreen : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
      onTap: () {
        final svChat = Provider.of<SChat>(context, listen: false);
        svChat.usuarioTo = u;
        Navigator.pushNamed(context, 'chat');
      },
    );
  }

  _cargarUsuarios() async {
    usuarios = await svUsu.getAll();
    setState(() {});
    // await Future.delayed(Duration(milliseconds: 1000));
    _rfCon.refreshCompleted();
  }
}
