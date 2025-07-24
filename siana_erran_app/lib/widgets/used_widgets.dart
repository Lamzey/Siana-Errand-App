// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// // Theme Mode Enum
// enum AppThemeMode {
//   light,
//   dark,
//   system,
// }

// // Theme Provider Class
// class ThemeProvider with ChangeNotifier {
//   static const String _themeKey = 'app_theme_mode';
  
//   AppThemeMode _themeMode = AppThemeMode.system;
//   late SharedPreferences _prefs;
//   bool _isInitialized = false;

//   AppThemeMode get themeMode => _themeMode;
//   bool get isInitialized => _isInitialized;

//   // Get current theme mode based on system settings
//   ThemeMode get materialThemeMode {
//     switch (_themeMode) {
//       case AppThemeMode.light:
//         return ThemeMode.light;
//       case AppThemeMode.dark:
//         return ThemeMode.dark;
//       case AppThemeMode.system:
//         return ThemeMode.system;
//     }
//   }

//   // Check if current theme is dark
//   bool isDarkMode(BuildContext context) {
//     switch (_themeMode) {
//       case AppThemeMode.light:
//         return false;
//       case AppThemeMode.dark:
//         return true;
//       case AppThemeMode.system:
//         return MediaQuery.of(context).platformBrightness == Brightness.dark;
//     }
//   }

//   // Initialize theme provider
//   Future<void> initialize() async {
//     _prefs = await SharedPreferences.getInstance();
//     final savedTheme = _prefs.getString(_themeKey);
    
//     if (savedTheme != null) {
//       _themeMode = AppThemeMode.values.firstWhere(
//         (mode) => mode.toString() == savedTheme,
//         orElse: () => AppThemeMode.system,
//       );
//     }
    
//     _isInitialized = true;
//     notifyListeners();
//   }

//   // Set theme mode
//   Future<void> setThemeMode(AppThemeMode mode) async {
//     if (_themeMode == mode) return;
    
//     _themeMode = mode;
//     await _prefs.setString(_themeKey, mode.toString());
    
//     // Update system UI overlay style
//     _updateSystemUIOverlayStyle();
    
//     notifyListeners();
//   }

//   // Update system UI overlay style based on theme
//   void _updateSystemUIOverlayStyle() {
//     SystemChrome.setSystemUIOverlayStyle(
//       _themeMode == AppThemeMode.dark
//           ? SystemUiOverlayStyle.light
//           : _themeMode == AppThemeMode.light
//               ? SystemUiOverlayStyle.dark
//               : SystemUiOverlayStyle.dark, // Default for system
//     );
//   }

//   // Get theme-specific asset path
//   String getThemedAsset(BuildContext context, {
//     required String lightAsset,
//     required String darkAsset,
//   }) {
//     return isDarkMode(context) ? darkAsset : lightAsset;
//   }

//   // Toggle between light and dark (useful for quick toggle)
//   Future<void> toggleTheme() async {
//     switch (_themeMode) {
//       case AppThemeMode.light:
//         await setThemeMode(AppThemeMode.dark);
//         break;
//       case AppThemeMode.dark:
//         await setThemeMode(AppThemeMode.light);
//         break;
//       case AppThemeMode.system:
//         await setThemeMode(AppThemeMode.light);
//         break;
//     }
//   }
// }

// // App Theme Configuration
// class AppTheme {
//   // Color Schemes
//   static const ColorScheme lightColorScheme = ColorScheme(
//     brightness: Brightness.light,
//     primary: Color(0xFF4A90E2),
//     onPrimary: Colors.white,
//     secondary: Color(0xFF50C878),
//     onSecondary: Colors.white,
//     error: Color(0xFFE74C3C),
//     onError: Colors.white,
//     background: Color(0xFFF8F9FA),
//     onBackground: Color(0xFF2C3E50),
//     surface: Colors.white,
//     onSurface: Color(0xFF2C3E50),
//     surfaceVariant: Color(0xFFF1F3F4),
//     onSurfaceVariant: Color(0xFF5F6368),
//   );

//   static const ColorScheme darkColorScheme = ColorScheme(
//     brightness: Brightness.dark,
//     primary: Color(0xFF5BA0F2),
//     onPrimary: Color(0xFF1A1A1A),
//     secondary: Color(0xFF60D888),
//     onSecondary: Color(0xFF1A1A1A),
//     error: Color(0xFFFF6B6B),
//     onError: Color(0xFF1A1A1A),
//     background: Color(0xFF121212),
//     onBackground: Color(0xFFE1E3E6),
//     surface: Color(0xFF1E1E1E),
//     onSurface: Color(0xFFE1E3E6),
//     surfaceVariant: Color(0xFF2D2D2D),
//     onSurfaceVariant: Color(0xFFBDC1C6),
//   );

