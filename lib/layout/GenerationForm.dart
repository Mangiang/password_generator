import 'package:flutter/material.dart';
import 'package:password_generator/state/PasswordState.dart';
import 'package:provider/provider.dart';

import '../components/CustomCheckbox.dart';
import '../components/NumberInput.dart';
import '../components/PasswordInput.dart';

class GenerationForm extends StatefulWidget {
  const GenerationForm({
    Key? key,
  }) : super(key: key);

  @override
  State<GenerationForm> createState() => _GenerationFormState();
}

class _GenerationFormState extends State<GenerationForm> {
  bool isOptionPanelOpen = false;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Consumer<PasswordState>(
            builder: (context, state, child) {
              return PasswordInput(
                onChanged: (newValue) => state.updateFirstPassphrase(newValue),
                label: "First passphrase",
              );
            },
          ),
          const SizedBox(height: 10),
          Consumer<PasswordState>(
            builder: (context, state, child) {
              return PasswordInput(
                onChanged: (newValue) => state.updateSecondPassphrase(newValue),
                label: "Second passphrase",
              );
            },
          ),
          const SizedBox(height: 10),
          Consumer<PasswordState>(
            builder: (context, state, child) {
              return NumberInput(
                value: state.desiredLength,
                onChanged: (newValue) {
                  int? newIntValue = int.tryParse(newValue, radix: 10);
                  state.updateDesiredLength(newIntValue ?? 1);
                },
                label: "Desired Length",
              );
            },
          ),
          const SizedBox(height: 40),
          ExpansionPanelList(
            elevation: 4,
            dividerColor: Colors.white,
            expandedHeaderPadding: EdgeInsets.zero,
            children: [
              ExpansionPanel(
                isExpanded: isOptionPanelOpen,
                headerBuilder: (context, isOpen) => const Center(
                  child: Text(
                    "~~~ Options ~~~",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<PasswordState>(
                      builder: (context, state, child) {
                        return PasswordInput(
                          onChanged: (newValue) =>
                              state.updateblacklist(newValue),
                          enableVisibility: false,
                          label: "Blacklist characters",
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Consumer<PasswordState>(
                              builder: (context, state, child) =>
                                  CustomCheckbox(
                                label: "lower case",
                                isChecked: state.includeLowerCase,
                                onChanged: state.updateIncludeLowerCase,
                              ),
                            ),
                            Consumer<PasswordState>(
                              builder: (context, state, child) =>
                                  CustomCheckbox(
                                label: "upper case",
                                isChecked: state.includeUpperCase,
                                onChanged: state.updateIncludeUpperCase,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Consumer<PasswordState>(
                              builder: (context, state, child) =>
                                  CustomCheckbox(
                                label: "numbers",
                                isChecked: state.includeNumbers,
                                onChanged: state.updateIncludeNumber,
                              ),
                            ),
                            Consumer<PasswordState>(
                              builder: (context, state, child) =>
                                  CustomCheckbox(
                                label: "symbols",
                                isChecked: state.includeSymbols,
                                onChanged: state.updateIncludeSymbols,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                backgroundColor: const Color(0xff242930),
// const Color(0xff2d333b),
// const Color(0xff22272e)
                canTapOnHeader: true,
              ),
            ],
            expansionCallback: (i, isOpen) {
              setState(() => isOptionPanelOpen = !isOpen);
            },
          )
        ],
      );
}
