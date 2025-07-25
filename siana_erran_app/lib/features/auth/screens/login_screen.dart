import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:siana_erran_app/core/utils/assets_utiles.dart';
import 'package:siana_erran_app/features/auth/widgets/customTextfield_widgets.dart';
import 'package:siana_erran_app/features/auth/widgets/roleSelection_Card_widget.dart';
import 'package:siana_erran_app/features/auth/widgets/social_logins_btn.dart';
import 'package:siana_erran_app/widgets/custom_logo.dart';

// Main SignUp Screen
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String selectedRole = 'Client';
  bool isIos = Platform.isIOS;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Login',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Join SIANA Text
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 8),

                // Subtitle
                const Text(
                  'Choose your role to get started securely.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),

                const SizedBox(height: 32),

                // Role Selection Cards
                Row(
                  children: [
                    Expanded(
                      child: RoleSelectionCard(
                        title: 'Client',
                        subtitle: 'Request errands\nfor swift delivery',
                        icon: "${iconPath}user.png",
                        isSelected: selectedRole == 'Client',
                        onTap: () => setState(() => selectedRole = 'Client'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: RoleSelectionCard(
                        title: 'Errand Bird',
                        subtitle: 'Deliver errands\nand earn on the go',
                        icon: "${iconPath}errand_box.png",
                        isSelected: selectedRole == 'Errand Bird',
                        onTap: () =>
                            setState(() => selectedRole = 'Errand Bird'),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Email Field
                CustomTextField(
                  label: 'Email Address',
                  hintText: 'you@example.com',
                  prefixIcon: Icons.email_outlined,
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }
                    final trimmedValue = value.trim();
                    final regex = RegExp(
                      r'^[a-zA-Z0-9._%+-]+@(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$',
                    );
                    if (!regex.hasMatch(trimmedValue)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Password Field
                CustomTextField(
                  label: 'Password',
                  hintText: '••••••••',
                  isPassword: true,
                  prefixIcon: Icons.lock_outline,
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Confirm Password Field
                CustomTextField(
                  label: 'Confirm Password',
                  hintText: '••••••••',
                  isPassword: true,
                  prefixIcon: Icons.lock_outline,
                  controller: _confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 32),

                // Create Account Button
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: _handleCreateAccount,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Social Login Buttons
                Wrap(
                  children: [
                    Expanded(
                      child: SocialLoginButton(
                        text: 'Google',
                        icon: PhosphorIcons.googleLogo(),
                        backgroundColor: Colors.white,
                        textColor: Colors.black87,
                        width: isIos ? double.infinity : 130,
                        onPressed: () => _handleSocialLogin('Google'),
                      ),
                    ),
                    SizedBox(width: isIos ? 0 : 8, height: isIos ? 0 : 10),
                    Expanded(
                      child: SocialLoginButton(
                        text: 'Facebook',
                        icon: PhosphorIconsFill.facebookLogo,
                        backgroundColor: const Color(0xFF1877F2),
                        textColor: Colors.white,
                        onPressed: () => _handleSocialLogin('Facebook'),
                      ),
                    ),
                    SizedBox(width: isIos ? 0 : 8, height: isIos ? 0 : 10),

                    Visibility(
                      visible: isIos,
                      child: Expanded(
                        child: SocialLoginButton(
                          text: 'Apple',
                          icon: PhosphorIcons.appleLogo(),
                          backgroundColor: Colors.black87,
                          textColor: Colors.white,
                          onPressed: () => _handleSocialLogin('Apple'),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Already have account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Text(
                        'Log in',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blueGrey.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Terms and Privacy
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        height: 1.5,
                      ),
                      children: [
                        const TextSpan(
                          text: 'By signing up, you agree to our ',
                        ),
                        TextSpan(
                          text: 'Terms & Conditions',
                          style: TextStyle(
                            color: Colors.blueGrey.shade700,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                            color: Colors.blueGrey.shade700,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleCreateAccount() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement account creation logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Creating $selectedRole account...'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _handleSocialLogin(String provider) {
    // TODO: Implement social login
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$provider login pressed'),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
