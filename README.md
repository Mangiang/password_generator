# Password Generator
<a href='https://github.com/shivamkapasia0' target="_blank"><img alt='Windows' src='https://img.shields.io/badge/Windows-100000?style=flat&logo=Windows&logoColor=white&labelColor=505050&color=8bb803'/></a>
<a href='https://github.com/shivamkapasia0' target="_blank"><img alt='Android' src='https://img.shields.io/badge/Android-100000?style=flat&logo=Android&logoColor=white&labelColor=505050&color=8bb803'/></a>

A simple password generator
<p>
    <img src="./docs/warning.png" alt="warning" width="100" height="100">
        This project is a personal study. Do not use for production or sensible data !
    <img src="./docs/warning.png" alt="warning" width="100" height="100">
</p>

<p>
<img src="./docs/passwordGeneratorScreenshotAndroid.png" alt="PasswordGeneratorScreenshotAndroid" width="auto" height="500">
<img src="./docs/passwordGeneratorScreenshotWindows.png" alt="PasswordGeneratorScreenshotWindows" width="500" height="auto">
</p>

## How to run

Grab a binary in the release section of this repository.

Note that the application relies on a local file created and updated by this application for the password regeneration.
It is determined by the `path_provider` package, usually:
- Windows: `C:\Users\<Username>\OneDrive\Documents\password_generator`
- Android: `/data/data/com.github.mangiang.password-generator`

## How to build

### Android

* Run `flutter build apk`
* The resulting artifact is located at `[project]/build/app/outputs/apk/release/` 

### Windows 

* Make sure Visual Studio `Desktop development with C++` workload is installed.
* Run `flutter build windows` to build the application
* The resulting artifact is located at `[project]/build/windows/runner/Release`
* [Optional] Run `flutter pub run msix:create` to create an msix installer


Sources:
- warning icon: [stickpng.com](https://www.stickpng.com/img/miscellaneous/safety-symbols-and-signs/warning-icon)
