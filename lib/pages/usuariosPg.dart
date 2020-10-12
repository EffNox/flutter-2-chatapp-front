import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPg extends StatefulWidget {
  @override
  _UsuariosPgState createState() => _UsuariosPgState();
}

class _UsuariosPgState extends State<UsuariosPg> {
  RefreshController _rfCon = RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(id: '1', nom: 'Fernando', cor: 'test@gmail.com', online: true),
    Usuario(id: '2', nom: 'Ximena', cor: 'test1@gmail.com', online: false),
    Usuario(id: '3', nom: 'Meliza', cor: 'test2@gmail.com', online: true),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Nombre', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.grey, size: 35),
            onPressed: () {}),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child:
                // Icon(Icons.cancel, color: Colors.red,size: 45),
                Icon(Icons.check_circle, color: Colors.blue, size: 45),
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
    );
  }

  _cargarUsuarios() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _rfCon.refreshCompleted();
  }
}
