// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getdealss/config/app_localization.dart';

import '../../../../core/utiles/colors/my_color.dart';
import '../../../../core/utiles/shared_widget/clip_path.dart';
import '../../../../core/utiles/shared_widget/input_field.dart';
import '../../../../core/utiles/shared_widget/outlined_button.dart';
import '../../../../core/utiles/snackbar.dart';
import '../../../../core/utiles/styles/text_style.dart';
import '../../../main_home/presentation/pages/main_home_screen.dart';
import '../../../register/presentation/pages/register_screen.dart';
import '../cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    var formLoginKey = GlobalKey<FormState>();
    var digit1Controller = TextEditingController();
    var digit2Controller = TextEditingController();
    var digit3Controller = TextEditingController();
    var digit4Controller = TextEditingController();
    var digit5Controller = TextEditingController();
    var digit6Controller = TextEditingController();
    return BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginLoadingState) {
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
            if (state is LoginErrorOccurredState) {
              CustomSnackBar().showErrorSnackBar(
                  message: state.errorMsg.tr(context), context: context);
              //LoginCubit.get(context).notOtp = false;
              Navigator.pop(context);
            }
            if (state is PhoneOTPVerifiedState) {
              LoginCubit.get(context).getUserData();
            }
            if (state is UserExistState) {
              navigateTo(context, MainHomeScreen(user: state.userData));
            }
            if (state is UserNotExistState) {
              navigateTo(context, RegisterScreen());
            }
            if (state is CodeSentState) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            var cubit = LoginCubit.get(context);
            return Container(
              decoration: BoxDecoration(
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
                          height: 504,
                          color: Colord.mainColor,
                          child: Center(
                            child: Image.asset(
                              'assets/images/log.png',
                              color: Colord.whit,
                            ),
                          ),
                        ),
                      ),
                      cubit.notOtp
                          ? Form(
                              key: formLoginKey,
                              child: Container(
                                width: double.infinity,
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 68.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'login'.tr(context),
                                        style: head520BlackLine(),
                                      ),
                                      InputField(
                                          hintTxt: "56-345-6789",
                                          labelText: "phone".tr(context),
                                          isTrans: false,
                                          controller: controller,
                                          textInputType: TextInputType.phone),
                                      SizedBox(
                                        height: 38,
                                      ),
                                      SharedOutlineButton(
                                        onPressed: () {
                                          if (formLoginKey.currentState!
                                              .validate()) {
                                            cubit.submitPhoneNumber(
                                                controller.text);
                                            cubit.notOtp = false;
                                          }
                                        },
                                        txt: "next",
                                      ),
                                      SizedBox(
                                        height: 48,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          navigateTo(context, RegisterScreen());
                                        },
                                        child: Text(
                                          "NoAccount".tr(context),
                                          style: more414blackText(),
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
                                        Text(
                                          '${'otp'.tr(context)}+2${controller.text}',
                                          style: txtDrawerbase516TitlesText(),
                                        ),
                                        OutlinedButton(
                                          child: Text(
                                            'Edit Number'.tr(context),
                                            style: txt515BlackLine(),
                                          ),
                                          onPressed: () {
                                            cubit.editPhone();
                                          },
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
                                          String otpCode =
                                              digit1Controller.text +
                                                  digit2Controller.text +
                                                  digit3Controller.text +
                                                  digit4Controller.text +
                                                  digit5Controller.text +
                                                  digit6Controller.text;

                                          cubit.submitOTP(otpCode);
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
              ),
            );
          },
        ));
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
