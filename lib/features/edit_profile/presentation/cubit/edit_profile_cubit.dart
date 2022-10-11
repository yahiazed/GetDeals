import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utiles/snackbar.dart';
import '../../../register/domain/entities/user_model.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());
  static EditProfileCubit get(context) => BlocProvider.of(context);
  late UserModel user;

  String serviceProviderKind = '';

  final List<String> interests = [
    'Applications',
    'E-Commerce',
    'Factories',
    'Shops',
    'Franchise',
    'Commercial records',
    'Companies'
  ];
  List<String>? selectedInterests;
  PlatformFile? pickedFile;

  UploadTask? uploadTask;
  Future selectImage() async {
    emit(StatrtSelectImage());
    final result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return null;
    } else {
      pickedFile = result.files.first;
    }

    emit(EndSelectImage());
  }

  Future<void> updateProfile({
    required String nameController,
    required String emailController,
    required String genderController,
    required String cityController,
    required int ageController,
    String? ServiceDescriptionController,
    String? specializeController,
    String? yearsController,
    required BuildContext context,
  }) async {
    String photo;
    if (pickedFile != null) {
      emit(StartUploadImageState());
      final path = 'profilePhots/${pickedFile!.name}';
      final file = File(pickedFile!.path!);
      final ref = FirebaseStorage.instance.ref().child(path);
      uploadTask = ref.putFile(file);
      final snapshot = await uploadTask!.whenComplete(() => null);
      photo = await snapshot.ref.getDownloadURL();
    } else {
      photo = user.photo!;
    }
    final modelRef;
    emit(StartUpdateProfileDataState());
    if (user.userKind == 0) {
      final userToUpdate = UserModel(
          uid: user.uid,
          name: nameController,
          email: emailController,
          age: ageController,
          gender: user.gender,
          city: cityController,
          phoneNumber: user.phoneNumber,
          interests: selectedInterests == null
              ? selectedInterests!.join('-').toString()
              : user.interests,
          userKind: 0,
          photo: photo);
      modelRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .withConverter<UserModel>(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson(),
          )
          .update(userToUpdate.toJson())
          .then((value) {
        emit(SuccessUpdateState());

        CustomSnackBar()
            .showSuccessSnackBar(message: 'All done', context: context);
      }).catchError((onError) {
        emit(ErrorUpdateProfileState());
        CustomSnackBar()
            .showErrorSnackBar(message: onError.toString(), context: context);
      });
    } else {
      final serviceUser = UserModel(
        uid: user.uid,
        name: nameController,
        email: emailController,
        age: ageController,
        gender: user.gender,
        city: cityController,
        phoneNumber: user.phoneNumber,
        interests: selectedInterests == null
            ? selectedInterests!.join('-').toString()
            : user.interests,
        userKind: 1,
        photo: photo,
        experienceYears: yearsController!.isEmpty
            ? user.experienceYears
            : int.parse(yearsController),
        serviceDescription: ServiceDescriptionController!.isEmpty
            ? user.serviceDescription
            : ServiceDescriptionController,
        serviceProviderKind: user.serviceProviderKind,
        specialist: specializeController!.isEmpty
            ? user.specialist
            : specializeController,
      );
      modelRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .withConverter<UserModel>(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJsonServiceProvider(snapshot.data()!),
            toFirestore: (model, _) => model.toJsonServiceProvider(),
          )
          .update(serviceUser.toJson())
          .then((value) {
        emit(SuccessUpdateState());

        CustomSnackBar()
            .showSuccessSnackBar(message: 'All done', context: context);
      }).catchError((onError) {
        emit(ErrorUpdateProfileState());
        CustomSnackBar()
            .showErrorSnackBar(message: onError.toString(), context: context);
      });
    }
    emit(EndUpdateProfileDataState());
  }
}
