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
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(60, 40, 0, 60),
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FractionallySizedBox(
                widthFactor: .9,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    SizedBox(height: 40),
                    GenerationForm(),
                    SizedBox(height: 40),
                    ActionsRow(),
                    SizedBox(height: 20),
                    PasswordDisplay()
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
