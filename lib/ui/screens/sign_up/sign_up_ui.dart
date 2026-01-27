import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/responsive_helper.dart';
import '../../../language/language_controller.dart';
import '../../widgets/primary_button.dart';
import '../../api/api_calls.dart';
import '../../widgets/app_toast.dart';

class SignUpScreen extends StatefulWidget {
  final bool isDark;
  const SignUpScreen({super.key, this.isDark = true});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  String? _confirmError;
  String? _nameError;
  String? _emailError;
  String? _phoneError;
  String? _addressError;
  String? _usernameError;
  String? _passwordError;
  bool _isLoading = false;

  // Validation methods
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return Get.find<LanguageController>().tr('name_required');
    }

    // Check if name contains only alphabets and spaces
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return Get.find<LanguageController>().tr('alphabets_only');
    }

    if (value.trim().length < 2) {
      return Get.find<LanguageController>().tr('name_min_chars');
    }

    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return Get.find<LanguageController>().tr('email_required');
    }

    // Basic email validation
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return Get.find<LanguageController>().tr('valid_email_required');
    }

    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return Get.find<LanguageController>().tr('phone_required');
    }

    // Remove any non-digit characters except +
    String cleanValue = value.replaceAll(RegExp(r'[^\d+]'), '');

    // Check if it starts with + and has 10 digits after country code
    // For simplicity, we'll check if it has 10-13 digits total (including country code)
    if (!RegExp(r'^\+?\d{10}$').hasMatch(cleanValue)) {
      return Get.find<LanguageController>().tr('valid_phone_required');
    }

    return null;
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return Get.find<LanguageController>().tr('username_required');
    }

    if (value.length < 3) {
      return Get.find<LanguageController>().tr('username_min_chars');
    }

    if (value.length > 20) {
      return Get.find<LanguageController>().tr('username_max_chars');
    }

    // Check if username contains only lowercase letters, numbers, underscores, and hyphens
    if (!RegExp(r'^[a-z0-9_-]+$').hasMatch(value)) {
      return Get.find<LanguageController>().tr('username_invalid_chars');
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return Get.find<LanguageController>().tr('password_required');
    }

    if (value.length < 6) {
      return Get.find<LanguageController>().tr('password_min_chars');
    }

    // Check for at least one uppercase, one lowercase, one number
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
      return Get.find<LanguageController>().tr('password_requirements');
    }

    return null;
  }

  String? _validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return Get.find<LanguageController>().tr('address_required');
    }

    if (value.length < 10) {
      return Get.find<LanguageController>().tr('complete_address_required');
    }

    return null;
  }

  // Password strength calculation
  double _calculatePasswordStrength(String password) {
    if (password.isEmpty) return 0.0;

    int strength = 0;

    // Length check
    if (password.length >= 6) strength += 20;
    if (password.length >= 8) strength += 10;

    // Character variety checks
    if (RegExp(r'[a-z]').hasMatch(password)) strength += 15;
    if (RegExp(r'[A-Z]').hasMatch(password)) strength += 15;
    if (RegExp(r'\d').hasMatch(password)) strength += 20;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) strength += 20;

    return (strength / 100.0).clamp(0.0, 1.0);
  }

  Color _getPasswordStrengthColor(double strength) {
    if (strength < 0.33) return Colors.red;
    if (strength < 0.66) return Colors.orange;
    return Colors.green;
  }

  String _getPasswordStrengthLabel(double strength) {
    if (strength == 0.0) return '';
    if (strength < 0.33) return Get.find<LanguageController>().tr('weak');
    if (strength < 0.66) return Get.find<LanguageController>().tr('medium');
    return Get.find<LanguageController>().tr('strong');
  }

  void _onSignUp() async {
    // Clear previous messages
    setState(() {
      _confirmError = null;
    });

    if (_passwordController.text != _confirmController.text) {
      setState(() {
        _confirmError = Get.find<LanguageController>().tr('passwords_not_match');
      });
      return;
    }

    // Validate all fields using our validation methods
    final nameError = _validateName(_nameController.text);
    final emailError = _validateEmail(_emailController.text);
    final phoneError = _validatePhone(_phoneController.text);
    final addressError = _validateAddress(_addressController.text);
    final usernameError = _validateUsername(_usernameController.text);
    final passwordError = _validatePassword(_passwordController.text);

    setState(() {
      _nameError = nameError;
      _emailError = emailError;
      _phoneError = phoneError;
      _addressError = addressError;
      _usernameError = usernameError;
      _passwordError = passwordError;
    });

    if (nameError != null ||
        emailError != null ||
        phoneError != null ||
        addressError != null ||
        usernameError != null ||
        passwordError != null) {
      // Show validation error message using toastification
      AppToast.warning(
        context,
        title: Get.find<LanguageController>().tr('validation_error'),
        description: Get.find<LanguageController>().tr('fix_validation_errors'),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Combine country code with phone number
      String fullPhoneNumber = '+91' + _phoneController.text.trim();

      final result = await ApiCalls.signupApi(
        username: _usernameController.text.trim(),
        useremail: _emailController.text.trim(),
        phoneNumber: fullPhoneNumber,
        password: _passwordController.text,
        buildingStreet: _addressController.text.trim(),
        area: '', // Could extract from address if needed
        city: '', // Could extract from address if needed
        state: '', // Could extract from address if needed
        country: '', // Could extract from address if needed
        pincode: '', // Could extract from address if needed
      );

      if (result['success']) {
        // Show success message using toastification
        AppToast.success(
          context,
          title: Get.find<LanguageController>().tr('success'),
          description: Get.find<LanguageController>().tr('account_created_success'),
        );

        // Navigate to login page after a delay to show success message
        await Future.delayed(Duration(seconds: 3));
        Get.toNamed('/login') ??
            Get.back(); // Navigate to login page using GetX
      } else {
        // Show error message using toastification
        String errorMessage =
            result['errorMessage'] ?? Get.find<LanguageController>().tr('signup_failed_retry');
        if (result['statusCode'] != null && result['statusCode'] != 0) {
          errorMessage =
              Get.find<LanguageController>().tr('error_with_status').replaceAll('{status}', result['statusCode'].toString()).replaceAll('{message}', result['data']['message'] ?? Get.find<LanguageController>().tr('signup_failed'));
        }

        AppToast.error(context, title: Get.find<LanguageController>().tr('error'), description: errorMessage);
      }
    } catch (e) {
      // Show error message using toastification
      AppToast.error(
        context,
        title: Get.find<LanguageController>().tr('error'),
        description: Get.find<LanguageController>().tr('unexpected_error').replaceAll('{error}', e.toString()),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
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

    // Get responsive values
    final padding = ResponsiveHelper.getResponsivePaddingLTRB(
      context,
      leftPercentage: 0.05,
      topPercentage: 0.02,
      rightPercentage: 0.05,
      bottomPercentage: 0.02,
    );

    final smallSpacing = ResponsiveHelper.getResponsiveSpacing(
      context,
      0.01,
      8,
      12,
    );
    final mediumSpacing = ResponsiveHelper.getResponsiveSpacing(
      context,
      0.015,
      12,
      16,
    );
    final largeSpacing = ResponsiveHelper.getResponsiveSpacing(
      context,
      0.02,
      16,
      24,
    );
    final extraLargeSpacing = ResponsiveHelper.getResponsiveSpacing(
      context,
      0.03,
      24,
      40,
    );
    final titleFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      0.025,
      18,
      24,
    );
    final subtitleFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      0.02,
      12,
      16,
    );
    final labelFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      0.022,
      14,
      18,
    );
    final iconSize = ResponsiveHelper.getResponsiveIconSize(
      context,
      0.04,
      30,
      48,
    );
    final circleSize = ResponsiveHelper.getResponsiveWidth(
      context,
      0.2,
      80,
      120,
    );

    return Scaffold(
      backgroundColor: colors.screenBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            padding.left,
            padding.top,
            padding.right,
            padding.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.arrow_back, color: colors.primaryText),
                  ),
                  Expanded(
                    child: Text(
                      Get.find<LanguageController>().tr('create_your_account'),
                      style: TextStyle(
                        color: colors.primaryText,
                        fontWeight: FontWeight.w800,
                        fontSize: titleFontSize,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    width: 48, // Space for back button
                  ),
                ],
              ),

              SizedBox(height: mediumSpacing),

              Center(
                child: Container(
                  width: circleSize,
                  height: circleSize,
                  decoration: BoxDecoration(
                    color: colors.card,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.fastfood,
                      size: iconSize,
                      color: colors.buttonBg,
                    ),
                  ),
                ),
              ),

              SizedBox(height: smallSpacing * 1.5),

              Center(
                child: Text(
                  Get.find<LanguageController>().tr('sign_up_subtitle'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colors.secondaryText,
                    fontSize: subtitleFontSize,
                  ),
                ),
              ),

              SizedBox(height: mediumSpacing),

              // Full Name
              Text(
                Get.find<LanguageController>().tr('full_name'),
                style: TextStyle(
                  color: colors.primaryText,
                  fontWeight: FontWeight.w700,
                  fontSize: labelFontSize,
                ),
              ),
              SizedBox(height: smallSpacing),
              TextField(
                controller: _nameController,
                style: TextStyle(
                  color: colors.primaryText,
                  fontSize: subtitleFontSize,
                ),
                onChanged: (value) {
                  setState(() {
                    _nameError = _validateName(value);
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: colors.inputBackground,
                  hintText: Get.find<LanguageController>().tr('enter_full_name'),
                  hintStyle: TextStyle(
                    color: colors.secondaryText,
                    fontSize: subtitleFontSize * 0.9,
                  ),
                  prefixIcon: Icon(Icons.person, color: colors.secondaryText),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: _nameError == null
                          ? colors.borderDefault
                          : Colors.red,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: _nameError == null
                          ? colors.borderActive
                          : Colors.red,
                    ),
                  ),
                  errorText: _nameError,
                  errorStyle: TextStyle(color: Colors.red),
                ),
              ),

              SizedBox(height: smallSpacing * 1.5),

              // Email
              Text(
                Get.find<LanguageController>().tr('email'),
                style: TextStyle(
                  color: colors.primaryText,
                  fontWeight: FontWeight.w700,
                  fontSize: labelFontSize,
                ),
              ),
              SizedBox(height: smallSpacing),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  color: colors.primaryText,
                  fontSize: subtitleFontSize,
                ),
                onChanged: (value) {
                  setState(() {
                    _emailError = _validateEmail(value);
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: colors.inputBackground,
                  hintText: Get.find<LanguageController>().tr('enter_email_address'),
                  hintStyle: TextStyle(
                    color: colors.secondaryText,
                    fontSize: subtitleFontSize * 0.9,
                  ),
                  prefixIcon: Icon(Icons.email, color: colors.secondaryText),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: _emailError == null
                          ? colors.borderDefault
                          : Colors.red,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: _emailError == null
                          ? colors.borderActive
                          : Colors.red,
                    ),
                  ),
                  errorText: _emailError,
                  errorStyle: TextStyle(color: Colors.red),
                ),
              ),

              SizedBox(height: smallSpacing * 1.5),

              // Contact Number
              Text(
                Get.find<LanguageController>().tr('contact_number'),
                style: TextStyle(
                  color: colors.primaryText,
                  fontWeight: FontWeight.w700,
                  fontSize: labelFontSize,
                ),
              ),
              SizedBox(height: smallSpacing),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                style: TextStyle(
                  color: colors.primaryText,
                  fontSize: subtitleFontSize,
                ),
                onChanged: (value) {
                  setState(() {
                    _phoneError = _validatePhone(value);
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: colors.inputBackground,
                  hintText: Get.find<LanguageController>().tr('enter_phone_number'),
                  hintStyle: TextStyle(
                    color: colors.secondaryText,
                    fontSize: subtitleFontSize * 0.9,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 16, right: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '+91',
                          style: TextStyle(
                            color: colors.primaryText,
                            fontSize: subtitleFontSize,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          height: 24,
                          width: 1,
                          color: colors.borderDefault,
                        ),
                      ],
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: _phoneError == null
                          ? colors.borderDefault
                          : Colors.red,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: _phoneError == null
                          ? colors.borderActive
                          : Colors.red,
                    ),
                  ),
                  errorText: _phoneError,
                  errorStyle: TextStyle(color: Colors.red),
                ),
              ),

              SizedBox(height: smallSpacing * 1.5),

              // Address
              Text(
                Get.find<LanguageController>().tr('address'),
                style: TextStyle(
                  color: colors.primaryText,
                  fontWeight: FontWeight.w700,
                  fontSize: labelFontSize,
                ),
              ),
              SizedBox(height: smallSpacing),
              TextField(
                controller: _addressController,
                maxLines: 3,
                style: TextStyle(
                  color: colors.primaryText,
                  fontSize: subtitleFontSize,
                ),
                onChanged: (value) {
                  setState(() {
                    _addressError = _validateAddress(value);
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: colors.inputBackground,
                  hintText:
                      Get.find<LanguageController>().tr('enter_complete_address'),
                  hintStyle: TextStyle(
                    color: colors.secondaryText,
                    fontSize: subtitleFontSize * 0.9,
                  ),
                  prefixIcon: Icon(
                    Icons.location_on,
                    color: colors.secondaryText,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: _addressError == null
                          ? colors.borderDefault
                          : Colors.red,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: _addressError == null
                          ? colors.borderActive
                          : Colors.red,
                    ),
                  ),
                  errorText: _addressError,
                  errorStyle: TextStyle(color: Colors.red),
                ),
              ),

              SizedBox(height: smallSpacing * 1.5),

              // Username
              Text(
                Get.find<LanguageController>().tr('username'),
                style: TextStyle(
                  color: colors.primaryText,
                  fontWeight: FontWeight.w700,
                  fontSize: labelFontSize,
                ),
              ),
              SizedBox(height: smallSpacing),
              TextField(
                controller: _usernameController,
                style: TextStyle(
                  color: colors.primaryText,
                  fontSize: subtitleFontSize,
                ),
                onChanged: (value) {
                  setState(() {
                    _usernameError = _validateUsername(value);
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: colors.inputBackground,
                  hintText: Get.find<LanguageController>().tr('username_hint'),
                  hintStyle: TextStyle(
                    color: colors.secondaryText,
                    fontSize: subtitleFontSize * 0.9,
                  ),
                  prefixIcon: Icon(
                    Icons.alternate_email,
                    color: colors.secondaryText,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: _usernameError == null
                          ? colors.borderDefault
                          : Colors.red,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: _usernameError == null
                          ? colors.borderActive
                          : Colors.red,
                    ),
                  ),
                  errorText: _usernameError,
                  errorStyle: TextStyle(color: Colors.red),
                ),
              ),

              SizedBox(height: smallSpacing * 1.5),

              // Create Password
              Text(
                Get.find<LanguageController>().tr('create_password'),
                style: TextStyle(
                  color: colors.primaryText,
                  fontWeight: FontWeight.w700,
                  fontSize: labelFontSize,
                ),
              ),
              SizedBox(height: smallSpacing),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                style: TextStyle(
                  color: colors.primaryText,
                  fontSize: subtitleFontSize,
                ),
                onChanged: (value) {
                  setState(() {
                    _passwordError = _validatePassword(value);
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: colors.inputBackground,
                  hintText: Get.find<LanguageController>().tr('enter_password'),
                  hintStyle: TextStyle(
                    color: colors.secondaryText,
                    fontSize: subtitleFontSize * 0.9,
                  ),
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
                    borderSide: BorderSide(
                      color: _passwordError == null
                          ? colors.borderDefault
                          : Colors.red,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: _passwordError == null
                          ? colors.borderActive
                          : Colors.red,
                    ),
                  ),
                  errorText: _passwordError,
                  errorStyle: TextStyle(color: Colors.red),
                ),
              ),

              SizedBox(height: smallSpacing),

              // Password strength bar
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    Get.find<LanguageController>().tr('password_strength'),
                    style: TextStyle(
                      color: colors.secondaryText,
                      fontSize: subtitleFontSize * 0.8,
                    ),
                  ),
                  SizedBox(height: smallSpacing * 0.5),
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
                      widthFactor: _calculatePasswordStrength(
                        _passwordController.text,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: _getPasswordStrengthColor(
                            _calculatePasswordStrength(
                              _passwordController.text,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: smallSpacing * 0.75),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      _getPasswordStrengthLabel(
                        _calculatePasswordStrength(_passwordController.text),
                      ),
                      style: TextStyle(
                        color: _getPasswordStrengthColor(
                          _calculatePasswordStrength(_passwordController.text),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: smallSpacing * 1.5),

              // Confirm Password
              Text(
                Get.find<LanguageController>().tr('confirm_password'),
                style: TextStyle(
                  color: colors.primaryText,
                  fontWeight: FontWeight.w700,
                  fontSize: labelFontSize,
                ),
              ),
              SizedBox(height: smallSpacing),
              TextField(
                controller: _confirmController,
                obscureText: _obscureConfirm,
                style: TextStyle(
                  color: colors.primaryText,
                  fontSize: subtitleFontSize,
                ),
                onChanged: (value) {
                  if (_passwordController.text != value) {
                    setState(() {
                      _confirmError = 'Passwords do not match.';
                    });
                  } else {
                    setState(() {
                      _confirmError = null;
                    });
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: colors.inputBackground,
                  hintText: Get.find<LanguageController>().tr('confirm_password_hint'),
                  hintStyle: TextStyle(
                    color: colors.secondaryText,
                    fontSize: subtitleFontSize * 0.9,
                  ),
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
                      color: _confirmError == null
                          ? colors.borderDefault
                          : Colors.red,
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
                  errorText: _confirmError,
                  errorStyle: TextStyle(color: Colors.red),
                ),
              ),

              SizedBox(height: mediumSpacing),

              // Sign Up button
              PrimaryButton(
                label: _isLoading ? Get.find<LanguageController>().tr('signing_up') : Get.find<LanguageController>().tr('sign_up'),
                onPressed: _isLoading ? null : _onSignUp,
                backgroundColor: colors.buttonBg,
                textColor: colors.buttonText,
                shadowColor: colors.buttonShadow,
              ),

              SizedBox(height: smallSpacing * 2),

              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      color: colors.secondaryText,
                      fontSize: subtitleFontSize,
                      height: 1.4,
                    ),
                    children: [
                      TextSpan(
                        text: Get.find<LanguageController>().tr('have_account'),
                      ),
                      TextSpan(
                        text: Get.find<LanguageController>().tr('login'),
                        style: TextStyle(
                          color: colors.buttonBg,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: extraLargeSpacing),
            ],
          ),
        ),
      ),
    );
  }
}