//   // Light Theme
//   static ThemeData get lightTheme {
//     return ThemeData(
//       useMaterial3: true,
//       colorScheme: lightColorScheme,
//       fontFamily: 'SF Pro Display',
      
//       // AppBar Theme
//       appBarTheme: const AppBarTheme(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         iconTheme: IconThemeData(color: Color(0xFF2C3E50)),
//         titleTextStyle: TextStyle(
//           color: Color(0xFF2C3E50),
//           fontSize: 18,
//           fontWeight: FontWeight.w600,
//         ),
//         systemOverlayStyle: SystemUiOverlayStyle.dark,
//       ),

//       // Elevated Button Theme
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: lightColorScheme.primary,
//           foregroundColor: lightColorScheme.onPrimary,
//           elevation: 0,
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//       ),

//       // Card Theme
//       cardTheme: CardTheme(
//         color: lightColorScheme.surface,
//         elevation: 2,
//         shadowColor: Colors.black.withOpacity(0.1),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//       ),

//       // Input Decoration Theme
//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: lightColorScheme.surfaceVariant,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: lightColorScheme.primary, width: 2),
//         ),
//       ),
//     );
//   }

//   // Dark Theme
//   static ThemeData get darkTheme {
//     return ThemeData(
//       useMaterial3: true,
//       colorScheme: darkColorScheme,
//       fontFamily: 'SF Pro Display',
      
//       // AppBar Theme
//       appBarTheme: const AppBarTheme(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         iconTheme: IconThemeData(color: Color(0xFFE1E3E6)),
//         titleTextStyle: TextStyle(
//           color: Color(0xFFE1E3E6),
//           fontSize: 18,
//           fontWeight: FontWeight.w600,
//         ),
//         systemOverlayStyle: SystemUiOverlayStyle.light,
//       ),

//       // Elevated Button Theme
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: darkColorScheme.primary,
//           foregroundColor: darkColorScheme.onPrimary,
//           elevation: 0,
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//       ),

//       // Card Theme
//       cardTheme: CardTheme(
//         color: darkColorScheme.surface,
//         elevation: 2,
//         shadowColor: Colors.black.withOpacity(0.3),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//       ),

//       // Input Decoration Theme
//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: darkColorScheme.surfaceVariant,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: darkColorScheme.primary, width: 2),
//         ),
//       ),
//     );
//   }
// }

// // Themed Image Widget
// class ThemedImage extends StatelessWidget {
//   final String lightAsset;
//   final String darkAsset;
//   final double? width;
//   final double? height;
//   final BoxFit fit;
//   final Color? color;
//   final BlendMode? colorBlendMode;

//   const ThemedImage({
//     Key? key,
//     required this.lightAsset,
//     required this.darkAsset,
//     this.width,
//     this.height,
//     this.fit = BoxFit.contain,
//     this.color,
//     this.colorBlendMode,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = context.watch<ThemeProvider>();
//     final asset = themeProvider.getThemedAsset(
//       context,
//       lightAsset: lightAsset,
//       darkAsset: darkAsset,
//     );

//     return Image.asset(
//       asset,
//       width: width,
//       height: height,
//       fit: fit,
//       color: color,
//       colorBlendMode: colorBlendMode,
//       errorBuilder: (context, error, stackTrace) {
//         return Container(
//           width: width,
//           height: height,
//           decoration: BoxDecoration(
//             color: Theme.of(context).colorScheme.surfaceVariant,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Icon(
//             Icons.image_not_supported,
//             color: Theme.of(context).colorScheme.onSurfaceVariant,
//             size: (width ?? height ?? 24) * 0.4,
//           ),
//         );
//       },
//     );
//   }
// }

// // Theme Toggle Button Widget
// class ThemeToggleButton extends StatelessWidget {
//   final bool showLabel;
//   final IconData? lightIcon;
//   final IconData? darkIcon;
//   final IconData? systemIcon;

//   const ThemeToggleButton({
//     Key? key,
//     this.showLabel = true,
//     this.lightIcon = Icons.light_mode,
//     this.darkIcon = Icons.dark_mode,
//     this.systemIcon = Icons.settings_brightness,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = context.watch<ThemeProvider>();

