import 'package:flutter/material.dart';
import 'package:password_generator/state/PasswordState.dart';
import 'package:provider/provider.dart';

import 'layout/HomePage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider(
    create: (context) => PasswordState(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Password Generator',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: const HomePage(),
      );
}
