class UpdateBranchServiceStatusParameters {
  final String branchId;
  final int serviceId;
  final bool isEnabled;

  const UpdateBranchServiceStatusParameters({
    required this.serviceId,
    required this.isEnabled,
    required this.branchId,
  });

  Map<String, dynamic> toJson() => {
    "branchId": branchId,
    "serviceId": serviceId,
    "isEnabled": isEnabled,
  };
}
