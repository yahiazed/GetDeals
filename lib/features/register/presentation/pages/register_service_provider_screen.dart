import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getdealss/config/app_localization.dart';
import 'package:getdealss/features/register/presentation/pages/register_screen.dart';

import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../../../../core/utiles/colors/my_color.dart';
import '../../../../core/utiles/shared_widget/clip_path.dart';
import '../../../../core/utiles/shared_widget/outlined_button.dart';
import '../../../../core/utiles/snackbar.dart';
import '../../../../core/utiles/styles/text_style.dart';
import '../../../login/presentation/pages/login_screen.dart';
import '../cubit/register_cubit.dart';
import '../widgets/generated_row.dart';
import 'register_service_screen_second.dart';

class RegisterServiceProviderScreen extends StatelessWidget {
  const RegisterServiceProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var ageController = TextEditingController();
    var phoneController = TextEditingController();
    var genderController = TextEditingController();
    var emailController = TextEditingController();
    var cityController = TextEditingController();
    var ServiceKindController = TextEditingController();
    var formRegisterServiceKey = GlobalKey<FormState>();

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
                    Form(
                      key: formRegisterServiceKey,
                      child: Container(
                        width: double.infinity,
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 34.0),
                                child: Text(
                                  'Register As ServiceProvider'.tr(context),
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
                                textInputType2: TextInputType.none,
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
                                          child: Text('male'.tr(context))),
                                      TextButton(
                                          onPressed: () {
                                            cubit.gender = 'female';
                                            genderController.text =
                                                'female'.tr(context);
                                            Navigator.pop(context);
                                          },
                                          child: Text('female'.tr(context))),
                                    ],
                                  ),
                                ),
                              ),
                              GeneratedRowInputs(
                                  controller1: emailController,
                                  controller2: cityController,
                                  hint1: "Email",
                                  hint2: "City",
                                  textInputType1: TextInputType.emailAddress,
                                  textInputType2: TextInputType.text),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 34.0),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'require';
                                      }
                                      return null;
                                    },
                                    controller: ServiceKindController,
                                    keyboardType: TextInputType.none,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      suffixIcon: const Icon(
                                          Icons.keyboard_arrow_down_sharp),
                                      hintText: 'Kind Of Service Provider'
                                          .tr(context),
                                      hintStyle: hint414blackOpacityText(),
                                    ),
                                    onTap: () => showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text(
                                            'serviceProviderKind'.tr(context)),
                                        actionsAlignment:
                                            MainAxisAlignment.center,
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              cubit.serviceProviderKind =
                                                  'Companies';
                                              ServiceKindController.text =
                                                  'Companies'.tr(context);
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Companies'.tr(context),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              cubit.serviceProviderKind =
                                                  'Freelancer';
                                              ServiceKindController.text =
                                                  'Freelancer'.tr(context);
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Freelancer'.tr(context),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                              const SizedBox(
                                height: 38,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 34.0),
                                child: SharedOutlineButton(
                                  onPressed: () {
                                    if (formRegisterServiceKey.currentState!
                                        .validate()) {
                                      cubit.userName = nameController.text;
                                      cubit.age = int.parse(ageController.text);
                                      cubit.city = cityController.text;
                                      cubit.email = emailController.text;

                                      cubit.phoneNumber = phoneController.text;
                                      navigateTo(context,
                                          RegisterServiceProviderSecondScreen());
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
                                    navigateTo(context, const RegisterScreen());
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
