import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getdealss/config/app_localization.dart';

import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../../../../core/utiles/colors/my_color.dart';
import '../../../../core/utiles/policy_dialog.dart';
import '../../../../core/utiles/shared_widget/clip_path.dart';
import '../../../../core/utiles/shared_widget/outlined_button.dart';
import '../../../../core/utiles/snackbar.dart';
import '../../../../core/utiles/styles/text_style.dart';
import '../../../login/presentation/pages/login_screen.dart';
import '../../../main_home/presentation/pages/main_home_screen.dart';
import '../cubit/register_cubit.dart';
import '../widgets/generated_row.dart';
import 'register_service_provider_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var ageController = TextEditingController();
    var phoneController = TextEditingController();
    var genderController = TextEditingController();
    var emailController = TextEditingController();
    var cityController = TextEditingController();
    var formRegisterKey = GlobalKey<FormState>();

    var digit1Controller = TextEditingController();
    var digit2Controller = TextEditingController();
    var digit3Controller = TextEditingController();
    var digit4Controller = TextEditingController();
    var digit5Controller = TextEditingController();
    var digit6Controller = TextEditingController();
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is CodeSentState) {
          Navigator.pop(context);
        }
        if (state is RegisterErrorOccurredState) {
          CustomSnackBar().showErrorSnackBar(
              message: state.errorMsg.tr(context), context: context);
          RegisterCubit.get(context).notOtp = true;
        }
        if (state is RegisterErrorOccurredState1) {
          Navigator.pop(context);
          CustomSnackBar().showErrorSnackBar(
              message: state.errorMsg.tr(context), context: context);
          RegisterCubit.get(context).notOtp = true;
        }
        if (state is RegisterLoadingState) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('Please Waite ...'.tr(context)),
                    content: Container(
                      color: Colors.white,
                      width: 100,
                      height: 100,
                      child: const Center(
                          child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator())),
                    ),
                  ));
        }
        if (state is PhoneOTPVerifiedState) {
          CustomSnackBar().showSuccessSnackBar(
              message: 'تم تاكيد الهاتف بنجاح', context: context);
        }
        if (state is AddingNewUserSuccessState) {
          CustomSnackBar().showSuccessSnackBar(
              message: 'تم انشاء الحساب بنجاح', context: context);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  MainHomeScreen(user: RegisterCubit.get(context).userModel),
            ),
          );
        }
        if (state is AddingNewUserErrorState) {
          CustomSnackBar()
              .showErrorSnackBar(message: state.errorMsg, context: context);
        }
        if (state is AddingNewUserLoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
                child: SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator())),
          );
        }
        if (state is UserStartExistState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
                child: SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator())),
          );
        }
        if (state is UserExistState) {
          CustomSnackBar().showSuccessSnackBar(
              message: 'Account Already Exist'.tr(context), context: context);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  MainHomeScreen(user: RegisterCubit.get(context).userModel)));
        }
      },
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
                    cubit.notOtp
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
                                        'register'.tr(context),
                                        style: head520BlackLine(),
                                      ),
                                    ),
                                    GeneratedRowInputs(
                                        controller1: nameController,
                                        controller2: ageController,
                                        hint1: "Name",
                                        hint2: "Age",
                                        textInputType1: TextInputType.name,
                                        textInputType2: TextInputType.number),
                                    GeneratedRowInputs(
                                      controller1: phoneController,
                                      controller2: genderController,
                                      hint1: "56-345-6789",
                                      labelText: "phone".tr(context),
                                      hint2: "Gender",
                                      textInputType1: TextInputType.phone,
                                      textInputType2: TextInputType.text,
                                      onTap2: () => showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text('Gender'.tr(context)),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  cubit.gender = 'male';
                                                  genderController.text =
                                                      'male'.tr(context);
                                                  Navigator.pop(context);
                                                },
                                                child:
                                                    Text('male'.tr(context))),
                                            TextButton(
                                                onPressed: () {
                                                  cubit.gender = 'female';
                                                  genderController.text =
                                                      'female'.tr(context);
                                                  Navigator.pop(context);
                                                },
                                                child:
                                                    Text('female'.tr(context))),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GeneratedRowInputs(
                                        controller1: emailController,
                                        controller2: cityController,
                                        hint1: "Email",
                                        hint2: "City",
                                        textInputType1:
                                            TextInputType.emailAddress,
                                        textInputType2: TextInputType.text),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 34.0),
                                      child: MultiSelectDialogField(
                                        barrierColor: const Color(0xff160048)
                                            .withOpacity(0.73),
                                        buttonIcon: const Icon(
                                          Icons.keyboard_arrow_down,
                                        ),
                                        buttonText: Text(
                                          "Interests".tr(context),
                                          style: hint414blackOpacityText(),
                                        ),
                                        itemsTextStyle:
                                            hint414blackOpacityText(),
                                        items: cubit.interests
                                            .map((e) => MultiSelectItem(
                                                e, e.tr(context)))
                                            .toList(),
                                        listType: MultiSelectListType.CHIP,
                                        onConfirm: (values) {
                                          cubit.selectedInterests = values;
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 38,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 34.0),
                                      child: SharedOutlineButton(
                                        onPressed: () {
                                          if (formRegisterKey.currentState!
                                              .validate()) {
                                            cubit.submitPhoneNumber(
                                                phoneController.text);
                                            cubit.userName =
                                                nameController.text;
                                            cubit.age =
                                                int.parse(ageController.text);
                                            cubit.city = cityController.text;
                                            cubit.email = emailController.text;
                                            //cubit.gender = genderController.text;
                                            cubit.phoneNumber =
                                                phoneController.text;
                                            cubit.notOtp = false;
                                            // navigateTo(
                                            //     context,
                                            //     OtpScreen(
                                            //       phoneNumber:
                                            //           phoneController.text,
                                            //     ));
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
                                          cubit.userKind = 1;
                                          navigateTo(context,
                                              const RegisterServiceProviderScreen());
                                        },
                                        child: Text(
                                          "I have a skill".tr(context),
                                          style: more414blackText(),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 34.0),
                                      child: TextButton(
                                        onPressed: () {
                                          navigateTo(
                                              context, const LoginScreen());
                                        },
                                        child: Text(
                                          "haveAccount".tr(context),
                                          style: more414blackText(),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                            text:
                                                'By Creating Account You Are Agree to\n',
                                            style: hint414blackOpacityText(),
                                            children: [
                                              TextSpan(
                                                  text: 'terms_conditions',
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {
                                                          showDialog(
                                                              context: context,
                                                              builder: (context) =>
                                                                  PolicyDialog(
                                                                      mdFile:
                                                                          'terms_conditions.md'));
                                                        },
                                                  style: txt718greyText()),
                                              const TextSpan(text: "and"),
                                              TextSpan(
                                                  text: 'Privacy Policy',
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {
                                                          showDialog(
                                                              context: context,
                                                              builder: (context) =>
                                                                  PolicyDialog(
                                                                      mdFile:
                                                                          'privacy_plocy.md'));
                                                        },
                                                  style: txt718greyText())
                                            ]),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
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
                                        child: Text(
                                          'otp'.tr(context) +
                                              '+2' +
                                              phoneController.text,
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
                                          cubit.createNewUser2();
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
