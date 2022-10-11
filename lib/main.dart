import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:getdealss/config/bloc_observer.dart';
import 'config/app_localization.dart';
import 'core/utiles/strings/app_strings.dart';
import 'features/admin/cubit/admin_cubit.dart';
import 'features/chat/presentation/cubit/chat_cubit.dart';
import 'features/chat/presentation/pages/chat_detail_screen.dart';
import 'features/chat/presentation/pages/chat_screen.dart';
import 'features/edit_profile/presentation/pages/edit_profile_Screen.dart';
import 'features/explore_projects/domain/messageModel.dart';
import 'features/explore_projects/presentation/cubit/explore_projects_cubit.dart';
import 'features/explore_projects/presentation/pages/project_details.dart';
import 'features/home/presentation/cubit/home_cubit.dart';
import 'features/home/presentation/pages/home.dart';
import 'features/main_home/presentation/cubit/main_home_cubit.dart';
import 'features/main_home/presentation/pages/main_home_screen.dart';
import 'features/register/domain/entities/user_model.dart';
import 'features/register/presentation/cubit/register_cubit.dart';
import 'features/register/presentation/pages/register_screen.dart';
import 'features/service_provider/presentation/cubit/service_provider_cubit.dart';

import 'features/splash/presentation/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await Firebase.initializeApp(

      //options: DefaultFirebaseOptions.currentPlatform,
      );

  Widget widget;
  UserModel? user;
  User? firebaseUser = FirebaseAuth.instance.currentUser;
  if (firebaseUser != null) {
    final modelRef = FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );
    user = await modelRef.get().then((value) => value.data()!);
    if (user!.userKind == 1) {
      final modelRef = FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .withConverter<UserModel>(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJsonServiceProvider(snapshot.data()!),
            toFirestore: (model, _) => model.toJsonServiceProvider(),
          );
      user = await modelRef.get().then((value) => value.data()!);
    }
    widget = MainHomeScreen(user: user);
  } else {
    widget = RegisterScreen();
  }
  // print(firebaseUser!.uid);

  // var query = await FirebaseFirestore.instance
  //     .collection('users')
  //     .doc('lHPIH71GzIPasyYxVmNlMyHiSuO2')
  //     .collection("userschat")
  //     .get()
  //     .then((value) async {
  //   print(value.docs[0].id);
  // });
  runApp(MyApp(
    widget: widget,
  ));
}

class MyApp extends StatelessWidget {
  Widget widget;
  MyApp({super.key, required this.widget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MainHomeCubit(),
          ),
          BlocProvider(create: (context) => ExploreProjectsCubit()),
          BlocProvider(
            create: (context) => RegisterCubit(),
          ),
          BlocProvider(
            create: (context) => HomeCubit(),
          ),
          BlocProvider(
            create: (context) => ChatCubit(),
          ),
          BlocProvider(
            create: (context) => ServiceProviderCubit()..setQuery(),
          ),
          BlocProvider(
            create: (context) => AdminCubit(),
          )
        ],
        child: MaterialApp(
          title: AppStrings.appName,
          theme: ThemeData(
              primarySwatch: Colors.blue,
              appBarTheme: const AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                      statusBarBrightness: Brightness.light,
                      statusBarIconBrightness: Brightness.light))),
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            for (var locale in supportedLocales) {
              if (deviceLocale != null &&
                  deviceLocale.languageCode == locale.languageCode) {
                return deviceLocale;
              }
            }

            return supportedLocales.first;
          },
          home: SplashScreen(widget: widget),
        ));
  }
}
/**
 
home_screen.dart




 */