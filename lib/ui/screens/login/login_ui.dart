import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../services/theme_service.dart';
import '../forgot_password/forgot_password_ui.dart';
import '../sign_up/sign_up_ui.dart';
import '../home/home_ui.dart';
import '../admin_order_management/admin_order_management_ui.dart';
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
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const AdminOrderManagementScreen()),
      );
      return;
    }

    // navigate to the home page (UI-only)
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // pick colors based on theme state
    final bg = isDark
        ? AppColors.screenBackground
        : AppColors.lightScreenBackground;
    final cardBg = isDark ? AppColors.cardDark : AppColors.lightCard;
    final primaryText = isDark
        ? AppColors.primaryText
        : AppColors.lightPrimaryText;
    final secondaryText = isDark
        ? AppColors.secondaryText
        : AppColors.lightSecondaryText;
    final inputBg = isDark
        ? AppColors.inputBackground
        : AppColors.lightInputBackground;
    final borderDefault = isDark
        ? AppColors.borderDefault
        : AppColors.lightBorderDefault;
    final borderActive = AppColors.borderActive; // same for both modes
    final buttonBg = isDark ? AppColors.buttonBg : AppColors.lightButtonBg;
    final buttonText = isDark
        ? AppColors.buttonText
        : AppColors.lightButtonText;

    return Scaffold(
      backgroundColor: bg,
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
                            cardBg: cardBg,
                            iconColor: isDark
                                ? AppColors.buttonBg
                                : AppColors.successIcon,
                          ),

                          const SizedBox(height: 28),

                          // Welcome title
                          Center(
                            child: Text(
                              'Welcome Back',
                              style: TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.w800,
                                color: primaryText,
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
                                color: secondaryText,
                              ),
                            ),
                          ),

                          const SizedBox(height: 28),

                          // Username label
                          Text(
                            'Username',
                            style: TextStyle(
                              color: primaryText,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // username field
                          TextField(
                            controller: _usernameController,
                            style: TextStyle(color: primaryText),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: inputBg,
                              hintText: 'Enter your username',
                              hintStyle: TextStyle(color: secondaryText),
                              prefixIcon: Icon(
                                Icons.person,
                                color: secondaryText,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: borderDefault),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: borderActive),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          Text(
                            'Password',
                            style: TextStyle(
                              color: primaryText,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(height: 8),

                          // password field
                          TextField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            style: TextStyle(color: primaryText),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: inputBg,
                              hintText: 'Enter your password',
                              hintStyle: TextStyle(color: secondaryText),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: secondaryText,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () => setState(
                                  () => _obscurePassword = !_obscurePassword,
                                ),
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: secondaryText,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: borderDefault),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: borderActive),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Login button
                          PrimaryButton(
                            label: 'Login',
                            onPressed: _onLogin,
                            backgroundColor: buttonBg,
                            textColor: buttonText,
                            shadowColor: AppColors.buttonShadow,
                          ),

                          const SizedBox(height: 18),

                          // Forgot password
                          Center(
                            child: TextButton(
                              onPressed: () {
                                // navigate to forgot password page
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => ForgotPasswordScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: buttonBg,
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
                                  style: TextStyle(color: secondaryText),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => SignUpScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Sign in',
                                    style: TextStyle(
                                      color: buttonBg,
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
                isDark: isDark,
                cardBg: isDark
                    ? AppColors.cardDark
                    : AppColors.lightInputBackground,
                borderColor: isDark
                    ? AppColors.borderDefault
                    : AppColors.lightBorderDefault,
                iconColor: isDark
                    ? AppColors.buttonBg
                    : AppColors.lightPrimaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
