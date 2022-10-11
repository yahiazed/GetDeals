import 'package:flutter/material.dart';
import 'package:getdealss/config/app_localization.dart';

import '../../../../core/utiles/colors/my_color.dart';
import '../../../../core/utiles/styles/text_style.dart';

class SharedSearchSuffix extends StatelessWidget {
  String filterBy;
  void Function()? onSearch;
  void Function()? onFilter;
  SharedSearchSuffix(
      {super.key, required this.filterBy, this.onSearch, this.onFilter});
  final List<String> interests = [
    'Applications',
    'E-Commerce',
    'Factories',
    'Shops',
    'Franchise',
    'Commercial records',
    'Companies'
  ];
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onSearch,
          icon: const Icon(
            Icons.search,
            size: 20,
          ),
        ),
        IconButton(
          onPressed: () {
            onFilter;
            showDialog(
              barrierColor: Colord.barrier,
              context: context,
              builder: (context) => AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                      6,
                      (index) => buildTapFilterItem(
                          value: interests[index],
                          context: context,
                          setValue: filterBy)),
                ),
              ),
            );
          },
          icon: const Icon(
            Icons.tune,
            size: 20,
          ),
        ),
      ],
    );
  }

  InkWell buildTapFilterItem(
      {required String value,
      required BuildContext context,
      required String setValue}) {
    return InkWell(
      onTap: () {
        setValue = value;
        Navigator.pop(context);
      },
      child: Container(
        width: 270,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            border: BorderDirectional(
                bottom: BorderSide(width: 1, color: Colord.blackOpacity))),
        child: Center(
            child: Text(
          value.tr(context),
          style: txt514BlackLine(),
        )),
      ),
    );
  }
}

class SharedSearchSuffix1 extends StatelessWidget {
  SharedSearchSuffix1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        const IconButton(
          onPressed: null,
          icon: Icon(
            Icons.search,
            size: 20,
          ),
        ),
        const IconButton(
          onPressed: null,
          icon: Icon(
            Icons.tune,
            size: 20,
          ),
        ),
      ],
    );
  }

  InkWell buildTapFilterItem(
      {required String value,
      required BuildContext context,
      required String setValue}) {
    return InkWell(
      onTap: () {
        setValue = value;
        Navigator.pop(context);
      },
      child: Container(
        width: 270,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            border: BorderDirectional(
                bottom: BorderSide(width: 1, color: Colord.blackOpacity))),
        child: Center(
            child: Text(
          value.tr(context),
          style: txt514BlackLine(),
        )),
      ),
    );
  }
}
