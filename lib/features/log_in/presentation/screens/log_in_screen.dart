import 'package:e_cashier/core/data/local/storage_helper.dart';
import 'package:e_cashier/core/utils/app_strings.dart';
import 'package:e_cashier/core/utils/extensions/context_extension.dart';
import 'package:e_cashier/core/utils/responsive_size_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../core/widgets/app_background_scaffold.dart';
import '../../../../core/widgets/custom_text__form_field.dart';
import '../../../../core/widgets/floating_action_button.dart';
import '../../../setting/presentation/screens/setting_screen.dart';
import '../../domain/params/log_in_parameters.dart';
import '../bloc/log_in_bloc.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  TextEditingController employeeNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogInBloc, LogInState>(
      listener: (context, state) {
        if (state is LogInError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is LogInSuccess) {
          StorageHelper.setAccessToken(state.responseData.accessToken);
          StorageHelper.setPermissions(
            state.responseData.permissions.accessLogOut,
          );
          // navigate to settings screen
          context.pushAndRemoveUntil(SettingScreen());
        } else {
          print('no state');
        }
      },
      builder:
          (context, state) => Form(
            key: _formKey,
            child: AppBackgroundScaffold(
              padding: EdgeInsets.symmetric(
                horizontal: responsiveWidth(context, 171),
              ),
              floatingActionButton: buildFloatingActionButton(
                context,
                isLoading: state is LogInLoading,
                text: AppStrings(context: context).confirm,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<LogInBloc>().add(
                      PostLogInEvent(
                        LogInParameters(
                          username: employeeNumberController.text,
                          password: passwordController.text,
                        ),
                      ),
                    );
                  }
                },
              ),
              isDrawerWidget: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gap(responsiveHeight(context, 64)),
                  CustomTextFormField(
                    textInputAction: TextInputAction.next,
                    controller: employeeNumberController,
                    labelText: AppStrings(context: context).employeeNumber,
                    hintText:
                        AppStrings(context: context).enter_employee_number,
                    isRequired: true,
                  ),
                  Gap(responsiveHeight(context, 56)),
                  CustomTextFormField(
                    controller: passwordController,
                    labelText: AppStrings(context: context).password,
                    hintText: AppStrings(context: context).enter_password,
                    isRequired: true,
                    isPassword: true,
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
