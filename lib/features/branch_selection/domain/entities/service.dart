class Service {
  final int id;
  final String? nameEn;
  final String? nameAr;

  Service({
    required this.id,
    this.nameEn,
    this.nameAr,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Service && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}