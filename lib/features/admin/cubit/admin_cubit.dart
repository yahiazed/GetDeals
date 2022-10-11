import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitialState());
  static AdminCubit get(context) => BlocProvider.of(context);
  PickedFile? result;
  Future<PickedFile?> selectImage() async {
    emit(StatrtSelectImage());

    result = await ImagePicker.platform
        .pickImage(source: ImageSource.gallery)
        .whenComplete(() {
      print('objectjbbbbbb');
    });
    if (result != null) {
      print(result!.path);
      emit(EndSelectImage());
    } else {
      return null;
    }

    return result;
  }

  UploadTask? uploadTask;
  Future upload() async {
    if (result != null) {
      emit(StartUploadBanner());
      final path = 'BannerPhots/${result.hashCode}';
      final file = File(result!.path);
      final ref = FirebaseStorage.instance.ref().child(path);
      uploadTask = ref.putFile(file);
      final snapshot = await uploadTask!.then((p0) async {
        String photo = await p0.ref.getDownloadURL();
        await FirebaseFirestore.instance.collection('banners').doc().set({
          'imgUrl': photo,
          'date': DateTime.now(),
          'projectId': null,
        });
        emit(EndUploadBanner());
      });
    }
  }
}
