import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../widgets/primary_button.dart';

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

    Get.snackbar('Success', 'Account created (UI-only)');
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
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.screenBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.arrow_back, color: colors.primaryText),
                  ),
                  const Expanded(child: SizedBox()),
                  Text(
                    'Create Your Account',
                    style: TextStyle(
                      color: colors.primaryText,
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
                    color: colors.card,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(Icons.fastfood, size: 36, color: colors.buttonBg),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Center(
                child: Text(
                  'Sign up to start ordering your favorite food.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: colors.secondaryText, fontSize: 14),
                ),
              ),

              const SizedBox(height: 20),

              // Full Name
              Text(
                'Full Name',
                style: TextStyle(
                  color: colors.primaryText,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                style: TextStyle(color: colors.primaryText),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: colors.inputBackground,
                  hintText: 'Enter your full name',
                  hintStyle: TextStyle(color: colors.secondaryText),
                  prefixIcon: Icon(Icons.person, color: colors.secondaryText),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colors.borderDefault),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colors.borderActive),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Contact Number
              Text(
                'Contact Number',
                style: TextStyle(
                  color: colors.primaryText,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _phoneController,
                style: TextStyle(color: colors.primaryText),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: colors.inputBackground,
                  hintText: 'Enter your contact number',
                  hintStyle: TextStyle(color: colors.secondaryText),
                  prefixIcon: Icon(Icons.phone, color: colors.secondaryText),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colors.borderDefault),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colors.borderActive),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Address
              Text(
                'Address',
                style: TextStyle(
                  color: colors.primaryText,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _addressController,
                style: TextStyle(color: colors.primaryText),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: colors.inputBackground,
                  hintText: 'Enter your address',
                  hintStyle: TextStyle(color: colors.secondaryText),
                  prefixIcon: Icon(Icons.location_on, color: colors.secondaryText),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colors.borderDefault),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colors.borderActive),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Username
              Text(
                'Username',
                style: TextStyle(
                  color: colors.primaryText,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _usernameController,
                style: TextStyle(color: colors.primaryText),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: colors.inputBackground,
                  hintText: 'Enter your username',
                  hintStyle: TextStyle(color: colors.secondaryText),
                  prefixIcon: Icon(Icons.alternate_email, color: colors.secondaryText),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colors.borderDefault),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colors.borderActive),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Create Password
              Text(
                'Create Password',
                style: TextStyle(
                  color: colors.primaryText,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                style: TextStyle(color: colors.primaryText),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: colors.inputBackground,
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(color: colors.secondaryText),
                  prefixIcon: Icon(Icons.lock, color: colors.secondaryText),
                  suffixIcon: IconButton(
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: colors.secondaryText,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colors.borderDefault),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colors.borderActive),
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
                      color: context.isCurrentThemeDark
                          ? Colors.grey.shade800
                          : Colors.grey.shade300,
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: 0.5,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: colors.buttonBg,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Medium',
                      style: TextStyle(color: colors.secondaryText),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Confirm Password
              Text(
                'Confirm Password',
                style: TextStyle(
                  color: colors.primaryText,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _confirmController,
                obscureText: _obscureConfirm,
                style: TextStyle(color: colors.primaryText),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: colors.inputBackground,
                  hintText: 'Confirm your password',
                  hintStyle: TextStyle(color: colors.secondaryText),
                  prefixIcon: Icon(Icons.lock, color: colors.secondaryText),
                  suffixIcon: IconButton(
                    onPressed: () =>
                        setState(() => _obscureConfirm = !_obscureConfirm),
                    icon: Icon(
                      _obscureConfirm ? Icons.visibility_off : Icons.visibility,
                      color: colors.secondaryText,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: _confirmError == null ? colors.borderDefault : Colors.red,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: _confirmError == null
                          ? colors.borderActive
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
                backgroundColor: colors.buttonBg,
                textColor: colors.buttonText,
                shadowColor: colors.buttonShadow,
              ),

              const SizedBox(height: 16),

              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(color: colors.secondaryText),
                    ),
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: colors.buttonBg,
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
