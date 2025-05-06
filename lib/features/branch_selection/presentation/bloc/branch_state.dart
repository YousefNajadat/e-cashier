part of 'branch_bloc.dart';

@immutable
sealed class BranchState {}

class BranchInitial extends BranchState {
  @override
  List<Object> get props => [];
}

class BranchLoading extends BranchState {
  @override
  List<Object> get props => [];
}

class BranchLoaded extends BranchState {
  final List<BranchModel> branches;
  final List<BranchModel> filteredBranches;

   BranchLoaded(this.branches, this.filteredBranches);

  @override
  List<Object> get props => [branches, filteredBranches];
}

class BranchError extends BranchState {
  final String message;

   BranchError(this.message);

  @override
  List<Object> get props => [message];
}
