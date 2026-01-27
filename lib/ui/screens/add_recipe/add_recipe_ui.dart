import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/responsive_helper.dart';
import '../../../language/language_controller.dart';
import '../../../services/auth_service.dart';
import '../../../services/database_service.dart';
import '../../api/api_calls.dart';
import '../../widgets/image_picker_ui.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/app_toast.dart';
import 'add_recipe_dummydata.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  String? _mode;
  String? _category;
  bool _showSuccess = false;
  bool _hasImage = false;

  @override
  void initState() {
    super.initState();
  }

  void _onUploadImage() {
    // UI-only: simulate an image being selected
    setState(() {
      _hasImage = true;
    });
  }

  void _onAddRecipe() async {
    setState(() {
      _showSuccess = false; // reset previous message
    });

    if (_formKey.currentState?.validate() ?? false) {
      // Get the current user ID directly from database service
      final databaseService = DatabaseService();
      final authService = AuthService.to;
      final currentUser = authService.currentUser;

      if (currentUser == null) {
        AppToast.error(
          context,
          title: Get.find<LanguageController>().tr('error'),
          description: Get.find<LanguageController>().tr(
            'user_not_authenticated',
          ),
        );
        return;
      }

      // Prepare API call parameters
      final foodName = _nameController.text.trim();
      final foodDescription = _descriptionController.text.trim();
      final foodCost =
          double.tryParse(_priceController.text.trim())?.toInt() ?? 0;
      final modeOfFood = _mode ?? '';
      final foodCategory = _category ?? '';

      // Get user data from database service
      final userFromDb = await databaseService.getUserByEmail(
        currentUser.userEmail,
      );

      if (userFromDb == null) {
        AppToast.error(
          context,
          title: Get.find<LanguageController>().tr('error'),
          description: Get.find<LanguageController>().tr('user_data_not_found'),
        );
        return;
      }

      // Extract IDs from database record
      int userId = userFromDb['userid'] ?? 0;
      int restaurantId =
          userFromDb['restaurantid'] ??
          1; // Default to restaurant ID 1 for testing

      final available = true; // Assuming the recipe is available when added
      final foodImage = ''; // Placeholder for image URL

      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            content: Row(
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 20),
                Text(
                  'Adding recipe...',
                  style: TextStyle(color: dialogContext.colors.primaryText),
                ),
              ],
            ),
          );
        },
      );

      try {
        // Call the add recipe API
        final result = await ApiCalls.addRecipeApi(
          foodname: foodName,
          cost: foodCost,
          foodimage: foodImage,
          modeoffood: modeOfFood,
          foodcategory: foodCategory,
          fooddescription: foodDescription,
          restaurantid: restaurantId,
          available: available,
        );

        // Close the loading dialog if context is still valid
        if (mounted) {
          Navigator.of(context).pop();
        }

        if (result['success'] && mounted) {
          // Show success message
          setState(() {
            _showSuccess = true;
          });

          // Show success toast
          AppToast.success(
            context,
            title: Get.find<LanguageController>().tr('success'),
            description: Get.find<LanguageController>().tr(
              'recipe_added_successfully',
            ),
          );

          // Clear form after successful submission
          _nameController.clear();
          _descriptionController.clear();
          _priceController.clear();
          setState(() {
            _mode = null;
            _category = null;
            _hasImage = false;
          });
        } else if (mounted) {
          // Show error message
          String errorMessage =
              result['errorMessage'] ??
              Get.find<LanguageController>().tr('failed_add_recipe');
          if (result['data'] != null && result['data']['message'] != null) {
            errorMessage = result['data']['message'];
          }

          AppToast.error(
            context,
            title: Get.find<LanguageController>().tr('error'),
            description: errorMessage,
          );
        }
      } catch (e) {
        // Close the loading dialog if context is still valid
        if (mounted) {
          Navigator.of(context).pop();
        }

        if (mounted) {
          AppToast.error(
            context,
            title: Get.find<LanguageController>().tr('error'),
            description: Get.find<LanguageController>()
                .tr('unexpected_error')
                .replaceAll('{error}', e.toString()),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors; // ✅ Clean theme-aware colors

    // Get responsive values
    final padding = ResponsiveHelper.getResponsivePaddingLTRB(
      context,
      leftPercentage: 0.04,
      topPercentage: 0.015,
      rightPercentage: 0.04,
      bottomPercentage: 0.015,
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
    final titleFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      0.025,
      16,
      20,
    );
    final labelFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      0.022,
      14,
      18,
    );
    final iconSize = ResponsiveHelper.getResponsiveIconSize(
      context,
      0.03,
      30,
      40,
    );

    return Scaffold(
      backgroundColor: colors.screenBackground,
      appBar: AppBar(
        backgroundColor: colors.appBarBg,
        title: Text(
          Get.find<LanguageController>().tr('add_new_recipe_title'),
          style: TextStyle(color: colors.primaryText, fontSize: titleFontSize),
        ),
        leading: BackButton(color: colors.primaryText),
        elevation: 0,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bottomInset = MediaQuery.of(context).viewInsets.bottom;
            final availableHeight =
                constraints.maxHeight -
                padding.top -
                padding.bottom -
                bottomInset;

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                padding.left,
                padding.top,
                padding.right,
                padding.bottom + bottomInset,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: availableHeight),
                child: IntrinsicHeight(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // main card
                        Card(
                          color: colors.inputBackground,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                          child: Padding(
                            padding: EdgeInsets.all(mediumSpacing),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Food Name
                                TextFormField(
                                  controller: _nameController,
                                  style: TextStyle(
                                    color: colors.primaryText,
                                    fontSize: labelFontSize * 0.9,
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: colors.inputBackground,
                                    labelText: Get.find<LanguageController>()
                                        .tr('food_name'),
                                    labelStyle: TextStyle(
                                      color: colors.primaryText,
                                      fontSize: labelFontSize,
                                    ),
                                    hintText: Get.find<LanguageController>().tr(
                                      'food_name_hint',
                                    ),
                                    hintStyle: TextStyle(
                                      color: colors.secondaryText,
                                      fontSize: labelFontSize * 0.85,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: colors.borderDefault,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: colors.borderActive,
                                      ),
                                    ),
                                  ),
                                  validator: (v) =>
                                      (v == null || v.trim().isEmpty)
                                      ? Get.find<LanguageController>().tr(
                                          'please_enter_food_name',
                                        )
                                      : null,
                                ),
                                SizedBox(height: smallSpacing),

                                // Description
                                TextFormField(
                                  controller: _descriptionController,
                                  style: TextStyle(
                                    color: colors.primaryText,
                                    fontSize: labelFontSize * 0.9,
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: colors.inputBackground,
                                    labelText: Get.find<LanguageController>()
                                        .tr('description_optional'),
                                    labelStyle: TextStyle(
                                      color: colors.primaryText,
                                      fontSize: labelFontSize,
                                    ),
                                    hintText: Get.find<LanguageController>().tr(
                                      'description_hint',
                                    ),
                                    hintStyle: TextStyle(
                                      color: colors.secondaryText,
                                      fontSize: labelFontSize * 0.85,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: colors.borderDefault,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: colors.borderActive,
                                      ),
                                    ),
                                  ),
                                  minLines: 3,
                                  maxLines: 5,
                                ),
                                SizedBox(height: smallSpacing),

                                // Mode & Category & Price & Image
                                DropdownButtonFormField<String>(
                                  value: _mode,
                                  decoration: InputDecoration(
                                    labelText: Get.find<LanguageController>()
                                        .tr('mode_of_food'),
                                    labelStyle: TextStyle(
                                      color: colors.primaryText,
                                      fontSize: labelFontSize,
                                    ),
                                    filled: true,
                                    fillColor: colors.inputBackground,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: colors.borderDefault,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: colors.borderActive,
                                      ),
                                    ),
                                  ),
                                  dropdownColor: colors.inputBackground,
                                  style: TextStyle(
                                    color: colors.primaryText,
                                    fontSize: labelFontSize * 0.9,
                                  ),
                                  items: AddRecipeDummyData.modeKeys
                                      .map(
                                        (m) => DropdownMenuItem(
                                          value: m,
                                          child: Text(
                                            Get.find<LanguageController>().tr(
                                              m,
                                            ),
                                            style: TextStyle(
                                              fontSize: labelFontSize * 0.9,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (v) => setState(() => _mode = v),
                                  validator: (v) => v == null || v.isEmpty
                                      ? Get.find<LanguageController>().tr(
                                          'please_select_mode',
                                        )
                                      : null,
                                ),
                                SizedBox(height: smallSpacing),
                                DropdownButtonFormField<String>(
                                  value: _category,
                                  decoration: InputDecoration(
                                    labelText: Get.find<LanguageController>()
                                        .tr('food_category'),
                                    labelStyle: TextStyle(
                                      color: colors.primaryText,
                                      fontSize: labelFontSize,
                                    ),
                                    filled: true,
                                    fillColor: colors.inputBackground,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: colors.borderDefault,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: colors.borderActive,
                                      ),
                                    ),
                                  ),
                                  dropdownColor: colors.inputBackground,
                                  style: TextStyle(
                                    color: colors.primaryText,
                                    fontSize: labelFontSize * 0.9,
                                  ),
                                  items: AddRecipeDummyData.categoryKeys
                                      .map(
                                        (c) => DropdownMenuItem(
                                          value: c,
                                          child: Text(
                                            Get.find<LanguageController>().tr(
                                              c,
                                            ),
                                            style: TextStyle(
                                              fontSize: labelFontSize * 0.9,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (v) =>
                                      setState(() => _category = v),
                                  validator: (v) => v == null || v.isEmpty
                                      ? Get.find<LanguageController>().tr(
                                          'please_select_category',
                                        )
                                      : null,
                                ),
                                SizedBox(height: smallSpacing),
                                TextFormField(
                                  controller: _priceController,
                                  style: TextStyle(
                                    color: colors.primaryText,
                                    fontSize: labelFontSize * 0.9,
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: colors.inputBackground,
                                    labelText: Get.find<LanguageController>()
                                        .tr('price_cost'),
                                    labelStyle: TextStyle(
                                      color: colors.primaryText,
                                      fontSize: labelFontSize,
                                    ),
                                    prefixText: '\$ ',
                                    hintText: Get.find<LanguageController>().tr(
                                      'price_hint',
                                    ),
                                    hintStyle: TextStyle(
                                      color: colors.secondaryText,
                                      fontSize: labelFontSize * 0.85,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: colors.borderDefault,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: colors.borderActive,
                                      ),
                                    ),
                                  ),
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                        decimal: true,
                                      ),
                                  validator: (v) {
                                    if (v == null || v.trim().isEmpty) {
                                      return Get.find<LanguageController>().tr(
                                        'please_enter_price',
                                      );
                                    }
                                    final parsed = double.tryParse(v);
                                    if (parsed == null) {
                                      return Get.find<LanguageController>().tr(
                                        'please_enter_valid_number',
                                      );
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: mediumSpacing),
                                Text(
                                  Get.find<LanguageController>().tr(
                                    'upload_food_image',
                                  ),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: colors.primaryText,
                                    fontSize: labelFontSize,
                                  ),
                                ),
                                SizedBox(height: smallSpacing),
                                ImagePickerUI(
                                  preview: _hasImage
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: Container(
                                            color: colors.uploadPlaceholder,
                                            width: double.infinity,
                                            height: double.infinity,
                                            child: Icon(
                                              Icons.restaurant,
                                              size: iconSize,
                                              color: colors.buttonText,
                                            ),
                                          ),
                                        )
                                      : null,
                                  onUpload: _onUploadImage,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // primary action at bottom
                        Padding(
                          padding: EdgeInsets.only(bottom: mediumSpacing),
                          child: PrimaryButton(
                            label: Get.find<LanguageController>().tr(
                              'add_recipe',
                            ),
                            onPressed: _onAddRecipe,
                            backgroundColor: colors.buttonBg,
                            textColor: colors.buttonText,
                            shadowColor: colors.buttonShadow,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
