import 'package:flutter/material.dart';

import 'CustomButton.dart';

enum GenerationPassDialogAction { cancel, increase }

class GenerationPassConfirmation extends StatelessWidget {
  const GenerationPassConfirmation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text("Do you really want to increase this generation pass ?"),
        content: const Text(
          "Warning: This action is irreversible !",
        ),
        actions: [
          CustomButton(
            type: ButtonType.neutral,
            text: 'Cancel',
            enabled: true,
            onPressed: () => Navigator.pop(context, GenerationPassDialogAction.cancel),
          ),
          CustomButton(
            type: ButtonType.danger,
            text: 'Increase',
            enabled: true,
            onPressed: () => Navigator.pop(context, GenerationPassDialogAction.increase),
          ),
        ],
        backgroundColor: const Color(0xff22272e),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        contentTextStyle: const TextStyle(color: Colors.red, fontSize: 16),
      );
}
