import 'package:chat/helpers/alert.dart';
import 'package:chat/services/auth.dart';
import 'package:chat/services/ssocket.dart';
import 'package:chat/widgets/btn_azul.dart';
import 'package:chat/widgets/input.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Logo(
                    title: 'Messenger',
                  ),
                  _Form(),
                  Labels(
                      url: 'register',
                      title: '¿No tienes cuenta?',
                      subtitle: 'Crea una ahora!')
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final txtCor = TextEditingController();
  final txtPwd = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<SAuth>(context);
    final svSocket = Provider.of<SSocket>(context);
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
              icon: Icons.mail_outline,
              placeholder: 'Correo',
              keyboardType: TextInputType.emailAddress,
              txtCon: txtCor),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            keyboardType: TextInputType.visiblePassword,
            txtCon: txtPwd,
            isPwd: true,
          ),
          BotonAzul(
              text: 'Ingresar',
              onPress: _auth.autenticando
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final ok =
                          await _auth.login(txtCor.text.trim(), txtPwd.text);
                      if (ok) {
                        svSocket.connect();
                        Navigator.pushReplacementNamed(context, 'usuarios');
                      } else {
                        showAlert(context, 'Login incorrecto',
                            'Correo y/o contraseña invalidos');
                      }
                    })
        ],
      ),
    );
  }
}
