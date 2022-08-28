import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password_generator/layout/GenerationActionsRow.dart';
import 'package:password_generator/layout/GenerationForm.dart';
import 'package:password_generator/layout/PasswordDisplay.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xff22272e),
        body: Center(
          child: FractionallySizedBox(
            widthFactor: .8,
            heightFactor: .8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                GenerationForm(),
                SizedBox(height: 40),
                ActionsRow(),
                SizedBox(height: 20),
                PasswordDisplay()
              ],
            ),
          ),
        ),
      );
}
