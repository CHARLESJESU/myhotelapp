import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/responsive_helper.dart';
import '../../../services/auth_service.dart';
import '../../../services/user_model.dart';
import '../../api/api_calls.dart';
import '../../router/routing.dart';
import '../../widgets/app_toast.dart';
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

  void _onLogin() async {
    final useremail = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    // Basic validation
    if (useremail.isEmpty || password.isEmpty) {
      AppToast.error(
        context,
        title: 'Validation Error',
        description: 'Please enter both email and password',
      );
      return;
    }

    // Call the login API
    try {
      final result = await ApiCalls.loginApi(
        useremail: useremail,
        userpassword: password,
      );

      if (result['success']) {
        // Extract user data from response
        final responseJson = result['data'];
        final userData = responseJson['responseData'];

        // Create User object from the response data
        final user = User(
          userId: userData['userid'] ?? 0,
          userName: userData['username'] ?? '',
          userEmail: userData['useremail'] ?? '',
          phoneNumber: userData['phoneNumber'],
          userPassword: userData['userpassword'],
          address: userData['address'],
          isAddressProvided: userData['isaddressprvided'] == true || userData['isaddressprvided'] == 1,
          isRestaurantOwner: userData['isrestaurentowner'] == true || userData['isrestaurentowner'] == 1,
          lastVisitedScreen: null, // Initially null when logging in
        );

        // Login successful - store user data in SQLite and update auth state
        await AuthService.to.loginWithUserData(user, ''); // Assuming no token in response

        // Clear any previous last visited screen since user just logged in
        await AuthService.to.setLastVisitedScreen('');

        AppToast.success(
          context,
          title: 'Success',
          description: 'Login successful!',
        );

        // Navigate to appropriate screen based on user type
        if (user.isRestaurantOwner) {
          // Navigate to admin page if user is a restaurant owner
          Get.offAllNamed(AppRoutes.adminOrderManagement);
        } else {
          // Navigate to main screen (with home tab as default) if user is a regular user
          Get.offAllNamed(AppRoutes.main);
        }
      } else {
        // Login failed
        String errorMessage = 'Login failed. Please check your credentials.';
        if (result['errorMessage'] != null) {
          errorMessage = result['errorMessage'];
        } else if (result['data'] != null && result['data']['message'] != null) {
          errorMessage = result['data']['message'];
        }

        AppToast.error(
          context,
          title: 'Login Failed',
          description: errorMessage,
        );
      }
    } catch (e) {
      AppToast.error(
        context,
        title: 'Error',
        description: 'An unexpected error occurred: $e',
      );
    }
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
      16,
    );
    final mediumSpacing = ResponsiveHelper.getResponsiveSpacing(
      context,
      0.02,
      16,
      28,
    );
    final titleFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      0.035,
      24,
      34,
    );
    final subtitleFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      0.022,
      12,
      16,
    );
    final labelFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      0.024,
      14,
      18,
    );

    return Scaffold(
      backgroundColor: colors.screenBackground,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bottomInset = MediaQuery.of(context).viewInsets.bottom;
            final availableHeight =
                constraints.maxHeight -
                padding.top -
                padding.bottom -
                bottomInset;

            return Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    padding.left,
                    padding.top,
                    padding.right,
                    padding.bottom + bottomInset,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: availableHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: smallSpacing),

                          // centered circular icon with responsive sizing
                          Center(
                            child: Container(
                              width: ResponsiveHelper.getResponsiveWidth(
                                context,
                                0.25,
                                100,
                                150,
                              ),
                              height: ResponsiveHelper.getResponsiveWidth(
                                context,
                                0.25,
                                100,
                                150,
                              ),
                              decoration: BoxDecoration(
                                color: colors.card,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.restaurant,
                                  size: ResponsiveHelper.getResponsiveIconSize(
                                    context,
                                    0.03,
                                    30,
                                    50,
                                  ),
                                  color: colors.buttonBg,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: mediumSpacing),

                          // Welcome title with responsive font size
                          Center(
                            child: Text(
                              'Welcome Back',
                              style: TextStyle(
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.w800,
                                color: colors.primaryText,
                              ),
                            ),
                          ),

                          SizedBox(height: smallSpacing),

                          Center(
                            child: Text(
                              'Log in to continue your culinary journey.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: subtitleFontSize,
                                color: colors.secondaryText,
                              ),
                            ),
                          ),

                          SizedBox(height: mediumSpacing),

                          // Email label with responsive font size
                          Text(
                            'Email',
                            style: TextStyle(
                              color: colors.primaryText,
                              fontWeight: FontWeight.w700,
                              fontSize: labelFontSize,
                            ),
                          ),
                          SizedBox(height: smallSpacing),

                          // email field
                          TextField(
                            controller: _usernameController,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: colors.primaryText),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: colors.inputBackground,
                              hintText: 'Enter your email',
                              hintStyle: TextStyle(color: colors.secondaryText),
                              prefixIcon: Icon(
                                Icons.email,
                                color: colors.secondaryText,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: colors.borderDefault,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: colors.borderActive,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: smallSpacing * 1.5),

                          Text(
                            'Password',
                            style: TextStyle(
                              color: colors.primaryText,
                              fontWeight: FontWeight.w700,
                              fontSize: labelFontSize,
                            ),
                          ),

                          SizedBox(height: smallSpacing),

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
                                borderSide: BorderSide(
                                  color: colors.borderDefault,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: colors.borderActive,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: mediumSpacing),

                          // Login button with responsive height
                          SizedBox(
                            height: ResponsiveHelper.getResponsiveButtonHeight(
                              context,
                              0.06,
                              48,
                              60,
                            ),
                            child: PrimaryButton(
                              label: 'Login',
                              onPressed: _onLogin,
                              backgroundColor: colors.buttonBg,
                              textColor: colors.buttonText,
                              shadowColor: colors.buttonShadow,
                            ),
                          ),

                          SizedBox(height: smallSpacing * 1.5),

                          // Forgot password
                          Center(
                            child: TextButton(
                              onPressed: () =>
                                  Get.toNamed(AppRoutes.forgotPassword),
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: colors.buttonBg,
                                  fontWeight: FontWeight.w600,
                                  fontSize: subtitleFontSize * 0.9,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: smallSpacing),
                          // Prompt to sign in or register
                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Don't have an account? ",
                                  style: TextStyle(
                                    color: colors.secondaryText,
                                    fontSize: subtitleFontSize * 0.9,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Get.toNamed(AppRoutes.signUp),
                                  child: Text(
                                    'Sign in',
                                    style: TextStyle(
                                      color: colors.buttonBg,
                                      fontWeight: FontWeight.w700,
                                      fontSize: subtitleFontSize * 0.9,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Use Flexible instead of Spacer to prevent overflow
                          Flexible(child: Container()),
                        ],
                      ),
                    ),
                  ),
                ),

                // top-right theme toggle button with responsive positioning
                Positioned(
                  top: ResponsiveHelper.getResponsiveHeight(
                    context,
                    0.02,
                    8,
                    20,
                  ),
                  right: ResponsiveHelper.getResponsiveWidth(
                    context,
                    0.04,
                    8,
                    20,
                  ),
                  child: ThemeToggleButton(
                    isDark: context.isCurrentThemeDark,
                    cardBg: colors.inputBackground,
                    borderColor: colors.borderDefault,
                    iconColor: colors.buttonBg,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
