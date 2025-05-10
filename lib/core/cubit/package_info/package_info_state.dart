part of 'package_info_cubit.dart';

sealed class PackageInfoState {
  final PackageInfo? packageInfo;
  const PackageInfoState({this.packageInfo});
}

class PackageInfoInitial extends PackageInfoState {
  const PackageInfoInitial() : super();
}

class PackageInfoLoading extends PackageInfoState {
  const PackageInfoLoading() : super();
}

class PackageInfoLoaded extends PackageInfoState {
  const PackageInfoLoaded(PackageInfo packageInfo)
      : super(packageInfo: packageInfo);
}

class PackageInfoError extends PackageInfoState {
  final String message;
  const PackageInfoError(this.message) : super();
}