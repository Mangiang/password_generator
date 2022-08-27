import 'package:flutter/material.dart';
import 'package:password_generator/components/DangerButton.dart';
import 'package:password_generator/components/ValidationButton.dart';
import 'package:password_generator/state/PasswordState.dart';
import 'package:provider/provider.dart';

import '../state/PasswordState.dart';

class ActionsRow extends StatefulWidget {
  const ActionsRow({Key? key}) : super(key: key);

  @override
  State<ActionsRow> createState() => _ActionsRowState();
}

class _ActionsRowState extends State<ActionsRow> {
  Color deleteButtonColor = const Color(0xff70383a);

  bool areButtonsEnabled(PasswordState state) {
    return state.passphrase1.isNotEmpty &&
        state.passphrase2.isNotEmpty &&
        state.desiredLength > 0;
  }

  @override
  Widget build(BuildContext context) =>
      Consumer<PasswordState>(builder: (context, state, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: DangerButton(
                enabled: areButtonsEnabled(state),
              ),
            ),
            const SizedBox(width: 50),
            Expanded(
              child: ValidationButton(
                enabled: areButtonsEnabled(state),
              ),
            ),
          ],
        );
      });
}
