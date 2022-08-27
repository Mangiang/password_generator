import 'package:flutter/material.dart';
import 'package:password_generator/state/PasswordState.dart';
import 'package:provider/provider.dart';

import '../components/CustomButton.dart';
import '../state/PasswordState.dart';
import '../utils/PasswordGenerator.dart';

enum DeleteDialogAction { cancel, delete }

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

  Future<void> handleGeneration(PasswordState state) async {
    if (areButtonsEnabled(state)) {
      state.updatePassword(await PasswordGenerator.getPassword(state));
    }
  }

  @override
  Widget build(BuildContext context) =>
      Consumer<PasswordState>(builder: (context, state, child) {
        AlertDialog alert = AlertDialog(
          title: const Text("Do you really want to delete this entry ?"),
          content: const Text(
            "Warning: This action is irreversible !",
          ),
          actions: [
            CustomButton(
              type: ButtonType.neutral,
              text: 'Cancel',
              enabled: true,
              onPressed: () =>
                  Navigator.pop(context, DeleteDialogAction.cancel),
            ),
            CustomButton(
              type: ButtonType.danger,
              text: 'Delete anyways',
              enabled: true,
              onPressed: () =>
                  Navigator.pop(context, DeleteDialogAction.delete),
            ),
          ],
          backgroundColor: const Color(0xff22272e),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          contentTextStyle: const TextStyle(color: Colors.red, fontSize: 16),
        );

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CustomButton(
                type: ButtonType.danger,
                text: 'Delete entry',
                enabled: areButtonsEnabled(state),
                onPressed: () async {
                  final response =
                      await showDialog(context: context, builder: (context) => alert)
                          as DeleteDialogAction;
                  if (response == DeleteDialogAction.delete) {
                    PasswordGenerator.removeFromDataFile(state);
                  }
                },
              ),
            ),
            const SizedBox(width: 50),
            Expanded(
              child: CustomButton(
                type: ButtonType.success,
                text: 'Generate',
                enabled: areButtonsEnabled(state),
                onPressed: () => handleGeneration(state),
              ),
            ),
          ],
        );
      });
}
