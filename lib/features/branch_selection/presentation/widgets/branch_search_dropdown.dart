import 'package:e_cashier/core/constant/colors.dart';
import 'package:e_cashier/core/utils/styles.dart';
import 'package:e_cashier/core/utils/app_strings.dart';
import 'package:e_cashier/core/utils/responsive_size_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/cubit/translation/translation_cubit.dart';
import '../../../../core/di/injector.dart';
import '../../data/models/branch_model.dart';
import '../bloc/branch_bloc.dart';
import '../cubit/show_sign_in_button/show_sign_in_button_cubit.dart';

class BranchSearchDropdown extends StatelessWidget {
  final ValueChanged<BranchModel?>? onChanged;
  final BranchModel? initialValue;

  const BranchSearchDropdown({
    super.key,
    this.onChanged,
    this.initialValue
  });

  @override
  Widget build(BuildContext context) {
    final isArabic = context.read<TranslationCubit>().state.currentLocale.languageCode == 'ar';

    return BlocBuilder<BranchBloc, BranchState>(
      builder: (context, state) {
        if (state is BranchLoading) {
          return _buildLoadingWidget(context);
        }

        if (state is BranchError) {
          return _buildErrorWidget(context, state.message);
        }

        if (state is BranchSuccess) {
          return _buildAutocompleteWidget(context, state.responseData, isArabic);
        }

        return const SizedBox();
      },
    );
  }

  Widget _buildAutocompleteWidget(
      BuildContext context,
      List<BranchModel> branches,
      bool isArabic
      ) {
    return Autocomplete<BranchModel>(
      optionsBuilder: (textEditingValue) => _buildOptions(textEditingValue, branches),
      displayStringForOption: (branch) => _getDisplayString(branch, isArabic),
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        _handleInitialValue(controller, initialValue, isArabic);

        return _buildSearchField(
            context,
            controller,
            focusNode,
            onFieldSubmitted
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return _buildOptionsView(context, options, onSelected, isArabic);
      },
      onSelected: (selection) {
        FocusScope.of(context).unfocus();
        onChanged?.call(selection);
        context.read<ShowSignInButtonCubit>().toggle(true);
      },
    );
  }

  List<BranchModel> _buildOptions(
      TextEditingValue textEditingValue,
      List<BranchModel> branches
      ) {
    if (textEditingValue.text.isEmpty) return branches;

    return branches.where((branch) {
      return (branch.branchNameAr?.toLowerCase().contains(
        textEditingValue.text.toLowerCase(),
      ) ??
          false) ||
          (branch.branchNameEn?.toLowerCase().contains(
            textEditingValue.text.toLowerCase(),
          ) ??
              false);
    }).toList();
  }

  String _getDisplayString(BranchModel branch, bool isArabic) {
    final branchName = isArabic
        ? (branch.branchNameAr ?? branch.branchNameEn ?? '')
        : (branch.branchNameEn ?? branch.branchNameAr ?? '');
    final servicesText = _getFormattedServices(branch, isArabic);
    return '$branchName$servicesText';
  }

  void _handleInitialValue(
      TextEditingController controller,
      BranchModel? initialValue,
      bool isArabic
      ) {
    if (initialValue != null && controller.text.isEmpty) {
      controller.text = _getDisplayString(initialValue, isArabic);
    }
  }

  Widget _buildSearchField(
      BuildContext context,
      TextEditingController controller,
      FocusNode focusNode,
      VoidCallback onFieldSubmitted,
      ) {
    return Container(
      width: responsiveWidth(context, 904),
      height: responsiveHeight(context, 104),
      decoration: _buildSearchFieldDecoration(context),
      padding: EdgeInsets.symmetric(horizontal: responsiveWidth(context, 27)),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          suffixIcon: const Icon(
            Icons.keyboard_arrow_down_sharp,
            color: Colors.white,
          ),
          hintText: AppStrings(context: context).chooseValue,
          hintStyle: Styles(context: context).hintTextColor_w400_30,
          border: InputBorder.none,
        ),
        style: Styles(context: context).textWhiteColor_w400_30,
      ),
    );
  }

  Widget _buildOptionsView(
      BuildContext context,
      Iterable<BranchModel> options,
      AutocompleteOnSelected<BranchModel> onSelected,
      bool isArabic,
      ) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        child: Container(
          width: responsiveWidth(context, 904),
          constraints: BoxConstraints(
            maxHeight: responsiveHeight(context, 443),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(responsiveFont(context, 8)),
            boxShadow: [
              BoxShadow(
                color: AppColors.buttonColor,
                blurRadius: 20,
                spreadRadius: 0,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(responsiveFont(context, 8)),
            child: Container(
              color: AppColors.primaryColor,
              padding: EdgeInsets.symmetric(
                horizontal: responsiveWidth(context, 8),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final option = options.elementAt(index);
                  return _buildBranchItem(
                    context,
                    option,
                    isArabic,
                        () => onSelected(option),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBranchItem(
      BuildContext context,
      BranchModel branch,
      bool isArabic,
      VoidCallback onTap,
      ) {
    return ListTile(
      title: Text(
        _getDisplayString(branch, isArabic),
        style: Styles(context: context).textWhiteColor_w400_30,
      ),
      onTap: onTap,
    );
  }

  Widget _buildLoadingWidget(BuildContext context) {
    return Container(
      width: responsiveWidth(context, 904),
      height: responsiveHeight(context, 104),
      decoration: _buildSearchFieldDecoration(context),
      padding: EdgeInsets.symmetric(horizontal: responsiveWidth(context, 27)),
      child: const Center(
        child: CircularProgressIndicator(color: AppColors.textWhiteColor),
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, String message) {
    return Container(
      width: responsiveWidth(context, 904),
      height: responsiveHeight(context, 104),
      decoration: _buildSearchFieldDecoration(context),
      padding: EdgeInsets.symmetric(horizontal: responsiveWidth(context, 27)),
      child: Center(
        child: Text(
          message,
          style: Styles(context: context).textWhiteColor_w400_30,
        ),
      ),
    );
  }

  String _getFormattedServices(BranchModel branch, bool isArabic) {
    if (branch.services == null || branch.services!.isEmpty) return '';

    final serviceNames = branch.services!
        .map(
          (service) => isArabic
          ? (service.nameAr ?? service.nameEn ?? '')
          : (service.nameEn ?? service.nameAr ?? ''),
    )
        .where((name) => name.isNotEmpty)
        .join(' And ');

    return serviceNames.isNotEmpty ? ' ($serviceNames)' : '';
  }

  BoxDecoration _buildSearchFieldDecoration(BuildContext context) {
    return BoxDecoration(
      border: Border.all(
        width: responsiveWidth(context, 0.8),
        color: AppColors.textWhiteColor,
      ),
      borderRadius: BorderRadius.circular(responsiveFont(context, 6)),
    );
  }
}