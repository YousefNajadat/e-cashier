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

  factory ServicesSettingsEntity.fromResponse(
    ServicesSettingsResponse response,
  ) {
    return ServicesSettingsEntity(
      branchId: response.branchId,
      branchNameAr: response.branchNameAr,
      branchNameEn: response.branchNameEn,
      services:
          response.services
              ?.map(
                (serviceResponse) =>
                    ServicesEntity.fromResponse(serviceResponse),
              )
              .toList(),
    );
  }

  ServicesSettingsEntity copyWith({
    int? branchId,
    String? branchNameAr,
    String? branchNameEn,
    List<ServicesEntity>? services,
  }) {
    return ServicesSettingsEntity(
      branchId: branchId ?? this.branchId,
      branchNameAr: branchNameAr ?? this.branchNameAr,
      branchNameEn: branchNameEn ?? this.branchNameEn,
      services: services ?? this.services,
    );
  }
}

class ServicesEntity {
  int? serviceId;
  String? serviceNameEn;
  String? serviceNameAr;
  bool? isEnabled;
  bool isModified;

  ServicesEntity({
    this.serviceId,
    this.serviceNameEn,
    this.serviceNameAr,
    this.isEnabled,
    this.isModified = false,
  });

  factory ServicesEntity.fromResponse(ServicesResponse response) {
    return ServicesEntity(
      serviceId: response.serviceId,
      isEnabled: response.isEnabled,
      serviceNameAr: response.serviceNameAr,
      serviceNameEn: response.serviceNameEn,
    );
  }

  ServicesEntity copyWith({
    int? serviceId,
    String? serviceNameEn,
    String? serviceNameAr,
    bool? isEnabled,
    bool? isModified,
  }) {
    return ServicesEntity(
      serviceId: serviceId ?? this.serviceId,
      serviceNameEn: serviceNameEn ?? this.serviceNameEn,
      serviceNameAr: serviceNameAr ?? this.serviceNameAr,
      isEnabled: isEnabled ?? this.isEnabled,
      isModified: isModified ?? this.isModified,
    );
  }
}
