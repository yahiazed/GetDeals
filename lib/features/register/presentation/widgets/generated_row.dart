import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../../core/utiles/shared_widget/input_field.dart';

class GeneratedRowInputs extends StatelessWidget {
  TextEditingController controller1;
  TextEditingController controller2;
  String hint1, hint2;
  TextInputType textInputType1, textInputType2;
  void Function()? onTap2;
  String? labelText;
  String? initialValue2;
  String? initialValue1;
  bool isTrans;

  GeneratedRowInputs(
      {super.key,
      required this.controller1,
      required this.controller2,
      required this.hint1,
      required this.hint2,
      required this.textInputType1,
      required this.textInputType2,
      this.labelText,
      this.initialValue1,
      this.initialValue2,
      this.isTrans = true,
      this.onTap2});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InputField(
              labelText: labelText,
              isTrans: isTrans,
              hintTxt: hint1,
              // initialValue: initialValue1,
              controller: controller1,
              textInputType: textInputType1),
        ),
        const SizedBox(
          width: 35,
        ),
        Expanded(
          child: InputField(
              hintTxt: hint2,
              // initialValue: initialValue2,
              controller: controller2,
              onTap: onTap2,
              textInputType: textInputType2),
        ),
      ],
    );
  }
}

class GeneratedRowInputs1 extends StatelessWidget {
  TextEditingController? controller1;
  TextEditingController? controller2;
  String hint1, hint2;
  TextInputType textInputType1, textInputType2;
  void Function()? onTap2;
  String? labelText;
  String? initialValue2;
  String? initialValue1;
  String? newValue1;
  String? newValue2;
  void Function(String)? onChanged;
  void Function(String)? onChanged2;
  bool isTrans;

  GeneratedRowInputs1(
      {super.key,
      this.controller1,
      this.controller2,
      required this.hint1,
      required this.hint2,
      required this.textInputType1,
      required this.textInputType2,
      this.labelText,
      this.initialValue1,
      this.initialValue2,
      this.newValue1,
      this.newValue2,
      this.onChanged,
      this.onChanged2,
      this.isTrans = true,
      this.onTap2});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InputField1(
              labelText: labelText,
              isTrans: isTrans,
              hintTxt: hint1,
              onChanged: onChanged,
              initialValue: initialValue1,
              newValue: newValue1,
              //controller: controller1,
              textInputType: textInputType1),
        ),
        const SizedBox(
          width: 35,
        ),
        Expanded(
          child: InputField1(
              hintTxt: hint2,
              initialValue: initialValue2,
              onChanged: onChanged2,
              // controller: controller2,
              onTap: onTap2,
              newValue: newValue2,
              textInputType: textInputType2),
        ),
      ],
    );
  }
}
