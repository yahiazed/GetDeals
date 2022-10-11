import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../register/domain/entities/user_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  late String verificationId;
  String phoneNumber = '';
  bool notOtp = true;
  late UserModel userModel;
  void editPhone() {
    emit(StartEditPhoneState());
    notOtp = true;
    emit(EditPhoneState());
  }

  Future<void> getUserData() async {
    emit(StartGetUserData());
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
      emit(UserExistState(userData: userModel));
    } else {
      emit(UserNotExistState());
    }
  }

  Future<void> submitPhoneNumber(String phoneNumber) async {
    emit(LoginLoadingState());

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2$phoneNumber',
      timeout: const Duration(seconds: 14),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    print('verificationCompleted');

    await signIn(credential);
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);

      emit(PhoneOTPVerifiedState());
    } on FirebaseAuthException catch (error) {
      print('${error.code}');
      emit(LoginErrorOccurredState(errorMsg: error.code));
    }
  }

  void verificationFailed(FirebaseAuthException error) {
    print('verificationFailed : ${error.code}');
    emit(LoginErrorOccurredState(errorMsg: error.code.toString()));
  }

  void codeSent(String verificationId, int? resendToken) {
    this.verificationId = verificationId;

    emit(CodeSentState());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    print('codeAutoRetrievalTimeout');
  }

  Future<void> submitOTP(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: this.verificationId, smsCode: otpCode);

    await signIn(credential);
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  User getLoggedInUser() {
    User firebaseUser = FirebaseAuth.instance.currentUser!;

    return firebaseUser;
  }
}
