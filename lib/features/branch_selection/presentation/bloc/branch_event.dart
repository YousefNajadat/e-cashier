part of 'branch_bloc.dart';

@immutable
sealed class BranchEvent {}

class LoadBranches extends BranchEvent {
  @override
  List<Object> get props => [];
}

class RegisterKiosk extends BranchEvent {
  final int branchId;

  RegisterKiosk(this.branchId);

  @override
  List<Object> get props => [branchId];
}