import 'package:flutter/material.dart';
import 'package:getdealss/config/app_localization.dart';

import '../../../../core/utiles/colors/my_color.dart';
import '../../../../core/utiles/shared_widget/action.dart';
import '../../../../core/utiles/shared_widget/double_border.dart';
import '../../../../core/utiles/shared_widget/elevated_button.dart';
import '../../../../core/utiles/shared_widget/leading.dart';
import '../../../../core/utiles/shared_widget/shaps.dart';
import '../../../../core/utiles/shared_widget/shared_rounded_input.dart';
import '../../../../core/utiles/shared_widget/title.dart';
import '../../../../core/utiles/styles/text_style.dart';
import '../widgets/shared_column.dart';
import '../widgets/shared_payment_card.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var cardNumberController = TextEditingController();
    return Container(
        decoration: const BoxDecoration(
            color: Colord.whit,
            image: DecorationImage(
                image: AssetImage('assets/images/bg.png'), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colord.mainColor,
            centerTitle: true,
            title: SharedTitle(
              txt: "Payment".tr(context),
            ),
            leadingWidth: 66.0,
            actions: const [SharedAction()],
            leading: SharedLeading(),
            shape: RoundedShape.roundedAppBar(),
            toolbarHeight: 187,
            bottom: PreferredSize(
              preferredSize: Size(size.width, 1),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 29.0),
                child: Container(
                  child: ListTile(
                    leading: DoubleBorder(
                      r1: 25,
                      r2: 24,
                      r3: 22,
                      img:
                          'https://img.freepik.com/free-photo/happy-african-american-woman-with-curly-hair-shows-small-size-stands-joyful-demonstrates-tiny-little-thing-object-dressed-velvet-jacket-poses-against-purple-wall-body-language-concept_273609-50981.jpg?w=740&t=st=1661988075~exp=1661988675~hmac=d28481bb2e4debce96de299211a22a6b8808222ed608a4b2ba72e28bc426160f',
                    ),
                    title: const Text(
                      'أهلا. عبدالله ',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Tajawal',
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SharedCard(
                                onPressed: () {},
                                icon: Icons.payments_sharp,
                              ),
                              SharedCard(
                                onPressed: () {},
                                icon: Icons.payment,
                              ),
                              // SharedCard(img: "assets/images/chat.png"),
                              // SharedCard(img: "assets/images/chat.png"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "Card Number".tr(context),
                            style: txt514BlackLine(),
                          ),
                        ),
                        SharedBorderInput(
                          height: 48,
                          radius: 13,
                          hintTxt: "sy",
                          controller: cardNumberController,
                          textInputType: TextInputType.number,
                          sufix: const Icon(
                            Icons.payment,
                            color: Colord.bla,
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "Cardholder's name".tr(context),
                            style: txt514BlackLine(),
                          ),
                        ),
                        SharedBorderInput(
                          height: 48,
                          radius: 13,
                          hintTxt: "sy",
                          controller: cardNumberController,
                          textInputType: TextInputType.name,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: SharedColumnDate(
                                  txtHead: "Date",
                                  txtHint: "DD-MM-YYYY",
                                  controller: cardNumberController,
                                  textInputType: TextInputType.datetime),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Expanded(
                              child: SharedColumnDate(
                                  txtHead: "CVV",
                                  txtHint: "X X X X",
                                  controller: cardNumberController,
                                  textInputType: TextInputType.datetime),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Row(
                            children: [
                              Container(
                                height: 35,
                                width: 35,
                                child: Card(
                                  elevation: 5,
                                ),
                              ),
                              const SizedBox(
                                width: 21,
                              ),
                              Text(
                                "saveCard".tr(context),
                                style: more414blackText(),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SharedElevatedButton(
                width: size.width,
                height: 80,
                txt: "pay",
                onPressed: () {},
              )
            ],
          ),
        ));
  }
}
