import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siana_erran_app/core/theme/app_theme.dart';
import 'package:siana_erran_app/core/utils/assets_utiles.dart';
import 'package:siana_erran_app/features/welcome/screens/launch_screen.dart';
import 'package:siana_erran_app/features/welcome/screens/welcome_screen.dart';
import 'package:siana_erran_app/providers/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [Provider<ThemeProvider>(create: (_) => ThemeProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Siana',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final asset = themeProvider.getThemedAsset(
      context,
      lightAsset: "${iconPath}siana_ic.png",
      darkAsset: "${iconPath}siana_ac_b.png",
    );

    return LaunchScreen(
      logoAsset: asset,
      backgroundColor: Colors.black, // Dark gray
      logoColor: Colors.white,
      logoSize: 120,
      displayDuration: const Duration(seconds: 2),
      showLoadingIndicator: true,
      onAnimationComplete: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
        );
      },
    );
  }
}
