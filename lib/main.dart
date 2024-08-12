import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:e_commerce/screens/home/bloc/home_bloc.dart';
import 'package:e_commerce/screens/home/ui/home_ui.dart';
import 'package:e_commerce/utils/thems.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        light: lightTheme,
        dark: darkTheme,
        initial: AdaptiveThemeMode.dark,
        builder: (theme, darkTheme) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: theme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.dark,
            debugShowCheckedModeBanner: false,
            home: const HomeUi(),
          );
        });
  }
}
