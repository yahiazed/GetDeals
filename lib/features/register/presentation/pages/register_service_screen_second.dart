import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getdealss/config/app_localization.dart';
import 'package:getdealss/features/register/presentation/pages/register_screen.dart';

import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../../../../core/utiles/colors/my_color.dart';
import '../../../../core/utiles/shared_widget/clip_path.dart';
import '../../../../core/utiles/shared_widget/outlined_button.dart';
import '../../../../core/utiles/shared_widget/shared_dropdown.dart';
import '../../../../core/utiles/snackbar.dart';
import '../../../../core/utiles/styles/text_style.dart';
import '../../../login/presentation/pages/login_screen.dart';
import '../cubit/register_cubit.dart';
import '../widgets/generated_row.dart';

class RegisterServiceProviderSecondScreen extends StatelessWidget {
  RegisterServiceProviderSecondScreen({super.key});
  var specializeController = TextEditingController();
  var yearsController = TextEditingController();

  var ServiceKindController = TextEditingController();
  var ServiceDescriptionController = TextEditingController();
  var formRegisterKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var digit1Controller = TextEditingController();
    var digit2Controller = TextEditingController();
    var digit3Controller = TextEditingController();
    var digit4Controller = TextEditingController();
    var digit5Controller = TextEditingController();
    var digit6Controller = TextEditingController();
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = RegisterCubit.get(context);

        return Container(
            decoration: const BoxDecoration(
              color: Colord.whit,
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/bg.png',
                  ),
                  fit: BoxFit.cover),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    ClipPath(
                      clipper: CustomClipPath(),
                      child: Container(
                        height: 400,
                        color: Colord.mainColor,
                        child: Center(
                          child: Container(
                            width: 275,
                            height: 247,
                            child: Image.asset(
                              'assets/images/log.png',
                              color: Colord.whit,
                            ),
                          ),
                        ),
                      ),
                    ),
                    cubit.notOtp2
                        ? Form(
                            key: formRegisterKey,
                            child: Container(
                              width: double.infinity,
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 35.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 34.0),
                                      child: Text(
                                        'Register As ServiceProvider'
                                            .tr(context),
                                        style: head520BlackLine(),
                                      ),
                                    ),
                                    GeneratedRowInputs(
                                        controller1: specializeController,
                                        controller2: yearsController,
                                        hint1: "Cost Per Hour",
                                        hint2: "Experience Years",
                                        textInputType1: TextInputType.name,
                                        textInputType2: TextInputType.number),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    SharedDropdown(
                                      dropdownValue: cubit.specialistList[0],
                                      values: cubit.specialistList,
                                      lable: 'التخصص',
                                      onChanged: (p0) {
                                        cubit.specialist = p0!;
                                      },
                                    ),
                                    buildExperienceDescriptionInputField(
                                        ServiceDescriptionController, context),

                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceAround,
                                    //   children: [
                                    //     buildAddProjectAttach(context),
                                    //     buildAddProjectAttach(context),
                                    //     buildAddProjectAttach(context),
                                    //   ],
                                    // ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 34.0),
                                      child: SharedOutlineButton(
                                        onPressed: () {
                                          if (formRegisterKey.currentState!
                                              .validate()) {
                                            cubit.costHour = num.parse(
                                                specializeController.text);
                                            cubit.experienceYears =
                                                int.parse(yearsController.text);

                                            cubit.serviceDescription =
                                                ServiceDescriptionController
                                                    .text;

                                            cubit.notOtp2 = false;

                                            cubit.submitPhoneNumber(
                                                cubit.phoneNumber);
                                          }
                                        },
                                        txt: "next",
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 28,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 34.0),
                                      child: TextButton(
                                        onPressed: () {
                                          cubit.userKind = 0;
                                          cubit.notOtp = true;
                                          navigateTo(
                                              context, const RegisterScreen());
                                        },
                                        child: Text(
                                          "I have a money".tr(context),
                                          style: more414blackText(),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 34.0),
                                      child: TextButton(
                                        onPressed: () {
                                          navigateTo(context, LoginScreen());
                                        },
                                        child: Text(
                                          "haveAccount".tr(context),
                                          style: more414blackText(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(
                            width: double.infinity,
                            color: Colors.transparent,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 69.0),
                                    child: Center(
                                      child: Text(
                                        'Verification Code'.tr(context),
                                        style: head520BlackLine(),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          '${'otp'.tr(context)}+966${cubit.phoneNumber}',
                                          style: txtDrawerbase516TitlesText(),
                                        ),
                                      ),
                                      Expanded(
                                        child: OutlinedButton(
                                          child: Text(
                                            'Edit Number'.tr(context),
                                            style: txt515BlackLine(),
                                          ),
                                          onPressed: () {
                                            cubit.notOtp2 = true;
                                            Navigator.pop(context);
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                  Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        buildPinDigit(
                                            controller: digit1Controller,
                                            aut: true,
                                            context: context),
                                        buildPinDigit(
                                            controller: digit2Controller,
                                            context: context),
                                        buildPinDigit(
                                            controller: digit3Controller,
                                            context: context),
                                        buildPinDigit(
                                            controller: digit4Controller,
                                            context: context),
                                        buildPinDigit(
                                            controller: digit5Controller,
                                            context: context),
                                        buildPinDigit(
                                            controller: digit6Controller,
                                            c: TextInputAction.done,
                                            context: context),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 34.0, vertical: 38.0),
                                    child: SharedOutlineButton(
                                      onPressed: () {
                                        String otpCode = digit1Controller.text +
                                            digit2Controller.text +
                                            digit3Controller.text +
                                            digit4Controller.text +
                                            digit5Controller.text +
                                            digit6Controller.text;

                                        cubit.submitOTP(otpCode).then((value) {
                                          cubit.createNewServiceProvider();
                                        });
                                      },
                                      txt: "next",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ));
      },
    );
  }

  Container buildExperienceDescriptionInputField(
      TextEditingController ServiceDescriptionController,
      BuildContext context) {
    return Container(
        height: 121,
        margin: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colord.blackOpacity2),
          borderRadius: const BorderRadius.all(Radius.circular(21)),
        ),
        width: double.infinity,
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'require';
            }
            return null;
          },
          controller: ServiceDescriptionController,
          keyboardType: TextInputType.multiline,
          textAlign: TextAlign.start,
          maxLines: 6,
          minLines: 1,
          inputFormatters: [LengthLimitingTextInputFormatter(200)],
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Kind Of Service Provider'.tr(context),
            hintStyle: hint414blackOpacityText(),
          ),
        ));
  }

  InkWell buildAddProjectAttach(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 98,
            height: 96,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colord.blackOpacity2),
                borderRadius: const BorderRadius.all(Radius.circular(13))),
            child: Icon(
              Icons.attach_file_rounded,
              size: 44,
              color: Colors.black.withOpacity(.32),
            ),
          ),
          Text(
            'Add Project'.tr(context),
            style: more414blackText(),
          )
        ],
      ),
    );
  }

  SizedBox buildPinDigit({
    required TextEditingController controller,
    TextInputAction? c,
    bool? aut,
    required BuildContext context,
  }) {
    return SizedBox(
      width: 55,
      height: 60,
      child: TextFormField(
        cursorColor: Colord.mainColor,
        controller: controller,
        textAlign: TextAlign.center,
        autofocus: aut ?? false,
        textInputAction: c ?? TextInputAction.next,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        //onEditingComplete: () => FocusScope.of(context).nextFocus(),
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
        decoration: const InputDecoration(
            focusColor: Colord.mainColor,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colord.mainColor)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)))),
      ),
    );
  }
}
