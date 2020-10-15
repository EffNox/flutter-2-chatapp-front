import 'package:chat/global/env.dart';
import 'package:chat/models/rs_usuario.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/services/auth.dart';

import 'package:http/http.dart' as http;

class SUsuario {
  Future<List<Usuario>> getAll() async {
    try {
      final rs = await http.get('${Env.url}/usuario', headers: {
        'Content-Type': 'application/json',
        'x-tk': await SAuth.getTk()
      });
      final dtRs = usuarioRsFromJson(rs.body);
      return dtRs.dt;
    } catch (e) {
      return [];
    }
  }
}
