import 'dart:convert';
import 'package:chat/models/usuario.dart';

UsuarioRs usuarioRsFromJson(String str) => UsuarioRs.fromJson(json.decode(str));

String usuarioRsToJson(UsuarioRs data) => json.encode(data.toJson());

class UsuarioRs {
    UsuarioRs({
        this.dt,
    });

    List<Usuario> dt;

    factory UsuarioRs.fromJson(Map<String, dynamic> json) => UsuarioRs(
        dt: List<Usuario>.from(json["dt"].map((x) => Usuario.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "dt": List<dynamic>.from(dt.map((x) => x.toJson())),
    };
}
