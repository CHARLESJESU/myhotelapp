import 'package:flutter/material.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_colors.dart';
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

  String _appearance = 'Dark';

  @override
  void initState() {
    super.initState();
    final mode = ThemeService.current;
    _appearance = mode == ThemeMode.dark
        ? 'Dark'
        : mode == ThemeMode.light
        ? 'Light'
        : 'System';
    ThemeService.themeMode.addListener(_onThemeModeChanged);
  }

  void _onThemeModeChanged() {
    final mode = ThemeService.current;
    setState(() {
      _appearance = mode == ThemeMode.dark
          ? 'Dark'
          : mode == ThemeMode.light
          ? 'Light'
          : 'System';
    });
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
    ThemeService.themeMode.removeListener(_onThemeModeChanged);
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark
        ? AppColors.screenBackground
        : AppColors.lightScreenBackground;
    final inputBg = isDark
        ? AppColors.inputBackground
        : AppColors.lightInputBackground;
    final primaryText = isDark
        ? AppColors.primaryText
        : AppColors.lightPrimaryText;
    final secondaryText = isDark
        ? AppColors.secondaryText
        : AppColors.lightSecondaryText;
    final borderDefault = isDark
        ? AppColors.borderDefault
        : AppColors.lightBorderDefault;
    final buttonBg = isDark ? AppColors.buttonBg : AppColors.lightButtonBg;
    final buttonText = isDark
        ? AppColors.buttonText
        : AppColors.lightButtonText;
    final appBarBg = isDark ? AppColors.appBarBg : bg;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: appBarBg,
        title: Text('Add New Recipe', style: TextStyle(color: primaryText)),
        leading: BackButton(color: primaryText),
        elevation: 0,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bottomInset = MediaQuery.of(context).viewInsets.bottom;
            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + bottomInset),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 16,
                ),
                child: IntrinsicHeight(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Appearance selector
                        AppearanceSelector(
                          appearance: _appearance,
                          onAppearanceChanged: (label) {
                            setState(() => _appearance = label);
                            if (label == 'Light') ThemeService.setThemeMode(ThemeMode.light);
                            if (label == 'Dark') ThemeService.setThemeMode(ThemeMode.dark);
                            if (label == 'System') ThemeService.setThemeMode(ThemeMode.system);
                          },
                        ),

                        // main card
                        Card(
                          color: inputBg,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Food Name
                                TextFormField(
                                  controller: _nameController,
                                  style: TextStyle(color: primaryText),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: inputBg,
                                    labelText: 'Food Name',
                                    labelStyle: TextStyle(color: primaryText),
                                    hintText: 'e.g. Classic Margherita Pizza',
                                    hintStyle: TextStyle(color: secondaryText),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: borderDefault,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                        color: AppColors.borderActive,
                                      ),
                                    ),
                                  ),
                                  validator: (v) =>
                                      (v == null || v.trim().isEmpty)
                                      ? 'Please enter food name'
                                      : null,
                                ),
                                const SizedBox(height: 12),

                                // Description
                                TextFormField(
                                  controller: _descriptionController,
                                  style: TextStyle(color: primaryText),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: inputBg,
                                    labelText: 'Description (Optional)',
                                    labelStyle: TextStyle(color: primaryText),
                                    hintText:
                                        'e.g. Fresh basil, mozzarella, and a rich tomato sauce...',
                                    hintStyle: TextStyle(color: secondaryText),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: borderDefault,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                        color: AppColors.borderActive,
                                      ),
                                    ),
                                  ),
                                  minLines: 3,
                                  maxLines: 5,
                                ),
                                const SizedBox(height: 12),

                                // Mode & Category & Price & Image
                                DropdownButtonFormField<String>(
                                  value: _mode,
                                  decoration: InputDecoration(
                                    labelText: 'Mode of Food',
                                    labelStyle: TextStyle(color: primaryText),
                                    filled: true,
                                    fillColor: inputBg,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: borderDefault,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                        color: AppColors.borderActive,
                                      ),
                                    ),
                                  ),
                                  dropdownColor: inputBg,
                                  style: TextStyle(color: primaryText),
                                  items: AddRecipeDummyData.modes
                                      .map(
                                        (m) => DropdownMenuItem(
                                          value: m,
                                          child: Text(m),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (v) => setState(() => _mode = v),
                                  validator: (v) => v == null || v.isEmpty
                                      ? 'Please select mode'
                                      : null,
                                ),
                                const SizedBox(height: 12),
                                DropdownButtonFormField<String>(
                                  value: _category,
                                  decoration: InputDecoration(
                                    labelText: 'Food Category',
                                    labelStyle: TextStyle(color: primaryText),
                                    filled: true,
                                    fillColor: inputBg,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: borderDefault,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                        color: AppColors.borderActive,
                                      ),
                                    ),
                                  ),
                                  dropdownColor: inputBg,
                                  style: TextStyle(color: primaryText),
                                  items: AddRecipeDummyData.categories
                                      .map(
                                        (c) => DropdownMenuItem(
                                          value: c,
                                          child: Text(c),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (v) =>
                                      setState(() => _category = v),
                                  validator: (v) => v == null || v.isEmpty
                                      ? 'Please select category'
                                      : null,
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: _priceController,
                                  style: const TextStyle(
                                    color: AppColors.primaryText,
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: inputBg,
                                    labelText: 'Price / Cost',
                                    labelStyle: TextStyle(color: primaryText),
                                    prefixText: '\$ ',
                                    hintText: '0.00',
                                    hintStyle: TextStyle(color: secondaryText),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: borderDefault,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                        color: AppColors.borderActive,
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
                                const SizedBox(height: 16),
                                Text(
                                  'Upload Food Image (Optional)',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: primaryText,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ImagePickerUI(
                                  preview: _hasImage
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: Container(
                                            color: AppColors.uploadPlaceholder,
                                            width: double.infinity,
                                            height: double.infinity,
                                            child: const Icon(
                                              Icons.restaurant,
                                              size: 36,
                                              color: AppColors.buttonText,
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

                        const SizedBox(height: 16),

                        if (_showSuccess)
                          const SuccessMessage(
                            message: 'Success! Recipe added successfully.',
                          ),

                        const SizedBox(height: 12),

                        const Spacer(),

                        // primary action at bottom
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: PrimaryButton(
                            label: AppStrings.addRecipe,
                            onPressed: _onAddRecipe,
                            backgroundColor: buttonBg,
                            textColor: buttonText,
                            shadowColor: AppColors.buttonShadow,
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
