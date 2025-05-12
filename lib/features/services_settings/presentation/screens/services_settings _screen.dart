import 'package:e_cashier/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/constant/app_constant.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/constant/icons_path.dart';
import '../../../../core/cubit/translation/translation_cubit.dart';
import '../../../../core/data/local/storage_helper.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/responsive_size_helper.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/app_background_scaffold.dart';
import '../../../../core/widgets/floating_action_button.dart';
import '../../../../core/widgets/image_widget.dart';
import '../../domain/entities/services_settings_entity.dart';
import '../../domain/params/services_settings_parameters.dart';
import '../../domain/params/update_branch_service_status_parameters.dart';
import '../bloc/services_settings_bloc/services_settings_bloc.dart';
import '../bloc/update_branch_service_status_bloc/update_branch_service_status_bloc.dart';

class ServicesSettingsScreen extends StatelessWidget {
  const ServicesSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final branchId = StorageHelper.getBranchId();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) =>
                  ServicesSettingsBloc(getIt())
                    ..add(GetServicesSettingsEvent()),
        ),
        BlocProvider(create: (_) => UpdateBranchServiceStatusBloc(getIt())),
      ],
      child: BlocConsumer<ServicesSettingsBloc, ServicesSettingsState>(
        listener: (context, state) {
          if (state is ServicesSettingsError) {
            // print('123');
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is ServicesSettingsError) {
            return AppBackgroundScaffold(
              padding: EdgeInsets.symmetric(
                horizontal: responsiveWidth(context, 60),
              ),
              // isDrawerWidget: true,
              floatingActionButton: BlocBuilder<
                UpdateBranchServiceStatusBloc,
                UpdateBranchServiceStatusState
              >(
                builder: (context, updateState) {
                  return buildFloatingActionButton(
                    showLeadingButton: true,
                    showTrailButton: false,
                    leadingButtonText: AppStrings(context: context).back,
                    context,
                    isLoading: updateState is UpdateBranchServiceStatusLoading,
                    text: AppStrings(context: context).back,
                    onPressed: () {
                      context.pop();
                    },
                  );
                },
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppTexts(
                    context: context,
                    text: AppStrings(context: context).invalid_branch_id,
                  ).textWhiteColor_w500_42,
                  AppTexts(
                    context: context,
                    text: AppStrings(context: context).please_go_back_and_change_branch,
                  ).textWhiteColor_w500_32,
                ],
              ),
            );
          }
          if (state is ServicesSettingsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ServicesSettingsSuccess) {
            return _buildSuccessState(context, state.responseData);
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildSuccessState(
    BuildContext context,
    ServicesSettingsEntity settings,
  ) {
    final modifiedServices =
        settings.services?.where((s) => s.isModified).toList() ?? [];

    return AppBackgroundScaffold(
      padding: EdgeInsets.symmetric(horizontal: responsiveWidth(context, 60)),
      // isDrawerWidget: true,
      floatingActionButton: BlocBuilder<
        UpdateBranchServiceStatusBloc,
        UpdateBranchServiceStatusState
      >(
        builder: (context, updateState) {
          return buildFloatingActionButton(
            showTrailButton: true,
            showLeadingButton: true,
            leadingButtonText: AppStrings(context: context).back,
            context,
            isLoading: updateState is UpdateBranchServiceStatusLoading,
            text: AppStrings(context: context).confirm,
            onPressed:
                modifiedServices.isEmpty
                    ? () {}
                    : () => _submitChanges(context, modifiedServices),
          );
        },
      ),
      child: _buildServicesList(context, settings.services),
    );
  }

  void _submitChanges(
    BuildContext context,
    List<ServicesEntity> services,
  ) async {
    final branchId = await StorageHelper.getBranchId();
    final bloc = context.read<UpdateBranchServiceStatusBloc>();

    for (final service in services) {
      bloc.add(
        UpdateBranchServiceStatus(
          parameters: UpdateBranchServiceStatusParameters(
            serviceId: service.serviceId!,
            isEnabled: service.isEnabled!,
            branchId: branchId ?? '',
          ),
        ),
      );
    }
  }

  Widget _buildServicesList(
    BuildContext context,
    List<ServicesEntity>? services,
  ) {
    if (services == null || services.isEmpty) {
      return Center(child: Text('no Services Available'));
    }

    return ListView.separated(
      itemCount: services.length,
      separatorBuilder:
          (context, index) => Column(
            children: [
              Gap(responsiveHeight(context, 40)),
              const Divider(color: AppColors.dividerColor, height: 0.4),
              Gap(responsiveHeight(context, 40)),
            ],
          ),
      itemBuilder:
          (context, index) => _buildServiceItem(context, services[index]),
    );
  }

  Widget _buildServiceItem(BuildContext context, ServicesEntity service) {
    final isArabic =
        context.read<TranslationCubit>().state.currentLocale ==
        LanguageLocalCodes.arabic;
    final name = isArabic ? service.serviceNameAr : service.serviceNameEn;
    final branchId = StorageHelper.getBranchId();

    return SizedBox(
      height: responsiveHeight(context, 100),
      child: Row(
        children: [
          imageWidget(
            context,
            _getServiceIcon(service.serviceNameEn?.toLowerCase() ?? ''),
            100,
            100,
          ),
          Gap(responsiveWidth(context, 24)),
          AppTexts(context: context, text: name ?? '').textWhiteColor_w500_32,
          const Spacer(),
          Switch(
            value: service.isEnabled ?? false,
            activeColor: AppColors.whiteColor,
            activeTrackColor: const Color(0xffCECECE),
            inactiveThumbColor: const Color(0xD9CECECE),
            inactiveTrackColor: const Color(0x33FFFFFF),
            onChanged: (bool value) {
              context.read<ServicesSettingsBloc>().add(
                UpdateServiceStatusEvent(
                  serviceId: service.serviceId.toString(),
                  isEnabled: value,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String _getServiceIcon(String serviceName) {
    final normalizedName = serviceName.toLowerCase().replaceAll(' ', '');

    switch (normalizedName) {
      case 'sparepartsorder':
        return IconsPath.spare_parts_order_icon;
      case 'serviceorder':
        return IconsPath.service_order_icon;
      case 'vehicleorder':
        return IconsPath.vehicle_order_icon;
      default:
        return IconsPath.promissory_note_icon;
    }
  }
}
