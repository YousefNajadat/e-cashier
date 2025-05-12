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

class BranchSuccess extends BranchState {
  final List<BranchModel> responseData;
  final String? branchId;

  BranchSuccess({required this.responseData, required this.branchId});

  @override
  List<Object> get props => [responseData];
}

class BranchError extends BranchState {
  final String message;

  BranchError(this.message);

  @override
  List<Object> get props => [message];
}