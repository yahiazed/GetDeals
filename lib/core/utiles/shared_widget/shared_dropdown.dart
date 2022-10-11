import 'package:flutter/material.dart';
import 'package:getdealss/config/app_localization.dart';

import '../colors/my_color.dart';
import '../styles/text_style.dart';

class SharedDropdown extends StatelessWidget {
  String dropdownValue;
  String? lable;
  List<String> values;
  void Function(String?)? onChanged;
  SharedDropdown({
    super.key,
    required this.dropdownValue,
    required this.values,
    this.lable,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: DropdownButtonFormField(
        //alignment: Alignment.center,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          labelText: lable,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            //<-- SEE HERE
            borderSide: BorderSide(color: Colord.blackOpacity, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            //<-- SEE HERE
            borderSide: BorderSide(color: Colord.blackOpacity, width: 2),
          ),
        ),
        dropdownColor: Colors.white,
        value: dropdownValue,
        onChanged: onChanged,
        items: values.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value.tr(context),
              textAlign: TextAlign.center,
              style: hint414blackOpacityText(),
            ),
          );
        }).toList(),
      ),
    );
  }
}
