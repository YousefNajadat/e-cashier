part of 'branch_bloc.dart';

@immutable
sealed class BranchEvent {}
// Events

class LoadBranches extends BranchEvent {
  @override
  List<Object> get props => [];
}
