import 'package:flutter/material.dart';
import 'package:getdealss/config/app_localization.dart';

import '../../../../core/utiles/colors/my_color.dart';
import '../../../../core/utiles/styles/text_style.dart';
import '../../../register/domain/entities/user_model.dart';
import '../pages/service_provider_detail.dart';

class SharedProviderItem extends StatelessWidget {
  UserModel user;
  UserModel serviceProvider;
  SharedProviderItem(
      {super.key, required this.user, required this.serviceProvider});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => navigateTo(
          context,
          ServiceDetailScreen(
            accessUser: user,
            serviceProviderData: serviceProvider,
          )),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Container(
          width: 181,
          height: 208,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: Colord.bla,
            borderRadius: const BorderRadius.all(
              Radius.circular(11),
            ),
            image: DecorationImage(
              image: NetworkImage(
                serviceProvider.photo!,
              ),
              opacity: 0.75,
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  serviceProvider.name,
                  style: nameMeduim16white(),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        serviceProvider.specialist!.tr(context),
                        style: txtMeduim13white(),
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      child: Text(
                        '${serviceProvider.hourPrice ?? 0}${'Rs/h'.tr(context)}',
                        style: txtMeduim13white(),
                      ),
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
