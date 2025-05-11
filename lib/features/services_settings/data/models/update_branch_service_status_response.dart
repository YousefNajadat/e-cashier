class UpdateBranchServiceStatusResponse {
  bool? success;
  String? message;


  UpdateBranchServiceStatusResponse({
    this.success, this.message
  });

  UpdateBranchServiceStatusResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }
}
