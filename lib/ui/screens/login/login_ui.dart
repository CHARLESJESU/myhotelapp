import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../router/routing.dart';
import '../../widgets/primary_button.dart';
import 'widget/login_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _onLogin() {
    final name = _usernameController.text.trim();
    if (name.toLowerCase() == 'admin') {
      Get.offNamed(AppRoutes.adminOrderManagement);
      return;
    }

    // navigate to the main bottom navigation screen (UI-only)
    Get.offNamed(AppRoutes.main);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.screenBackground,
      body: SafeArea(
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final bottomInset = MediaQuery.of(context).viewInsets.bottom;
                return SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + bottomInset),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 24,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 16),

                          // centered circular icon
                          LoginIconCircle(
                            cardBg: colors.card,
                            iconColor: colors.buttonBg,
                          ),

                          const SizedBox(height: 28),

                          // Welcome title
                          Center(
                            child: Text(
                              'Welcome Back',
                              style: TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.w800,
                                color: colors.primaryText,
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          Center(
                            child: Text(
                              'Log in to continue your culinary journey.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: colors.secondaryText,
                              ),
                            ),
                          ),

                          const SizedBox(height: 28),

                          // Username label
                          Text(
                            'Username',
                            style: TextStyle(
                              color: colors.primaryText,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // username field
                          TextField(
                            controller: _usernameController,
                            style: TextStyle(color: colors.primaryText),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: colors.inputBackground,
                              hintText: 'Enter your username',
                              hintStyle: TextStyle(color: colors.secondaryText),
                              prefixIcon: Icon(
                                Icons.person,
                                color: colors.secondaryText,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: colors.borderDefault),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: colors.borderActive),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          Text(
                            'Password',
                            style: TextStyle(
                              color: colors.primaryText,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(height: 8),

                          // password field
                          TextField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            style: TextStyle(color: colors.primaryText),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: colors.inputBackground,
                              hintText: 'Enter your password',
                              hintStyle: TextStyle(color: colors.secondaryText),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: colors.secondaryText,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () => setState(
                                  () => _obscurePassword = !_obscurePassword,
                                ),
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: colors.secondaryText,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: colors.borderDefault),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: colors.borderActive),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Login button
                          PrimaryButton(
                            label: 'Login',
                            onPressed: _onLogin,
                            backgroundColor: colors.buttonBg,
                            textColor: colors.buttonText,
                            shadowColor: colors.buttonShadow,
                          ),

                          const SizedBox(height: 18),

                          // Forgot password
                          Center(
                            child: TextButton(
                              onPressed: () => Get.toNamed(AppRoutes.forgotPassword),
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: colors.buttonBg,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),
                          // Prompt to sign in or register
                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Don't have an account? ",
                                  style: TextStyle(color: colors.secondaryText),
                                ),
                                TextButton(
                                  onPressed: () => Get.toNamed(AppRoutes.signUp),
                                  child: Text(
                                    'Sign in',
                                    style: TextStyle(
                                      color: colors.buttonBg,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            // top-right theme toggle button
            Positioned(
              top: 12,
              right: 12,
              child: ThemeToggleButton(
                isDark: context.isCurrentThemeDark,
                cardBg: colors.inputBackground,
                borderColor: colors.borderDefault,
                iconColor: colors.buttonBg,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
