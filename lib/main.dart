import 'dart:io';

import 'package:flutter/material.dart';
import 'package:password_generator/state/PasswordState.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';

import 'layout/HomePage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    setWindowTitle('Password Generator');
    setWindowMinSize(const Size(720, 720));
    setWindowMaxSize(Size.infinite);
  }

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
