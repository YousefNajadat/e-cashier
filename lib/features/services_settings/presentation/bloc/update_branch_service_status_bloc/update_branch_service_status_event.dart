part of 'update_branch_service_status_bloc.dart';

@immutable
sealed class UpdateBranchServiceStatusEvent {
  const UpdateBranchServiceStatusEvent();

  @override
  List<Object> get props => [];
}

class UpdateBranchServiceStatus extends UpdateBranchServiceStatusEvent {
  final UpdateBranchServiceStatusParameters parameters;

  const UpdateBranchServiceStatus({required this.parameters});
}