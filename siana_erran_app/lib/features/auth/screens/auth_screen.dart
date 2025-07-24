import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:siana_erran_app/core/utils/assets_utiles.dart';
import 'package:siana_erran_app/features/auth/screens/signup_screen.dart';
import 'package:siana_erran_app/providers/theme_provider.dart';
import 'package:siana_erran_app/widgets/custom_btn.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final colorScheme = theme.colorScheme;
    // final isDark = theme.brightness == Brightness.dark;
    // final textColor = isDark ? Colors.white : Colors.black;
    // var themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E), // Dark background
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1E),
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xFF1C1C1E),
          statusBarIconBrightness: Brightness.light,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const Spacer(flex: 1),

              // Siana Logo
              Image.asset("${imagePath}txt_logo.png", width: 201, height: 51),

              const Spacer(flex: 1),

              // Join the family text
              const Text(
                'Join the family',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 40),

              // Sign up button
              CustomButtonTxt(
                text: "Sign Up",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                borderRadius: 25,
                bgColor: const Color(0xFF8E8E93),
                textStyle: theme.textTheme.labelLarge!.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              // Log in button
              CustomButtonTxt(
                text: "Log in",
                onPressed: () {},
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                borderRadius: 25,
                bgColor: Colors.white,
                textStyle: theme.textTheme.labelLarge!.copyWith(
                  fontSize: 16,
                  color: const Color(0xFF1C1C1E),
                ),
              ),

              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSignUp(BuildContext context) {
    // TODO: Navigate to sign up screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Navigate to Sign Up screen'),
        backgroundColor: Color(0xFF8E8E93),
      ),
    );
  }

  void _handleLogIn(BuildContext context) {
    // TODO: Navigate to log in screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Navigate to Log In screen'),
        backgroundColor: Color(0xFF8E8E93),
      ),
    );
  }
}
