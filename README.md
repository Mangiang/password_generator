# Password Generator
<a href='https://github.com/shivamkapasia0' target="_blank"><img alt='Windows' src='https://img.shields.io/badge/Windows-100000?style=flat&logo=Windows&logoColor=white&labelColor=505050&color=8bb803'/></a>
<a href='https://github.com/shivamkapasia0' target="_blank"><img alt='Android' src='https://img.shields.io/badge/Android-100000?style=flat&logo=Android&logoColor=white&labelColor=505050&color=8bb803'/></a>

A simple password generator

![PasswordGeneratorScreenshot](./docs/passwordGeneratorScreenshot.png)

## How to run

Grab a binary in the release section of this repository.

## How to build

### Android

* Run `flutter build apk --split-per-abi`
* The resulting artifact is located at `[project]/build/app/outputs/apk/release/` 

### Windows 

* Make sure Visual Studio `Desktop development with C++` workload is installed.
* Run `flutter build windows` to build the application
* The resulting artifact is located at `[project]/build/windows/runner/Release`
* [Optional] Run `flutter pub run msix:create` to create an msix installer


Sources:
- warning icon: [stickpng.com](https://www.stickpng.com/img/miscellaneous/safety-symbols-and-signs/warning-icon)