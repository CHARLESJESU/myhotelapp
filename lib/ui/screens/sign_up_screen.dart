import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../widgets/primary_button.dart';

class SignUpScreen extends StatefulWidget {
  final bool isDark;
  const SignUpScreen({super.key, this.isDark = true});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  String? _confirmError;

  void _onSignUp() {
    setState(() {
      _confirmError = null;
    });

    if (_passwordController.text != _confirmController.text) {
      setState(() {
        _confirmError = 'Passwords do not match.';
      });
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Account created (UI-only)')));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
    final buttonBg = isDark ? AppColors.buttonBg : AppColors.lightButtonBg;
    final buttonText = isDark
        ? AppColors.buttonText
        : AppColors.lightButtonText;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.arrow_back, color: primaryText),
                  ),
                  const Expanded(child: SizedBox()),
                  Text(
                    'Create Your Account',
                    style: TextStyle(
                      color: primaryText,
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  const SizedBox(width: 48),
                ],
              ),

              const SizedBox(height: 20),

              Center(
                child: Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: cardBg,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(Icons.fastfood, size: 36, color: buttonBg),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Center(
                child: Text(
                  'Sign up to start ordering your favorite food.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: secondaryText, fontSize: 14),
                ),
              ),

              const SizedBox(height: 20),

              // Full Name
              Text(
                'Full Name',
                style: TextStyle(
                  color: primaryText,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                style: TextStyle(color: primaryText),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: inputBg,
                  hintText: 'Enter your full name',
                  hintStyle: TextStyle(color: secondaryText),
                  prefixIcon: Icon(Icons.person, color: secondaryText),
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

              const SizedBox(height: 12),

              // Contact Number
              Text(
                'Contact Number',
                style: TextStyle(
                  color: primaryText,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _phoneController,
                style: TextStyle(color: primaryText),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: inputBg,
                  hintText: 'Enter your contact number',
                  hintStyle: TextStyle(color: secondaryText),
                  prefixIcon: Icon(Icons.phone, color: secondaryText),
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

              const SizedBox(height: 12),

              // Address
              Text(
                'Address',
                style: TextStyle(
                  color: primaryText,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _addressController,
                style: TextStyle(color: primaryText),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: inputBg,
                  hintText: 'Enter your address',
                  hintStyle: TextStyle(color: secondaryText),
                  prefixIcon: Icon(Icons.location_on, color: secondaryText),
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

              const SizedBox(height: 12),

              // Username
              Text(
                'Username',
                style: TextStyle(
                  color: primaryText,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _usernameController,
                style: TextStyle(color: primaryText),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: inputBg,
                  hintText: 'Enter your username',
                  hintStyle: TextStyle(color: secondaryText),
                  prefixIcon: Icon(Icons.alternate_email, color: secondaryText),
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

              const SizedBox(height: 12),

              // Create Password
              Text(
                'Create Password',
                style: TextStyle(
                  color: primaryText,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                style: TextStyle(color: primaryText),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: inputBg,
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(color: secondaryText),
                  prefixIcon: Icon(Icons.lock, color: secondaryText),
                  suffixIcon: IconButton(
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: secondaryText,
                    ),
                  ),
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

              const SizedBox(height: 8),

              // Password strength bar (UI only)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: isDark
                          ? Colors.grey.shade800
                          : Colors.grey.shade300,
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: 0.5,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.buttonBg,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Medium',
                      style: TextStyle(color: secondaryText),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Confirm Password
              Text(
                'Confirm Password',
                style: TextStyle(
                  color: primaryText,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _confirmController,
                obscureText: _obscureConfirm,
                style: TextStyle(color: primaryText),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: inputBg,
                  hintText: 'Confirm your password',
                  hintStyle: TextStyle(color: secondaryText),
                  prefixIcon: Icon(Icons.lock, color: secondaryText),
                  suffixIcon: IconButton(
                    onPressed: () =>
                        setState(() => _obscureConfirm = !_obscureConfirm),
                    icon: Icon(
                      _obscureConfirm ? Icons.visibility_off : Icons.visibility,
                      color: secondaryText,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: _confirmError == null ? borderDefault : Colors.red,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: _confirmError == null
                          ? AppColors.borderActive
                          : Colors.red,
                    ),
                  ),
                ),
              ),

              if (_confirmError != null) ...[
                const SizedBox(height: 6),
                Text(_confirmError!, style: const TextStyle(color: Colors.red)),
              ],

              const SizedBox(height: 20),

              // Sign Up button
              PrimaryButton(
                label: 'Sign Up',
                onPressed: _onSignUp,
                backgroundColor: buttonBg,
                textColor: buttonText,
                shadowColor: AppColors.buttonShadow,
              ),

              const SizedBox(height: 16),

              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(color: secondaryText),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: buttonBg,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
