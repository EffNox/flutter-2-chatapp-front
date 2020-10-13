import 'dart:convert';
import 'package:chat/global/env.dart';
import 'package:chat/models/login_rs.dart';
import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SAuth with ChangeNotifier {
  Usuario usuario;
  final hd = {'Content-Type': 'application/json'};

  bool _autenticando = false;
  final _storage = new FlutterSecureStorage();

  bool get autenticando => _autenticando;
  set autenticando(bool v) {
    _autenticando = v;
    notifyListeners();
  }

  static Future<String> getTk() async {
    final _storage = new FlutterSecureStorage();
    return await _storage.read(key: 'tk');
  }

  static Future<void> deleteTk() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'tk');
  }

  Future<bool> login(cor, pwd) async {
    autenticando = true;
    final dt = {'cor': cor, 'pwd': pwd};

    final rs = await http.post('${Env.url}/auth/login',
        headers: hd, body: jsonEncode(dt));

    autenticando = false;
    if (rs.statusCode == 200) {
      final loginRs = loginRsFromJson(rs.body);
      usuario = loginRs.dt;
      await _saveTk(loginRs.tk);
      return true;
    } else {
      return false;
    }
  }

  Future register(nom, cor, pwd) async {
    autenticando = true;
    final dt = {"nom": nom, "cor": cor, "pwd": pwd};
    final rs = await http.post('${Env.url}/auth/new',
        headers: hd, body: jsonEncode(dt));

    autenticando = false;
    if (rs.statusCode == 200) {
      final loginRs = loginRsFromJson(rs.body);
      usuario = loginRs.dt;
      await _saveTk(loginRs.tk);
      return true;
    } else {
      final rsBd = jsonDecode(rs.body);
      return rsBd['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final tk = await _storage.read(key: 'tk');
    final rs = await http.get('${Env.url}/auth/renew', headers: {'x-tk': tk});
    if (rs.statusCode == 200) {
      final loginRs = loginRsFromJson(rs.body);
      usuario = loginRs.dt;
      await _saveTk(loginRs.tk);
      return true;
    } else {
      _logout(tk);
      return false;
    }
  }

  Future _saveTk(String tk) async {
    return await _storage.write(key: 'tk', value: tk);
  }

  Future _logout(String tk) async {
    return await _storage.delete(key: 'tk');
  }
}
