import 'package:flutter/material.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/responsive_helper.dart';
import '../../../services/theme_service.dart';
import '../../widgets/image_picker_ui.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/success_message.dart';
import 'add_recipe_dummydata.dart';
import 'widget/add_recipe_widget.dart';

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

  void _onAddRecipe() {
    setState(() {
      _showSuccess = false; // reset previous message
    });

    if (_formKey.currentState?.validate() ?? false) {
      // UI-only success state
      setState(() {
        _showSuccess = true;
      });
      // Optionally keep values; no backend logic per scope.
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
          'Add New Recipe',
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
                        // Appearance selector
                        AppearanceSelector(
                          appearance: ThemeService.appearanceLabel,
                          onAppearanceChanged: (label) {
                            if (label == 'Light')
                              ThemeService.setThemeMode(ThemeMode.light);
                            if (label == 'Dark')
                              ThemeService.setThemeMode(ThemeMode.dark);
                            if (label == 'System')
                              ThemeService.setThemeMode(ThemeMode.system);
                          },
                        ),

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
                                    labelText: 'Food Name',
                                    labelStyle: TextStyle(
                                      color: colors.primaryText,
                                      fontSize: labelFontSize,
                                    ),
                                    hintText: 'e.g. Classic Margherita Pizza',
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
                                      ? 'Please enter food name'
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
                                    labelText: 'Description (Optional)',
                                    labelStyle: TextStyle(
                                      color: colors.primaryText,
                                      fontSize: labelFontSize,
                                    ),
                                    hintText:
                                        'e.g. Fresh basil, mozzarella, and a rich tomato sauce...',
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
                                    labelText: 'Mode of Food',
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
                                  items: AddRecipeDummyData.modes
                                      .map(
                                        (m) => DropdownMenuItem(
                                          value: m,
                                          child: Text(
                                            m,
                                            style: TextStyle(
                                              fontSize: labelFontSize * 0.9,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (v) => setState(() => _mode = v),
                                  validator: (v) => v == null || v.isEmpty
                                      ? 'Please select mode'
                                      : null,
                                ),
                                SizedBox(height: smallSpacing),
                                DropdownButtonFormField<String>(
                                  value: _category,
                                  decoration: InputDecoration(
                                    labelText: 'Food Category',
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
                                  items: AddRecipeDummyData.categories
                                      .map(
                                        (c) => DropdownMenuItem(
                                          value: c,
                                          child: Text(
                                            c,
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
                                      ? 'Please select category'
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
                                    labelText: 'Price / Cost',
                                    labelStyle: TextStyle(
                                      color: colors.primaryText,
                                      fontSize: labelFontSize,
                                    ),
                                    prefixText: '\$ ',
                                    hintText: '0.00',
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
                                      return 'Please enter price';
                                    }
                                    final parsed = double.tryParse(v);
                                    if (parsed == null) {
                                      return 'Please enter a valid number';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: mediumSpacing),
                                Text(
                                  'Upload Food Image (Optional)',
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

                        SizedBox(height: mediumSpacing),

                        if (_showSuccess)
                          const SuccessMessage(
                            message: 'Success! Recipe added successfully.',
                          ),

                        SizedBox(height: smallSpacing),

                        const Spacer(),

                        // primary action at bottom
                        Padding(
                          padding: EdgeInsets.only(bottom: mediumSpacing),
                          child: PrimaryButton(
                            label: AppStrings.addRecipe,
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
