import 'package:chat/pages/loginPg.dart';
import 'package:chat/pages/usuariosPg.dart';
import 'package:chat/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Text('Espere...'),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final svAuth = Provider.of<SAuth>(context, listen: false);
    final autenticado = await svAuth.isLoggedIn();
    if (autenticado) {
      // Navigator.popAndPushNamed(context, 'usuarios');
      Navigator.pushReplacement(
          context, PageRouteBuilder(pageBuilder: (_, __, ___) => UsuariosPg(),transitionDuration: Duration(milliseconds: 0)));
    } else {
      // Navigator.popAndPushNamed(context, 'login');
      Navigator.pushReplacement(
          context, PageRouteBuilder(pageBuilder: (_, __, ___) => LoginPg(),transitionDuration: Duration(milliseconds: 0)));
    }
  }
}
