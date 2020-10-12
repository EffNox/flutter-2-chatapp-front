import 'package:chat/widgets/btn_azul.dart';
import 'package:chat/widgets/input.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:flutter/material.dart';

class RegisterPg extends StatelessWidget {
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
                  Logo(title: 'Registro'),
                  _Form(),
                  Labels(
                      url: 'login',
                      title: '¿Ya tienes cuenta?',
                      subtitle: 'Ingresa ahora!')
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
  final txtNom = TextEditingController();
  final txtCor = TextEditingController();
  final txtPwd = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
              icon: Icons.perm_identity, placeholder: 'Nombre', txtCon: txtNom),
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
              onPress: () {
                print(txtNom.text);
                print(txtCor.text);
                print(txtPwd.text);
              })
        ],
      ),
    );
  }
}
