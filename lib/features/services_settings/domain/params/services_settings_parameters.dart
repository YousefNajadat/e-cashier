class ServicesSettingsParameters {
  final String branchId;

  const ServicesSettingsParameters({required this.branchId});

  Map<String, dynamic> toJson() => {"branchId": branchId};
}
