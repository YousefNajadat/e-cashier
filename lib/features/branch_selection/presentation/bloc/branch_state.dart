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

final class BranchSuccess extends BranchState {
  final List<BranchModel> responseData;

  BranchSuccess({required this.responseData});

  @override
  List<Object> get props => [responseData];
}

final class BranchError extends BranchState {
  final String message;

  BranchError(this.message);

  @override
  List<Object> get props => [message];
}
