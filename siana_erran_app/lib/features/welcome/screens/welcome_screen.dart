import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siana_erran_app/core/utils/assets_utiles.dart';
import 'package:siana_erran_app/features/auth/screens/auth_screen.dart';
import 'package:siana_erran_app/features/welcome/widgets/welcome_txt.dart';
import 'package:siana_erran_app/providers/theme_provider.dart';
import 'package:siana_erran_app/widgets/custom_btn.dart';
import 'package:siana_erran_app/widgets/custom_logo.dart';

class WelcomeScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final String? logoAsset;

  const WelcomeScreen({
    super.key,
    this.title = 'Welcome to SIANA',
    this.subtitle =
        'The Errand Platform. Discover how we connect you with local agents for all your errands.',
    this.buttonText = 'Get Started',
    this.logoAsset = '${iconPath}siana_ac_b.png',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    var themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    final asset = themeProvider.getThemedAsset(
      context,
      lightAsset: "${iconPath}siana_ac_b.png",
      darkAsset: "${iconPath}siana_ic.png",
    );

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Logo tinted by onSurface color
              CustomLogo(logoAsset: asset, size: 100),

              const SizedBox(height: 50),

              // Illustration – you could also swap to a dark‑mode variant via ThemeProvider
              Expanded(
                child: Image.asset(
                  '${imagePath}onboarding_image_one.png',
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 300,
                ),
              ),

              const SizedBox(height: 40),

              WelcomeTextSection(
                title: title,
                subtitle: subtitle,
                titleStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
                subtitleStyle: TextStyle(
                  fontSize: 18,
                  height: 1.5,
                  color: textColor,
                ),
              ),

              const SizedBox(height: 40),

              // Button always black bg & white text
              CustomButton(
                text: buttonText,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AuthScreen()),
                  );
                },
                backgroundColor: isDark ? Colors.grey.shade800 : Colors.black,
                textColor: Colors.white,
                height: 48,
                borderRadius: 12,
                textStyle: theme.textTheme.labelLarge!.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
