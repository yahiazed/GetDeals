import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:image_picker/image_picker.dart';

import '../../../register/domain/entities/user_model.dart';
import '../../domain/post_model.dart';
import 'package:http/http.dart' as http;
part 'add_project_state.dart';

class AddProjectCubit extends Cubit<AddProjectState> {
  AddProjectCubit() : super(AddProjectInitial());
  static AddProjectCubit get(context) => BlocProvider.of(context);

  UploadTask? uploadTask;
  List<PickedFile> pickedImagesList = [];
  List<String> photosUrls = [];
  UploadTask? uploadTask2;
  List<PlatformFile> pickedFilesList = [];
  List<String> filesNamesList = [];
  List<String> downloadFilesUrls = [];
  late UserModel user;
  String projectKind = 'Applications';
  void onChanged(String? newValue) {
    emit(StartDropDownChanged());
    projectKind = newValue!;
    print(projectKind);
    emit(EndDropDownChanged());
  }

  final projectRef = FirebaseFirestore.instance
      .collection('projects')
      .withConverter<ProjectModel>(
        fromFirestore: (snapshot, _) => ProjectModel.fromJson(snapshot.data()!),
        toFirestore: (project, _) => project.toJson(),
      );

  Future payment() async {
    // Eng :Mohamed salah
    // write code of pay
    //then i will complete add project data to firebase if pay
  }

// select images
  Future<List<PickedFile>?> selectImage() async {
    emit(StatrtSelectImage());
    // FilePicker.platform.pickFiles();
    pickedImagesList.clear();
    final result = await ImagePicker.platform.pickMultiImage();
    if (result != null) {
      result.forEach((pickedFile) async {
        pickedImagesList.add(pickedFile);
      });
      emit(EndSelectImage());
    } else {
      return null;
    }

    return result;
  }

// end slect images
// select Files
  Future selectFiles() async {
    emit(StartSelectFiles());

    pickedFilesList.clear();
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'word', 'txt', 'excel'],
    );

    if (result != null) {
      result.files.forEach((pickedFile) async {
        pickedFilesList.add(pickedFile);
      });
      emit(EndSelectFiles());
    } else {
      return null;
    }
  }
// end slect images

  Future<List<String>> uploadImages() async {
    photosUrls.clear();
    Future list;
    for (PickedFile pickedFile in pickedImagesList) {
      final path = 'postsPhots/${pickedFile.hashCode}';
      final file = File(pickedFile.path);
      final ref = FirebaseStorage.instance.ref().child(path);
      uploadTask = ref.putFile(file);
      final snapshot = await uploadTask!.whenComplete(() => null);
      String photo = await snapshot.ref.getDownloadURL();
      photosUrls.add(photo);
    }
    pickedImagesList.forEach((pickedFile) async {
      // final path = 'postsPhots/${pickedFile.hashCode}';
      // final file = File(pickedFile.path);
      // final ref = FirebaseStorage.instance.ref().child(path);
      // uploadTask = ref.putFile(file);
      // final snapshot = await uploadTask!.whenComplete(() => null);
      // String photo = await snapshot.ref.getDownloadURL();
      // photosUrls.add(photo);
    });

    return photosUrls;
  }

  Future<List<String>> uploadFiles() async {
    if (pickedFilesList.isNotEmpty) {
      downloadFilesUrls.clear();
      filesNamesList.clear();
      for (PlatformFile pickedFile in pickedFilesList) {
        filesNamesList.add(pickedFile.name);
        final path = 'postsFiles/${user.name}/${pickedFile.name}';
        final file = File(pickedFile.path!);
        final ref = FirebaseStorage.instance.ref().child(path);
        uploadTask = ref.putFile(file);
        final snapshot = await uploadTask!.whenComplete(() => null);
        String filesUrl = await snapshot.ref.getDownloadURL();
        downloadFilesUrls.add(filesUrl);
      }

      pickedFilesList.forEach((pickedFile) async {
        // emit(StartUploadImageState());
        // pickedFilesList.add(pickedFile);

        // filesNamesList.add(pickedFile.name);
        // final path = 'postsFiles/${user.name}/${pickedFile.name}';
        // final file = File(pickedFile.path!);
        // final ref = FirebaseStorage.instance.ref().child(path);
        // uploadTask = ref.putFile(file);
        // final snapshot = await uploadTask!.whenComplete(() => null);
        // String filesUrl = await snapshot.ref.getDownloadURL();
        // downloadFilesUrls.add(filesUrl);
        print('uploadfiles.....' + downloadFilesUrls.first);
      });
      print('end upload file.......');
    }
    return downloadFilesUrls;
  }

  Future AddingNewProject({
    // required int id,
    required String projectName,
    // required String imgUrls,
    // required String filesUrls,
    //required String filesUrls,
    required String projectState,
    required String projectPlace,
    required String projectDuration,
    required String projectPartnerNumber,
    required String projectReasonOfPay,
    required String projectSumSales,
    required String projectSubnetProfit,
    required String projectDescription,
  }) async {
    emit(StartAddingNewProjectState());
    await uploadImages();
    await uploadFiles();

    await projectRef
        .doc()
        .set(ProjectModel(
          //id: doc,
          projectName: projectName,
          imgUrls: photosUrls.join(','),
          filesNames: filesNamesList.join(','),
          filesUrls: downloadFilesUrls.join(','),
          userUid: user.uid,
          projectKind: projectKind,
          projectPlace: projectPlace,
          projectDuration: projectDuration,
          projectPartnerNumber: projectPartnerNumber,
          projectReasonOfPay: projectReasonOfPay,
          projectSumSales: projectSumSales,
          projectSubnetProfit: projectSubnetProfit,
          projectDescription: projectDescription,
          projectDate: DateTime.now().toString(),
          projectState: projectState,
        ))
        .then((value) async {
      print('==============');
      print(projectKind);

      emit(SuccessAddNewProjectState());
      pickedFilesList.clear();
      pickedImagesList.clear();
      emit(EndSelectFiles());
      emit(EndSelectImage());
    }).catchError((onError) {
      emit(ErrorAddNewProjectState(errMsg: onError));
    });

    if (photosUrls.isNotEmpty && downloadFilesUrls.isNotEmpty) {}
  }

  int _messageCount = 0;
  String constructFCMPayload(String? topic) {
    _messageCount++;
    return jsonEncode({
      'token': topic,
      'data': {
        'via': 'FlutterFire Cloud Messaging!!!',
        'count': _messageCount.toString(),
        'token': topic
      },
      'notification': {
        'title': 'Hello FlutterFire!',
        'body': 'This notification (#$_messageCount) was created via FCM!',
      },
    });
  }

  final server = 'AIzaSyD_-AL7M1GPCJD23cnUWS9R6Rjj0QqjcYg';
  Future f({required String topic}) async {
    try {
      await http.post(
        Uri.parse('https://api.rnfirebase.io/messaging/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": 'key=$server'
        },
        body: constructFCMPayload(topic),
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }
}
