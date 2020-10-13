import 'dart:convert';

import 'package:chat/models/usuario.dart';

LoginRs loginRsFromJson(String str) => LoginRs.fromJson(json.decode(str));
String loginRsToJson(LoginRs data) => json.encode(data.toJson());

class LoginRs {
  LoginRs({
    this.dt,
    this.tk,
  });
  Usuario dt;
  String tk;

  factory LoginRs.fromJson(Map<String, dynamic> json) => LoginRs(
        dt: Usuario.fromJson(json["dt"]),
        tk: json["tk"],
      );
  Map<String, dynamic> toJson() => {
        "dt": dt.toJson(),
        "tk": tk,
      };
}
