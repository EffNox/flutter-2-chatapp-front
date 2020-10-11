import 'package:chat/pages/chatPg.dart';
import 'package:chat/pages/loadingPg.dart';
import 'package:chat/pages/loginPg.dart';
import 'package:chat/pages/registerPg.dart';
import 'package:chat/pages/usuariosPg.dart';

final appRoutes = {
  'usuarios': (_) => UsuariosPg(),
  'chat': (_) => ChatPg(),
  'login': (_) => LoginPg(),
  'register': (_) => RegisterPg(),
  'loading': (_) => LoadingPg(),
};
