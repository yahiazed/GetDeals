import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:getdealss/config/app_localization.dart';

class PolicyDialog extends StatelessWidget {
  String mdFile;
  PolicyDialog({super.key, required this.mdFile});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: Future.delayed(Duration(milliseconds: 150)).then((value) {
              return rootBundle.loadString('assets/$mdFile');
            }),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Markdown(
                  data: snapshot.data!,
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          )),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'I Agree'.tr(context),
              )),
        ],
      ),
    );
  }
}
