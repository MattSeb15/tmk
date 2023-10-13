import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tmk/core/data/share_preferences.dart';
import 'package:tmk/home.dart';
import 'package:tmk/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await UserSimplePreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TMK',
      theme: ThemeDataApp.ligthTheme,
      darkTheme: ThemeDataApp.darkTheme,
      themeMode: ThemeMode.dark,
      home: const HomeScreen(),
    );
  }
}
