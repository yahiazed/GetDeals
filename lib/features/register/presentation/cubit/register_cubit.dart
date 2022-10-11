import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user_model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);
  String userName = '', gender = '', email = '', city = '';
  int age = 0;
  String phoneNumber = '';
  int userKind = 0;
  String specialist = '';

  String serviceProviderKind = '';
  String serviceDescription = '';
  num costHour = 0;
  int experienceYears = 0;
  //bool isServiceStep2 = true;
  FirebaseAuth auth = FirebaseAuth.instance;
  late UserModel userModel;
  bool notOtp = true;
  bool notOtp2 = true;

  final List<String> interests = [
    'Applications',
    'E-Commerce',
    'Factories',
    'Shops',
    'Franchise',
    'Commercial records',
    'Companies'
  ];
  final List<String> specialistList = [
    "Law",
    "Finance",
    "management consulting",
    "Graphic Design",
    "Programing",
    "Account management",
  ];
  List<String>? selectedInterests;
  late String verificationId;

  Future<void> submitPhoneNumber(String phoneNumber) async {
    emit(RegisterLoadingState());

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2$phoneNumber',
      timeout: const Duration(seconds: 14),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

//582389190
  void verificationCompleted(PhoneAuthCredential credential) async {
    print('verificationCompleted');

    await signIn(credential);
  }

  void verificationFailed(FirebaseAuthException error) {
    print('verificationFailed : ${error.code}');
    emit(RegisterErrorOccurredState1(errorMsg: error.code.toString()));
  }

  void codeSent(String verificationId, int? resendToken) {
    this.verificationId = verificationId;
    emit(CodeSentState());
    emit(PhoneNumberSubmitedState());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    print('codeAutoRetrievalTimeout');
  }

  Future<void> submitOTP(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: this.verificationId, smsCode: otpCode);

    await signIn(credential);
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);

      emit(PhoneOTPVerifiedState());
    } on FirebaseAuthException catch (error) {
      print('${error.code}');
      emit(RegisterErrorOccurredState(errorMsg: error.code));
    }
  }

  // Start create New User
  Future<void> createNewUser2() async {
    emit(AddingNewUserLoadingState());

    final modelRef = FirebaseFirestore.instance
        .collection('users')
        .doc(getLoggedInUser().uid)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );

    final DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(getLoggedInUser().uid)
        .get();

    if (doc.exists) {
      emit(UserStartExistState());
      userModel = UserModel.fromJson(doc.data()!);
      emit(UserExistState());
    } else {
      emit(AddingNewUserLoadingState());

      await modelRef
          .set(
        UserModel(
          uid: getLoggedInUser().uid,
          name: userName,
          email: email,
          age: age,
          gender: gender,
          city: city,
          phoneNumber: phoneNumber,
          interests: selectedInterests!.join('-').toString(),
          photo:
              'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=740&t=st=1664406514~exp=1664407114~hmac=65601c6244a0fff286768e8478538fd8c74314cebe7961a242157d38a36a461c',
          userKind: 0,
        ),
      )
          .then((value) async {
        userModel = await modelRef.get().then((value) => value.data()!);
        emit(AddingNewUserSuccessState());
      }).catchError((onError) {
        emit(AddingNewUserErrorState(errorMsg: onError));
      });
    }
  }

  // END CREATE INVESTOR USER
  //Start create Service Provider
  Future<void> createNewServiceProvider() async {
    emit(AddingNewUserLoadingState());

    final modelRef = FirebaseFirestore.instance
        .collection('users')
        .doc(getLoggedInUser().uid)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJsonServiceProvider(),
        );

    final DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(getLoggedInUser().uid)
        .get();

    if (doc.exists) {
      emit(UserStartExistState());
      userModel = UserModel.fromJson(doc.data()!);
      emit(UserExistState());
    } else {
      emit(AddingNewUserLoadingState());

      await modelRef
          .set(
        UserModel(
            uid: getLoggedInUser().uid,
            name: userName,
            email: email,
            age: age,
            gender: gender,
            city: city,
            phoneNumber: phoneNumber,
            interests: 'Freelance',
            hourPrice: costHour,
            photo:
                'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=740&t=st=1664406514~exp=1664407114~hmac=65601c6244a0fff286768e8478538fd8c74314cebe7961a242157d38a36a461c',
            experienceYears: experienceYears,
            serviceDescription: serviceDescription,
            serviceProviderKind: serviceProviderKind,
            specialist: specialist,
            userKind: 1),
      )
          .then((value) async {
        userModel = await modelRef.get().then((value) => value.data()!);
        emit(AddingNewUserSuccessState());
      }).catchError((onError) {
        emit(AddingNewUserErrorState(errorMsg: onError));
      });
    }
  }

  //End Create New User

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  User getLoggedInUser() {
    User firebaseUser = FirebaseAuth.instance.currentUser!;

    return firebaseUser;
  }
}
