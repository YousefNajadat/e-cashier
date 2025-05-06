import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/branch_model.dart';
import '../../domain/entities/service.dart';

part 'branch_event.dart';

part 'branch_state.dart';

// BLoC
class BranchBloc extends Bloc<BranchEvent, BranchState> {
  BranchBloc() : super(BranchInitial()) {
    on<LoadBranches>(_onLoadBranches);
    on<SearchBranches>(_onSearchBranches);
  }

  Future<void> _onLoadBranches(
    LoadBranches event,
    Emitter<BranchState> emit,
  ) async {
    emit(BranchLoading());
    try {
      // Replace this with your actual data fetching logic
      final branches = await _fetchBranches();
      emit(BranchLoaded(branches, branches));
    } catch (e) {
      emit(BranchError(e.toString()));
    }
  }

  Future<void> _onSearchBranches(
    SearchBranches event,
    Emitter<BranchState> emit,
  ) async {
    if (state is BranchLoaded) {
      final currentState = state as BranchLoaded;
      if (event.query.isEmpty) {
        emit(currentState.copyWith(filteredBranches: currentState.branches));
      } else {
        final filtered =
            currentState.branches.where((branch) {
              return branch.branchNameEn?.toLowerCase().contains(
                        event.query.toLowerCase(),
                      ) ==
                      true ||
                  branch.branchNameAr?.toLowerCase().contains(
                        event.query.toLowerCase(),
                      ) ==
                      true;
            }).toList();
        emit(currentState.copyWith(filteredBranches: filtered));
      }
    }
  }

  Future<List<BranchModel>> _fetchBranches() async {
    // Mock data - replace with your API call
    await Future.delayed(const Duration(seconds: 1));
    return [
      BranchModel(
        id: 1,
        branchNameEn: "Main Branch",
        branchNameAr: "الفرع الرئيسي",
        services: [
          Service(id: 1, nameEn: "Service 1", nameAr: "خدمة 1"),
          Service(id: 2, nameEn: "Service 2", nameAr: "خدمة 2"),
        ],
      ),
      BranchModel(
        id: 2,
        branchNameEn: "North Branch",
        branchNameAr: "فرع الشمال",
        services: [Service(id: 3, nameEn: "Service 3", nameAr: "خدمة 3")],
      ),
    ];
  }
}

extension BranchLoadedExtension on BranchLoaded {
  BranchLoaded copyWith({
    List<BranchModel>? branches,
    List<BranchModel>? filteredBranches,
  }) {
    return BranchLoaded(
      branches ?? this.branches,
      filteredBranches ?? this.filteredBranches,
    );
  }
}
