import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/branch_model.dart';
import '../bloc/branch_bloc.dart';


class BranchSearchDropdown extends StatefulWidget {
  final ValueChanged<BranchModel?>? onChanged;
  final BranchModel? initialValue;

  const BranchSearchDropdown({
    Key? key,
    this.onChanged,
    this.initialValue,
  }) : super(key: key);

  @override
  _BranchSearchDropdownState createState() => _BranchSearchDropdownState();
}

class _BranchSearchDropdownState extends State<BranchSearchDropdown> {
  final TextEditingController _searchController = TextEditingController();
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  BranchModel? _selectedBranch;

  @override
  void initState() {
    super.initState();
    _selectedBranch = widget.initialValue;
    context.read<BranchBloc>().add(LoadBranches());
  }

  @override
  void dispose() {
    _searchController.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showOverlay(BuildContext context) {
    if (_overlayEntry != null) return;

    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: 904,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 5),
          child: Material(
            elevation: 4,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: BlocBuilder<BranchBloc, BranchState>(
                builder: (context, state) {
                  if (state is BranchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is BranchError) {
                    return Center(child: Text(state.message));
                  } else if (state is BranchLoaded) {
                    final branches = state.filteredBranches;
                    if (branches.isEmpty) {
                      return const Center(child: Text('No branches found'));
                    }
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: branches.length,
                      itemBuilder: (context, index) {
                        final branch = branches[index];
                        return ListTile(
                          title: Text(branch.branchNameEn ?? ''),
                          subtitle: branch.branchNameAr != null
                              ? Text(branch.branchNameAr!)
                              : null,
                          onTap: () {
                            setState(() {
                              _selectedBranch = branch;
                              _searchController.text = branch.branchNameEn ?? '';
                              widget.onChanged?.call(branch);
                            });
                            _removeOverlay();
                          },
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: () {
          if (_overlayEntry == null) {
            _showOverlay(context);
          } else {
            _removeOverlay();
          }
        },
        child: Container(
          width: 904,
          height: 104,
          decoration: BoxDecoration(
            border: Border.all(width: 0.8, color: const Color(0xFFF5F5F5)),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Choose Value',
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    context.read<BranchBloc>().add(SearchBranches(value));
                  },
                  onTap: () {
                    if (_overlayEntry == null) {
                      _showOverlay(context);
                    }
                  },
                ),
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }
}