//     return PopupMenuButton<AppThemeMode>(
//       icon: Icon(_getCurrentIcon(themeProvider.themeMode)),
//       tooltip: 'Change Theme',
//       onSelected: (AppThemeMode mode) {
//         themeProvider.setThemeMode(mode);
//       },
//       itemBuilder: (BuildContext context) => [
//         PopupMenuItem<AppThemeMode>(
//           value: AppThemeMode.light,
//           child: Row(
//             children: [
//               Icon(lightIcon, size: 20),
//               const SizedBox(width: 12),
//               const Text('Light'),
//               if (themeProvider.themeMode == AppThemeMode.light)
//                 const Spacer(),
//               if (themeProvider.themeMode == AppThemeMode.light)
//                 Icon(Icons.check, size: 20, color: Theme.of(context).colorScheme.primary),
//             ],
//           ),
//         ),
//         PopupMenuItem<AppThemeMode>(
//           value: AppThemeMode.dark,
//           child: Row(
//             children: [
//               Icon(darkIcon, size: 20),
//               const SizedBox(width: 12),
//               const Text('Dark'),
//               if (themeProvider.themeMode == AppThemeMode.dark)
//                 const Spacer(),
//               if (themeProvider.themeMode == AppThemeMode.dark)
//                 Icon(Icons.check, size: 20, color: Theme.of(context).colorScheme.primary),
//             ],
//           ),
//         ),
//         PopupMenuItem<AppThemeMode>(
//           value: AppThemeMode.system,
//           child: Row(
//             children: [
//               Icon(systemIcon, size: 20),
//               const SizedBox(width: 12),
//               const Text('System'),
//               if (themeProvider.themeMode == AppThemeMode.system)
//                 const Spacer(),
//               if (themeProvider.themeMode == AppThemeMode.system)
//                 Icon(Icons.check, size: 20, color: Theme.of(context).colorScheme.primary),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   IconData _getCurrentIcon(AppThemeMode mode) {
//     switch (mode) {
//       case AppThemeMode.light:
//         return lightIcon!;
//       case AppThemeMode.dark:
//         return darkIcon!;
//       case AppThemeMode.system:
//         return systemIcon!;
//     }
//   }
// }

// // Theme Settings Screen
// class ThemeSettingsScreen extends StatelessWidget {
//   const ThemeSettingsScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = context.watch<ThemeProvider>();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Theme Settings'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Appearance',
//               style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
            
//             Card(
//               child: Column(
//                 children: [
//                   _buildThemeOption(
//                     context,
//                     themeProvider,
//                     AppThemeMode.light,
//                     'Light',
//                     'Always use light theme',
//                     Icons.light_mode,
//                   ),
//                   const Divider(height: 1),
//                   _buildThemeOption(
//                     context,
//                     themeProvider,
//                     AppThemeMode.dark,
//                     'Dark',
//                     'Always use dark theme',
//                     Icons.dark_mode,
//                   ),
//                   const Divider(height: 1),
//                   _buildThemeOption(
//                     context,
//                     themeProvider,
//                     AppThemeMode.system,
//                     'System',
//                     'Follow system setting',
//                     Icons.settings_brightness,
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 32),

//             // Theme Preview
//             Text(
//               'Preview',
//               style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),

//             Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         ThemedImage(
//                           lightAsset: 'assets/images/logo_light.png',
//                           darkAsset: 'assets/images/logo_dark.png',
//                           width: 40,
//                           height: 40,
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'App Preview',
//                                 style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               Text(
//                                 'This is how your app will look',
//                                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                                   color: Theme.of(context).colorScheme.onSurfaceVariant,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: () {},
//                         child: const Text('Sample Button'),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildThemeOption(
//     BuildContext context,
//     ThemeProvider themeProvider,
//     AppThemeMode mode,
//     String title,
//     String subtitle,
//     IconData icon,
//   ) {
//     final isSelected = themeProvider.themeMode == mode;

//     return ListTile(
//       leading: Icon(icon),
//       title: Text(title),
//       subtitle: Text(subtitle),
//       trailing: isSelected
//           ? Icon(
//               Icons.check_circle,
//               color: Theme.of(context).colorScheme.primary,
//             )
//           : null,
//       onTap: () => themeProvider.setThemeMode(mode),
//     );
//   }
// }

// // App with Theme Provider
// class ThemedApp extends StatelessWidget {
//   const ThemedApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ThemeProvider>(
//       builder: (context, themeProvider, child) {
//         if (!themeProvider.isInitialized) {
//           return const MaterialApp(
//             home: Scaffold(
//               body: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             ),
//           );
//         }

//         return MaterialApp(
//           title: 'SIANA App',
//           theme: AppTheme.lightTheme,
//           darkTheme: AppTheme.darkTheme,
//           themeMode: themeProvider.materialThemeMode,
//           home: const HomeScreen(),
//         );
//       },
//     );
//   }
// }

// // Example Home Screen
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('SIANA'),
//         actions: [
//           const ThemeToggleButton(),
//           IconButton(
//             icon: const Icon(Icons.settings),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const ThemeSettingsScreen(),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   children: [
//                     ThemedImage(
//                       lightAsset: 'assets/images/logo_light.png',
//                       darkAsset: 'assets/images/logo_dark.png',
//                       width: 60,
//                       height: 60,
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Welcome to SIANA',
//                             style: Theme.of(context).textTheme.headlineSmall,
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             'Your errand platform with dynamic theming',
//                             style: Theme.of(context).textTheme.bodyMedium,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {},
//                 child: const Text('Get Started'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }