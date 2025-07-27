import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:siana_erran_app/core/theme/app_theme.dart';
import 'package:siana_erran_app/core/utils/assets_utiles.dart';
import 'package:siana_erran_app/features/welcome/screens/launch_screen.dart';
import 'package:siana_erran_app/features/welcome/screens/welcome_screen.dart';
import 'package:siana_erran_app/providers/errand/location_provider.dart';
import 'package:siana_erran_app/providers/errand/task_provider.dart';
import 'package:siana_erran_app/providers/errand/ui_state_provider.dart';
import 'package:siana_erran_app/providers/theme_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // make navigation bar transparent
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent),
  );
  // make flutter draw behind navigation bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ChangeNotifierProvider<TaskProvider>(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider<UIStateProvider>(
          create: (_) => UIStateProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeMode _convertToThemeMode(dynamic appThemeMode) {
    // Adjust this based on your AppThemeMode enum values
    switch (appThemeMode.toString()) {
      case 'AppThemeMode.light':
        return ThemeMode.light;
      case 'AppThemeMode.dark':
        return ThemeMode.dark;
      case 'AppThemeMode.system':
      default:
        return ThemeMode.system;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Siana',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: _convertToThemeMode(
            themeProvider.themeMode,
          ),
          home: const AppLaunchPage(),
          debugShowCheckedModeBanner: false, 
        );
      },
    );
  }
}

class AppLaunchPage extends StatefulWidget {
  const AppLaunchPage({super.key});

  @override
  State<AppLaunchPage> createState() => _AppLaunchPageState();
}

class _AppLaunchPageState extends State<AppLaunchPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final asset = themeProvider.getThemedAsset(
          context,
          lightAsset: "${iconPath}siana_ac_b.png",
          darkAsset: "${iconPath}siana_ic.png",
        );

        return LaunchScreen(
          logoAsset: asset,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          logoColor: Theme.of(context).primaryColor,
          logoSize: 250,
          displayDuration: const Duration(seconds: 2),
          showLoadingIndicator: true,
          onAnimationComplete: () {
            if (mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const WelcomeScreen()),
              );
            }
          },
        );
      },
    );
  }
}
