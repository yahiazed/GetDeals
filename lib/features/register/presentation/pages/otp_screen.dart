import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getdealss/config/app_localization.dart';

import '../../../../core/utiles/colors/my_color.dart';
import '../../../../core/utiles/shared_widget/clip_path.dart';
import '../../../../core/utiles/shared_widget/outlined_button.dart';
import '../../../../core/utiles/snackbar.dart';
import '../../../../core/utiles/styles/text_style.dart';
import '../../../main_home/presentation/pages/main_home_screen.dart';
import '../cubit/register_cubit.dart';

class OtpScreen extends StatelessWidget {
  String phoneNumber;
  OtpScreen({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    var digit1Controller = TextEditingController();
    var digit2Controller = TextEditingController();
    var digit3Controller = TextEditingController();
    var digit4Controller = TextEditingController();
    var digit5Controller = TextEditingController();
    var digit6Controller = TextEditingController();
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterErrorOccurredState) {
          CustomSnackBar().showErrorSnackBar(
              message: state.errorMsg.tr(context), context: context);
        }
        if (state is RegisterLoadingState) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
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
                    Container(
                      width: double.infinity,
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 69.0),
                              child: Center(
                                child: Text(
                                  'Verification Code'.tr(context),
                                  style: head520BlackLine(),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'otp'.tr(context) + '+2' + phoneNumber,
                                  style: txtDrawerbase516TitlesText(),
                                ),
                                OutlinedButton(
                                  child: Text(
                                    'Edit Number'.tr(context),
                                    style: txt515BlackLine(),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
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
