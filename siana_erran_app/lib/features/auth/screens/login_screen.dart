import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:siana_erran_app/bottom_nav_bar.dart';
import 'package:siana_erran_app/core/utils/assets_utiles.dart';
import 'package:siana_erran_app/features/auth/screens/signup_screen.dart';
import 'package:siana_erran_app/features/auth/widgets/customTextfield_widgets.dart';
import 'package:siana_erran_app/features/auth/widgets/roleSelection_Card_widget.dart';
import 'package:siana_erran_app/features/auth/widgets/social_logins_btn.dart';

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

  String selectedRole = 'Client';
  bool isIos = Platform.isIOS;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
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
                // Welcome Back Text
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 32),

                // Role Selection Cards
                Row(
                  children: [
                    Expanded(
                      child: RoleSelectionCard(
                        selectedColor: Colors.transparent,
                        selectedBorderColor: Colors.grey.shade200,
                        iconSelectedColor: Colors.white,
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
                        selectedColor: Colors.transparent,
                        selectedBorderColor: Colors.grey.shade200,
                        iconSelectedColor: Colors.white,
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
                  hintText: 'Enter your email',
                  hintColor: Colors.grey,
                  fillColor: Color(0xFF393d47),
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
                  hintText: 'Enter your password',
                  hintColor: Colors.grey,
                  fillColor: Color(0xFF393d47),
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

                // Forgot Password Link
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _handleForgotPassword,
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey.shade400,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade700,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                const SizedBox(height: 24),

                // OR Divider
                Row(
                  children: [
                    Expanded(
                      child: Divider(color: Colors.grey.shade700, thickness: 1),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'OR',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(color: Colors.grey.shade700, thickness: 1),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Social Login Buttons - Stacked Vertically
                Column(
                  children: [
                    const SizedBox(height: 24),
                    // Google Button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: SocialLoginButton(
                        text: 'Continue with Google',
                        fontSize: 18,
                        icon: PhosphorIcons.googleLogo(),
                        iconSize: 24,
                        backgroundColor: Colors.transparent,
                        textColor: Colors.white,
                        onPressed: () => _handleSocialLogin('Google'),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Facebook Button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: SocialLoginButton(
                        text: 'Continue with Facebook',
                        fontSize: 18,
                        icon: PhosphorIcons.facebookLogo(),
                        iconSize: 24,
                        backgroundColor: Colors.transparent,
                        textColor: Colors.white,
                        onPressed: () => _handleSocialLogin('Facebook'),
                      ),
                    ),

                    // Apple Button (iOS only)
                    if (isIos) ...[
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: SocialLoginButton(
                          text: 'Continue with Apple',
                          fontSize: 18,
                          icon: PhosphorIcons.appleLogo(),
                          iconSize: 24,
                          backgroundColor: Colors.transparent,
                          textColor: Colors.white,
                          onPressed: () => _handleSocialLogin('Apple'),
                        ),
                      ),
                    ],
                  ],
                ),

                const SizedBox(height: 32),

                // Don't have account text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    GestureDetector(
                      onTap: _handleSignUp,
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blueGrey.shade400,
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
                          text: 'By continuing, you agree to our ',
                        ),
                        TextSpan(
                          text: 'Terms of Service',
                          style: TextStyle(
                            color: Colors.blueGrey.shade400,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                            color: Colors.blueGrey.shade400,
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

  void _handleLogin() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => BottomNavBar(initialIndex: 0)),
      (route) => false,
    );
    if (_formKey.currentState!.validate()) {
      // TODO: Implement login logic
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Logging in as $selectedRole...'),
      //     backgroundColor: Colors.green,
      //   ),
      // );
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

  // void _handlePhoneLogin() {
  //   // TODO: Implement phone login
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(
  //       content: Text('Phone login pressed'),
  //       backgroundColor: Colors.orange,
  //     ),
  //   );
  // }

  void _handleForgotPassword() {
    // TODO: Navigate to forgot password screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Forgot password pressed'),
        backgroundColor: Colors.purple,
      ),
    );
  }

  void _handleSignUp() {
    // TODO: Navigate to sign up screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }
}
