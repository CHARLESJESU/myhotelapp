import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../widgets/primary_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final bool isDark;
  const ForgotPasswordScreen({super.key, this.isDark = true});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  void _onSend() {
    // UI only: show a SnackBar to demonstrate action
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Reset link sent (UI-only)')));
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark
        ? AppColors.screenBackground
        : AppColors.lightScreenBackground;
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
    final buttonBg = isDark ? AppColors.buttonBg : AppColors.lightButtonBg;
    final buttonText = isDark
        ? AppColors.buttonText
        : AppColors.lightButtonText;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // top bar with back arrow and centered title
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.arrow_back, color: primaryText),
                  ),
                  const Expanded(child: SizedBox()),
                  Text(
                    'Forgot Password',
                    style: TextStyle(
                      color: primaryText,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  // placeholder to keep title centered
                  const SizedBox(width: 48),
                ],
              ),

              const SizedBox(height: 20),

              // lock icon
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.cardDark : AppColors.lightCard,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(Icons.lock_open, size: 48, color: buttonBg),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: Text(
                  'Enter your registered email or username below to receive a password reset link.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: secondaryText, fontSize: 14),
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'Email or Username',
                style: TextStyle(
                  color: primaryText,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: _emailController,
                style: TextStyle(color: primaryText),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: inputBg,
                  hintText: 'Enter your email or username',
                  hintStyle: TextStyle(color: secondaryText),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: borderDefault),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.borderActive),
                  ),
                ),
              ),

              const Spacer(),

              // bottom button
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: PrimaryButton(
                  label: 'Send Reset Link',
                  onPressed: _onSend,
                  backgroundColor: buttonBg,
                  textColor: buttonText,
                  shadowColor: AppColors.buttonShadow,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
