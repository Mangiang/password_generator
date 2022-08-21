import 'package:flutter/material.dart';
import 'package:password_generator/state/PasswordState.dart';
import 'package:provider/provider.dart';

import '../components/PasswordInput.dart';

class PasswordDisplay extends StatefulWidget {
  const PasswordDisplay({
    Key? key,
  }) : super(key: key);

  @override
  State<PasswordDisplay> createState() => _PasswordDisplayState();
}

class _PasswordDisplayState extends State<PasswordDisplay> {
  @override
  Widget build(BuildContext context) => Consumer<PasswordState>(
        builder: (context, state, child) {
          return PasswordInput(
            onChanged: (newValue) => {},
            enabled: false,
            enableCopy: true,
            value: state.password,
          );
        },
      );
}
