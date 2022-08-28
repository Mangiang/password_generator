import 'package:flutter/material.dart';
import 'package:password_generator/components/GenerationPassConfirmation.dart';
import 'package:password_generator/state/PasswordState.dart';
import 'package:provider/provider.dart';

import '../components/CustomButton.dart';
import '../components/CustomCheckbox.dart';
import '../components/DeletionConfirmation.dart';
import '../state/PasswordState.dart';
import '../utils/PasswordGenerator.dart';

class ActionsRow extends StatefulWidget {
  const ActionsRow({Key? key}) : super(key: key);

  @override
  State<ActionsRow> createState() => _ActionsRowState();
}

class _ActionsRowState extends State<ActionsRow> {
  bool increaseRegenerationPass = false;

  bool areButtonsEnabled(PasswordState state) {
    return state.passphrase1.isNotEmpty &&
        state.passphrase2.isNotEmpty &&
        state.desiredLength > 0;
  }

  Future<void> handleGeneration(PasswordState state) async {
    GenerationPassDialogAction? response;
    if (increaseRegenerationPass) {
      response = await showDialog(
              context: context,
              builder: (context) => const GenerationPassConfirmation())
          as GenerationPassDialogAction?;
      setState(() {
        increaseRegenerationPass = false;
      });
    }

    if (areButtonsEnabled(state)) {
      state.updatePassword(await PasswordGenerator.getPassword(
          state, response == GenerationPassDialogAction.increase));
    }
  }

  Future<void> handleDeletion(PasswordState state) async {
    final response = await showDialog(
            context: context,
            builder: (context) => const DeletionConfirmation())
        as DeleteDialogAction?;
    if (response == DeleteDialogAction.delete) {
      PasswordGenerator.removeFromDataFile(state);
    }
  }

  void handleRegenerationPassChange(bool? newValue) {
    setState(() {
      increaseRegenerationPass = newValue == true;
    });
  }

  @override
  Widget build(BuildContext context) =>
      Consumer<PasswordState>(builder: (context, state, child) {
        return Column(
          children: [
            CustomCheckbox(
              label: "Increase regeneration pass",
              isChecked: increaseRegenerationPass,
              onChanged: handleRegenerationPassChange,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomButton(
                    type: ButtonType.danger,
                    text: 'Delete entry',
                    enabled: areButtonsEnabled(state),
                    onPressed: () async => handleDeletion(state),
                  ),
                ),
                const SizedBox(width: 50),
                Expanded(
                  child: CustomButton(
                    type: ButtonType.success,
                    text: 'Generate',
                    enabled: areButtonsEnabled(state),
                    onPressed: () async => handleGeneration(state),
                  ),
                ),
              ],
            ),
          ],
        );
      });
}
