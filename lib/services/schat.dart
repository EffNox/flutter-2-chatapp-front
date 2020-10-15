import 'package:chat/global/env.dart';
import 'package:chat/models/rs_mensaje.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SChat with ChangeNotifier {
  Usuario usuarioTo;

  Future<List<Mensaje>> getByFrom(String id) async {
    final rs = await http.get('${Env.url}/mensaje/$id', headers: {
      'Content-Type': 'application/json',
      'x-tk': await SAuth.getTk()
    });
    final dt = mensajeRsFromJson(rs.body);
    return dt.dt;
  }
}
