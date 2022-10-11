import 'package:flutter/material.dart';

import '../../../../core/utiles/colors/my_color.dart';
import '../../../../core/utiles/styles/text_style.dart';

class SharedDropDownButton extends StatefulWidget {
  const SharedDropDownButton({super.key});

  @override
  State<SharedDropDownButton> createState() => _SharedDropDownButtonState();
}

class _SharedDropDownButtonState extends State<SharedDropDownButton> {
  @override
  Widget build(BuildContext context) {
    String dropdownValue = 'Dog';
    return Container(
      width: 136,
      child: DropdownButtonFormField(
        elevation: 3,
        style: TextStyle(fontSize: 5, height: 1),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colord.blackOpacity2, width: 1),
            borderRadius: BorderRadius.all(
              Radius.circular(22.5),
            ), //<-- SEE HERE
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(22.5),
            ),
            borderSide:
                BorderSide(color: Colord.blackOpacity, width: 2), //<-- SEE HERE
          ),
          // filled: true,
          // fillColor: Colord.whit,
        ),
        dropdownColor: Colord.mainColor,
        value: dropdownValue,
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: <String>['Dog', 'Cat', 'Tiger', 'Lion']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: txt520BlackTitle(),
            ),
          );
        }).toList(),
      ),
    );
  }
}
