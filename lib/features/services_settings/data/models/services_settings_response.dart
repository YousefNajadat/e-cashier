class ServicesSettingsResponse {
  int? branchId;
  String? branchNameAr;
  String? branchNameEn;
  List<ServicesResponse>? services;

  ServicesSettingsResponse({
    this.branchId,
    this.branchNameAr,
    this.branchNameEn,
    this.services,
  });

  ServicesSettingsResponse.fromJson(Map<String, dynamic> json) {
    branchId = json['branchId'];
    branchNameAr = json['branchNameAr'];
    branchNameEn = json['branchNameEn'];
    if (json['services'] != null) {
      services = <ServicesResponse>[];
      json['services'].forEach((v) {
        services!.add(ServicesResponse.fromJson(v));
      });
    }
  }
}

class ServicesResponse {
  int? serviceId;
  String? serviceNameEn;
  String? serviceNameAr;
  bool? isEnabled;

  ServicesResponse({
    this.serviceId,
    this.serviceNameEn,
    this.serviceNameAr,
    this.isEnabled,
  });

  ServicesResponse.fromJson(Map<String, dynamic> json) {
    serviceId = json['serviceId'];
    serviceNameEn = json['serviceNameEn'];
    serviceNameAr = json['serviceNameAr'];
    isEnabled = json['isEnabled'];
  }
}
