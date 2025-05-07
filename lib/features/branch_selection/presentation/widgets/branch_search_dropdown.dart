import 'package:e_cashier/core/constant/colors.dart';
import 'package:e_cashier/core/utils/styles.dart';
import 'package:e_cashier/core/utils/app_strings.dart';
import 'package:e_cashier/core/utils/responsive_size_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../data/models/branch_model.dart';
import '../bloc/branch_bloc.dart';
import '../cubit/translation/translation_cubit.dart';

class BranchSearchDropdown extends StatefulWidget {
  final ValueChanged<BranchModel?>? onChanged;
  final BranchModel? initialValue;

  const BranchSearchDropdown({Key? key, this.onChanged, this.initialValue})
    : super(key: key);

  @override
  State<BranchSearchDropdown> createState() => _BranchSearchDropdownState();
}

class _BranchSearchDropdownState extends State<BranchSearchDropdown> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  BranchModel? _selectedBranch;
  List<BranchModel> branches = [];
  List<BranchModel> filterBranches = [];
  bool isArabic = false;
  final FocusNode _focusNode = FocusNode();
  bool _isDropdownOpen = false;

  @override
  void initState() {
    super.initState();
    _initialize();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (!_focusNode.hasFocus && _isDropdownOpen) {
      setState(() {
        _isDropdownOpen = false;
      });
    }
  }

  void _initialize() {
    isArabic =
        context.read<TranslationCubit>().state.currentLocale.languageCode ==
        'ar';
    _selectedBranch = widget.initialValue;
    context.read<BranchBloc>().add(LoadBranches());
  }

  void _selectBranch(BranchModel branch, String branchName) {
    setState(() {
      _selectedBranch = branch;
      _searchController.text = branchName;
      _isDropdownOpen = false;
    });
    widget.onChanged?.call(branch);
  }

  void _handleSearchChange(String value) {
    setState(() {
      _filterBranches(searchText: value);
    });
  }

  List<BranchModel> _filterBranches({String searchText = ''}) {
    if (searchText.isEmpty) {
      setState(() {
        filterBranches = branches;
      });
      return filterBranches;
    }
    setState(() {
      filterBranches =
          branches.where((branch) {
            return (branch.branchNameAr?.toLowerCase().contains(
                      searchText.toLowerCase(),
                    ) ??
                    false) ||
                (branch.branchNameEn?.toLowerCase().contains(
                      searchText.toLowerCase(),
                    ) ??
                    false);
          }).toList();
    });
    return filterBranches;
  }

  String _getLocalizedBranchName(BranchModel branch) {
    return isArabic
        ? (branch.branchNameAr ?? branch.branchNameEn ?? '')
        : (branch.branchNameEn ?? branch.branchNameAr ?? '');
  }

  String _getFormattedServices(BranchModel branch) {
    if (branch.services == null || branch.services!.isEmpty) return '';

    final serviceNames = branch.services!
        .map(
          (service) =>
              isArabic
                  ? (service.nameAr ?? service.nameEn ?? '')
                  : (service.nameEn ?? service.nameAr ?? ''),
        )
        .where((name) => name.isNotEmpty)
        .join(' And ');

    return serviceNames.isNotEmpty ? ' ($serviceNames)' : '';
  }

  Widget _buildBranchItem(BuildContext context, BranchModel branch) {
    final branchName = _getLocalizedBranchName(branch);
    final servicesText = _getFormattedServices(branch);

    return ListTile(
      title: Text(
        '$branchName$servicesText',
        style: Styles(context: context).textWhiteColor_w400_30,
      ),
      onTap: () {
        _selectBranch(branch, '$branchName$servicesText');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BranchBloc, BranchState>(
      builder: (context, state) {
        if (state is BranchLoading) {
          return loadingWidget(context);
        }
        if (state is BranchError) {
          return Center(child: Text(state.message));
        }
        if (state is BranchSuccess) {
          branches = state.responseData;
          // filterBranches = state.responseData;
          if (branches.isEmpty) {
            return const Center(child: Text('No branches found'));
          }
          return Column(
            children: [
              _buildSearchField(context),
              if (_isDropdownOpen) ...[
                Gap(responsiveHeight(context, 16)),
                _buildDropDown(context, filterBranches),
              ],
            ],
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildDropDown(
    BuildContext context,
    List<BranchModel> filterBranches,
  ) {
    var height = responsiveHeight(context, 120) * filterBranches.length;
    return SizedBox(
      width: responsiveWidth(context, 904),
      height:
          height <= responsiveHeight(context, 443)
              ? height
              : responsiveHeight(context, 443),
      child: Container(
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
            width: responsiveWidth(context, 896),
            height: responsiveHeight(context, 104),
            color: AppColors.primaryColor,
            padding: EdgeInsets.symmetric(
              horizontal: responsiveWidth(context, 8),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                scrollbarTheme: ScrollbarThemeData(
                  thumbColor: MaterialStateProperty.all(
                    AppColors.textWhiteColor,
                  ),
                  trackColor: MaterialStateProperty.all(
                    AppColors.buttonColor,
                  ),
                  thickness: MaterialStateProperty.all(
                    responsiveWidth(context, 16),
                  ),
                  radius: Radius.circular(responsiveFont(context, 11)),
                  minThumbLength: responsiveHeight(context, 235),
                ),
              ),
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                trackVisibility: true,
                child: Padding(
                  padding: EdgeInsets.only(right: responsiveWidth(context, 8)),
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.zero,
                    itemCount: filterBranches.length,
                    itemBuilder:
                        (context, index) =>
                            _buildBranchItem(context, filterBranches[index]),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loadingWidget(BuildContext context) {
    return Container(
      width: responsiveWidth(context, 904),
      height: responsiveHeight(context, 104),
      decoration: _buildSearchFieldDecoration(context),
      padding: EdgeInsets.symmetric(horizontal: responsiveWidth(context, 27)),
      child: Stack(
        children: [
          TextField(
            readOnly: true,
            decoration: InputDecoration(
              suffixIcon: const Icon(
                Icons.keyboard_arrow_down_sharp,
                color: Colors.white,
              ),
              border: InputBorder.none,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: responsiveHeight(context, 50),
              width: responsiveHeight(context, 50),
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(_focusNode);
        setState(() {
          _isDropdownOpen = !_isDropdownOpen;
        });
      },
      child: Container(
        width: responsiveWidth(context, 904),
        height: responsiveHeight(context, 104),
        decoration: _buildSearchFieldDecoration(context),
        padding: EdgeInsets.symmetric(horizontal: responsiveWidth(context, 27)),
        child: TextField(
          controller: _searchController,
          onTap: () {
            setState(() {
              _isDropdownOpen = true;
            });
            _handleSearchChange(_searchController.text.split('(')[0].trim());
          },
          decoration: InputDecoration(
            suffixIcon: InkWell(
              onTap: () {
                _handleSearchChange(
                  _searchController.text.split('(')[0].trim(),
                );
                setState(() {
                  _isDropdownOpen = !_isDropdownOpen;
                });
              },
              child: Icon(Icons.keyboard_arrow_down_sharp, color: Colors.white),
            ),
            hintText: AppStrings(context: context).chooseValue,
            hintStyle: Styles(context: context).hintTextColor_w400_30,
            border: InputBorder.none,
          ),
          onChanged: (value) => _handleSearchChange(value),
          focusNode: _focusNode,
          style: Styles(context: context).textWhiteColor_w400_30,
        ),
      ),
    );
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
