import 'package:chat/routes/routes.dart';
import 'package:chat/services/auth.dart';
import 'package:chat/services/schat.dart';
import 'package:chat/services/ssocket.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SAuth()),
        ChangeNotifierProvider(create: (_) => SSocket()),
        ChangeNotifierProvider(create: (_) => SChat())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}
