import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;

import '../../../../config/get_user_data.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());

  static SettingCubit get(context) => BlocProvider.of(context);

  Future sendEmailSupport({
    required String message,
  }) async {
    GetUser()
        .getCustomUserData(FirebaseAuth.instance.currentUser!.uid)
        .then((value) async {
      print(value.email);
      final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
      var service_id = 'service_9js6aey';
      var template_id = 'template_s4opkzc';
      var user_id = 'phsHHB-ltD9EeqFIh';
      final response = await http
          .post(url,
              headers: {'Content-Type': 'application/json'},
              body: json.encode(
                {
                  'service_id': service_id,
                  'template_id': template_id,
                  'user_id': user_id,
                  // 'accessToken':'AAvhlrcksh5zCdFmxKa3T',
                  'template_params': {
                    'user_name': value.name,
                    'user_email': value.email,
                    'user_subject': 'support',
                    'user_message': message
                  }
                },
              ))
          .then((value) {
        print('code ;;;:${value.statusCode}');
      }).catchError((onError) {
        print('reoor......:${onError.toString()}');
      });
    });
  }
}
