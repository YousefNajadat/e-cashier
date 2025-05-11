part of 'update_branch_service_status_bloc.dart';

@immutable
sealed class UpdateBranchServiceStatusState {}

final class UpdateBranchServiceStatusInitial extends UpdateBranchServiceStatusState {
  @override
  List<Object> get props => [];
}

class UpdateBranchServiceStatusLoading extends UpdateBranchServiceStatusState {
  @override
  List<Object> get props => [];
}

final class UpdateBranchServiceStatusSuccess extends UpdateBranchServiceStatusState {
  final UpdateBranchServiceStatusEntity responseData;

  UpdateBranchServiceStatusSuccess({required this.responseData});

  @override
  List<Object> get props => [responseData];
}

class UpdateBranchServiceStatusError extends UpdateBranchServiceStatusState {
  final String message;

  UpdateBranchServiceStatusError(this.message);

  @override
  List<Object> get props => [message];
}
