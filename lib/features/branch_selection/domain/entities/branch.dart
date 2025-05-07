import 'package:e_cashier/features/branch_selection/domain/entities/service.dart';

class Branch {
  final int? id;
  final String? branchNameAr;
  final String? branchNameEn;
  final List<Service>? services;

  Branch({
     this.id,
    this.branchNameAr,
    this.branchNameEn,
    this.services,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Branch && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}