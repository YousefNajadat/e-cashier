import '../../domain/entities/service.dart';

class ServiceModel extends Service {
  ServiceModel({
    required int id,
    String? nameEn,
    String? nameAr,
  }) : super(
    id: id,
    nameEn: nameEn,
    nameAr: nameAr,
  );

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      nameEn: json['nameEn'],
      nameAr: json['nameAr'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameEn': nameEn,
      'nameAr': nameAr,
    };
  }
}