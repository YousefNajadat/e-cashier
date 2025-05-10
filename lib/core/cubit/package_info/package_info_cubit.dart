import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
part 'package_info_state.dart';

class PackageInfoCubit extends Cubit<PackageInfoState> {
  PackageInfoCubit() : super(PackageInfoInitial());

  Future<void> getPackageInfo() async {
    try {
      emit(PackageInfoLoading());
      final packageInfo = await PackageInfo.fromPlatform();
      emit(PackageInfoLoaded(packageInfo));
    } catch (e) {
      emit(PackageInfoError(e.toString()));
      debugPrint('Failed to get package info: $e');
    }
  }
}
