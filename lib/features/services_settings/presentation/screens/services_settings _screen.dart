import 'package:e_cashier/core/constant/colors.dart';
import 'package:e_cashier/core/utils/app_strings.dart';
import 'package:e_cashier/core/utils/app_texts.dart';
import 'package:e_cashier/core/utils/responsive_size_helper.dart';
import 'package:e_cashier/core/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../core/constant/icons_path.dart';
import '../../../../core/cubit/translation/translation_cubit.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/utils/Styles.dart';
import '../../../../core/widgets/app_background_scaffold.dart';
import '../../../../core/widgets/floating_action_button.dart';
import '../../domain/entities/services_settings_entity.dart';
import '../../domain/params/services_settings_parameters.dart';
import '../bloc/services_settings_bloc.dart';

class ServicesSettingsScreen extends StatelessWidget {
  const ServicesSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final branchId = context.read<BranchCubit>().state.currentBranch;
    return BlocProvider(
      create:
          (_) => ServicesSettingsBloc(getIt())..add(
            GetServicesSettingsEvent(
              parameters: ServicesSettingsParameters(branchId: '1'),
            ),
          ),
      child: AppBackgroundScaffold(
        padding: EdgeInsets.symmetric(horizontal: responsiveWidth(context, 48)),
        isDrawerWidget: true,
        floatingActionButton: buildFloatingActionButton(
          showLeadingButton: true,
          leadingButtonText: AppStrings(context: context).back,
          context,
          text: AppStrings(context: context).confirm,
          onPressed: () {
            // context.pushAndRemoveUntil(ChangeLanguageScreen());
          },
        ),
        child: BlocBuilder<ServicesSettingsBloc, ServicesSettingsState>(
          builder: (context, state) {
            if (state is ServicesSettingsLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is ServicesSettingsError) {
              return _buildErrorWidget(context, state.message);
            }

            if (state is ServicesSettingsSuccess) {
              return settingsListView(context, state.responseData.services);
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget settingsListView(
    BuildContext context,
    List<ServicesEntity>? services,
  ) {
    return ListView.separated(
      itemCount: services?.length ?? 0,
      separatorBuilder:
          (context, index) => Column(
            children: [
              Gap(responsiveHeight(context, 40)),
              Divider(
                color: AppColors.dividerColor,
                height: responsiveHeight(context, 0.4),
              ),
              Gap(responsiveHeight(context, 40)),
            ],
          ),
      itemBuilder:
          (context, index) => settingsWidgets(context, index, services),
    );
  }

  Widget settingsWidgets(
    BuildContext context,
    int index,
    List<ServicesEntity>? services,
  ) {
    final isArabic =
        context.read<TranslationCubit>().state.currentLocale.languageCode ==
        'ar';
    var text =
        services == null
            ? ''
            : isArabic
            ? (services[index].serviceNameAr) ?? ''
            : (services[index].serviceNameEn) ?? '';
    var value = (services?[index].isEnabled) ?? false;
    return services == null
        ? const SizedBox()
        : Container(
          height: responsiveHeight(context, 100),
          child: Row(
            children: [
              imageWidget(context, getIcon(services[index].serviceNameEn?.toLowerCase().replaceAll(' ', '',) ?? '',), 100, 100),
              Gap(responsiveWidth(context, 24)),
              AppTexts(
                context: context,
                text: text ?? '',
              ).textWhiteColor_w500_32,
              Spacer(),
              Switch(
                // This bool value toggles the switch.
                value:value,
                activeColor: Colors.red,
                onChanged: (bool val) {
                  value = val;
                },
              ),
            ],
          ),
        );
  }

  String getIcon(String text) {
    switch (text) {
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

  Widget _buildErrorWidget(BuildContext context, String message) {
    return Container(
      width: responsiveWidth(context, 904),
      height: responsiveHeight(context, 104),
      // decoration: _buildSearchFieldDecoration(context),
      padding: EdgeInsets.symmetric(horizontal: responsiveWidth(context, 27)),
      child: Center(
        child: Text(
          message,
          style: Styles(context: context).textWhiteColor_w400_30,
        ),
      ),
    );
  }
}
