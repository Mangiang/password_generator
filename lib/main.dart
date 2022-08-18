import 'package:flutter/material.dart';
import 'package:password_generator/NumberInput.dart';
import 'package:password_generator/PasswordInput.dart';
import 'package:password_generator/state/PasswordState.dart';
import 'package:password_generator/utils/PasswordGenerator.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => PasswordState(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password Generator',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void GeneratePassword(PasswordState state) {
    state.UpdatePassword(PasswordGenerator.getPassword(
        state.passphrase1, state.passphrase2, state.desiredLength));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff22272e),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: .8,
          heightFactor: .8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Consumer<PasswordState>(
                builder: (context, state, child) {
                  return PasswordInput(
                    onChanged: (newValue) =>
                        state.UpdateFirstPassphrase(newValue),
                    label: "First passphrase",
                  );
                },
              ),
              const SizedBox(height: 10),
              Consumer<PasswordState>(
                builder: (context, state, child) {
                  return PasswordInput(
                    onChanged: (newValue) =>
                        state.UpdateSecondPassphrase(newValue),
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
                      state.UpdateDesiredLength(newIntValue ?? 1);
                    },
                    label: "Desired Length",
                  );
                },
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Delete'),
                    ),
                  ),
                  const SizedBox(width: 50),
                  Expanded(
                    child: Consumer<PasswordState>(
                      builder: (context, state, child) {
                        return ElevatedButton(
                          onPressed: () => GeneratePassword(state),
                          child: const Text(
                            'Generate',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xff347d39))),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Consumer<PasswordState>(
                builder: (context, state, child) {
                  return PasswordInput(
                    onChanged: (newValue) => {},
                    enabled: false,
                    enableCopy: true,
                    value: state.password,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
