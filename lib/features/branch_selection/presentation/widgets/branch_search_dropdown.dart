import 'package:e_cashier/core/constant/colors.dart';
import 'package:e_cashier/core/utils/styles.dart';
import 'package:e_cashier/core/utils/app_strings.dart';
import 'package:e_cashier/core/utils/responsive_size_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final LayerLink _layerLink = LayerLink();
  final ScrollController _scrollController = ScrollController();
  OverlayEntry? _overlayEntry;
  BranchModel? _selectedBranch;
  List<BranchModel> branches = [];
  bool isArabic = false;
  final FocusNode _focusNode = FocusNode(); // Added focus node

  @override
  void initState() {
    super.initState();
    _initialize();
    _focusNode.addListener(_handleFocusChange); // Listen to focus changes
  }

  @override
  void dispose() {
    _cleanUp();
    _focusNode.dispose(); // Dispose focus node
    super.dispose();
  }

  void _handleFocusChange() {
    if (!_focusNode.hasFocus && _overlayEntry != null) {
      _removeOverlay();
    }
  }

  void _initialize() {
    isArabic =
        context.read<TranslationCubit>().state.currentLocale.languageCode ==
        'ar';
    _selectedBranch = widget.initialValue;
    context.read<BranchBloc>().add(LoadBranches());
  }

  void _cleanUp() {
    _searchController.dispose();
    _scrollController.dispose();
    _removeOverlay();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showOverlay(BuildContext context, List<BranchModel> branches) {
    if (_overlayEntry != null) return;

    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => _buildOverlayContent(context, branches, size),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  Widget _buildOverlayContent(
    BuildContext context,
    List<BranchModel> branches,
    Size size,
  ) {
    return Stack(
      children: [
        // This invisible GestureDetector covers the entire screen behind the overlay
        Positioned.fill(
          child: GestureDetector(
            onTap: _removeOverlay,
            behavior: HitTestBehavior.translucent,
          ),
        ),
        Positioned(
          width: responsiveWidth(context, 904),
          height: responsiveHeight(context, 443),
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, size.height + 5),
            child: Material(
              borderRadius: BorderRadius.circular(responsiveFont(context, 8)),
              color: Colors.transparent,
              elevation: 0,
              child: Container(
                decoration: _buildOverlayDecoration(context),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    responsiveFont(context, 8),
                  ),
                  child: Container(
                    width: responsiveWidth(context, 896),
                    height: responsiveHeight(context, 104),
                    color: AppColors.primaryColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: responsiveWidth(context, 8),
                    ),
                    child: Theme(
                      data: _buildScrollbarTheme(context),
                      child: Scrollbar(
                        controller: _scrollController,
                        thumbVisibility: true,
                        trackVisibility: true,
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: responsiveWidth(context, 8),
                          ),
                          child: ListView.builder(
                            controller: _scrollController,
                            padding: EdgeInsets.zero,
                            itemCount: branches.length,
                            itemBuilder:
                                (context, index) =>
                                    _buildBranchItem(context, branches[index]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  BoxDecoration _buildOverlayDecoration(BuildContext context) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(responsiveFont(context, 8)),
      boxShadow: [
        BoxShadow(
          color: const Color(0x1AFFFFFF),
          blurRadius: 20,
          spreadRadius: 0,
          offset: const Offset(0, 0),
        ),
      ],
    );
  }

  ThemeData _buildScrollbarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: MaterialStateProperty.all(const Color(0xFFF5F5F5)),
        trackColor: MaterialStateProperty.all(const Color(0x1AFFFFFF)),
        thickness: MaterialStateProperty.all(responsiveWidth(context, 16)),
        radius: Radius.circular(responsiveFont(context, 11)),
        minThumbLength: responsiveHeight(context, 235),
      ),
    );
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

  void _selectBranch(BranchModel branch, String branchName) {
    setState(() {
      _selectedBranch = branch;
      _searchController.text = branchName;
      widget.onChanged?.call(branch);
    });
    _removeOverlay();
  }

  List<BranchModel> _filterBranches(String searchText) {
    if (searchText.isEmpty) return branches;

    return branches.where((branch) {
      return (branch.branchNameAr?.toLowerCase().contains(
                searchText.toLowerCase(),
              ) ??
              false) ||
          (branch.branchNameEn?.toLowerCase().contains(
                searchText.toLowerCase(),
              ) ??
              false);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: BlocBuilder<BranchBloc, BranchState>(
        builder: (context, state) {
          if (state is BranchLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is BranchError) {
            return Center(child: Text(state.message));
          }
          if (state is BranchSuccess) {
            branches = state.responseData;
            if (branches.isEmpty) {
              return const Center(child: Text('No branches found'));
            }
            return _buildSearchField(context);
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(_focusNode);
        _toggleOverlay();
      },
      child: Container(
        width: responsiveWidth(context, 904),
        height: responsiveHeight(context, 104),
        decoration: _buildSearchFieldDecoration(context),
        padding: EdgeInsets.symmetric(horizontal: responsiveWidth(context, 27)),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: _buildInputDecoration(context),
                onChanged: (value) => _handleSearchChange(value),
                focusNode: _focusNode, // Assign focus node
                style: Styles(context: context).textWhiteColor_w400_30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildSearchFieldDecoration(BuildContext context) {
    return BoxDecoration(
      border: Border.all(
        width: responsiveWidth(context, 0.8),
        color: const Color(0xFFF5F5F5),
      ),
      borderRadius: BorderRadius.circular(responsiveFont(context, 8)),
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context) {
    return InputDecoration(
      suffixIcon: InkWell(
        onTap: () {
          if (_overlayEntry == null) {
            _showOverlay(context, _filterBranches(_searchController.text));
          } else {
            _removeOverlay();
          }
        },
        child: const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.white),
      ),
      hintText: AppStrings(context: context).chooseValue,
      hintStyle: Styles(context: context).hintTextColor_w400_30,
      border: InputBorder.none,
    );
  }

  void _toggleOverlay() {
    if (_overlayEntry == null) {
      _showOverlay(context, _filterBranches(_searchController.text));
    } else {
      _removeOverlay();
    }
  }

  void _handleSearchChange(String value) {
    _removeOverlay();
    _showOverlay(context, _filterBranches(value));
  }
}
