import '../../domain/entities/branch.dart';
import '../../domain/entities/service.dart';
import 'service_model.dart';

class BranchModel extends Branch {
  BranchModel({
    int? id,
    String? branchNameAr,
    String? branchNameEn,
    List<Service>? services,
  }) : super(
    id: id,
    branchNameAr: branchNameAr,
    branchNameEn: branchNameEn,
    services: services,
  );

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      id: json['id'],
      branchNameAr: json['branchNameAr'],
      branchNameEn: json['branchNameEn'],
      services: json['services'] != null
          ? (json['services'] as List)
          .map((service) => ServiceModel.fromJson(service))
          .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'branchNameAr': branchNameAr,
      'branchNameEn': branchNameEn,
      'services': services?.map((service) {
        if (service is ServiceModel) {
          return service.toJson();
        }
        return ServiceModel(id: service.id, nameEn: service.nameEn, nameAr: service.nameAr).toJson();
      }).toList(),
    };
  }
}