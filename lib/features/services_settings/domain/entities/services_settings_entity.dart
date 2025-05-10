import '../../data/models/services_settings_response.dart';

class ServicesSettingsEntity {
  int? branchId;
  String? branchNameAr;
  String? branchNameEn;
  List<ServicesEntity>? services;

  ServicesSettingsEntity({
    this.branchId,
    this.branchNameAr,
    this.branchNameEn,
    this.services,
  });

  factory ServicesSettingsEntity.fromResponse(ServicesSettingsResponse response) {
    return ServicesSettingsEntity(
      branchId: response.branchId,
      branchNameAr: response.branchNameAr,
      branchNameEn: response.branchNameEn,
      services: response.services?.map((serviceResponse) =>
          ServicesEntity.fromResponse(serviceResponse)
      ).toList(),
    );
  }
}

class ServicesEntity {
  int? serviceId;
  String? serviceNameEn;
  String? serviceNameAr;
  bool? isEnabled;

  ServicesEntity({
    this.serviceId,
    this.serviceNameEn,
    this.serviceNameAr,
    this.isEnabled,
  });

  factory ServicesEntity.fromResponse(ServicesResponse response) {
    return ServicesEntity(
      serviceId: response.serviceId,
      isEnabled: response.isEnabled,
      serviceNameAr: response.serviceNameAr,
      serviceNameEn: response.serviceNameEn,
    );
  }
}
