import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:getdealss/config/app_localization.dart';
import 'package:getdealss/core/utiles/snackbar.dart';
import 'package:getdealss/features/admin/cubit/admin_cubit.dart';
import 'package:getdealss/features/admin/cubit/admin_state.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/utiles/styles/text_style.dart';
import '../add_project/domain/post_model.dart';
import '../register/domain/entities/user_model.dart';
import '../service_provider/presentation/widgets/build_head_tab.dart';

class AdminScreen extends StatelessWidget {
  AdminScreen({super.key});
  var result;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (context, state) {
        if (state is StartUploadBanner) {
          showDialog(
            context: context,
            builder: (context) => Center(
              child: Container(
                height: 10,
                width: 100,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        if (state is EndUploadBanner) {
          Navigator.pop(context);
          CustomSnackBar().showSuccessSnackBar(
              message: 'تم الاضافة بنجاح', context: context);
        }
      },
      builder: (context, state) {
        var cubit = AdminCubit.get(context);
        return Scaffold(
          body: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (cubit.result != null)
                Container(
                  height: 163,
                  width: 272,
                  child: Image.file(File(AdminCubit.get(context).result!.path)),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildHeadTab(
                    txt: "Add Banner",
                    onPressed: () async {
                      await AdminCubit.get(context).selectImage();
                    },
                  ),
                  buildHeadTab(
                    txt: "Upload Banner",
                    onPressed: () async {
                      await cubit.upload();
                    },
                  ),
                ],
              ),
              buildHeadTab(
                txt: "notify",
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    isDismissible: true,
                    elevation: 7,
                    builder: (context) => BlocConsumer<AdminCubit, AdminState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        var controlle = TextEditingController();
                        final query = FirebaseFirestore.instance
                            .collection('notifyProjects');
                        return FirestoreQueryBuilder(
                          query: query,
                          pageSize: 10,
                          builder: (context, snapshot, _) {
                            if (snapshot.isFetching) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text(
                                'Some Thing Wrong',
                                style: t4420BlackText(),
                              ));
                            } else {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.75,
                                width: double.infinity,
                                child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      if (snapshot.isFetching) {
                                        return CircularProgressIndicator();
                                      } else if (snapshot.docs.isEmpty) {
                                        return Text('لا يوجد داتا حتى الان');
                                      }
                                      return Container(
                                          color: Colors.grey[300],
                                          //  height: 60,
                                          width: double.infinity,
                                          child: ListTile(
                                            leading: Text(snapshot.docs[index]
                                                .get('formatDate')),
                                            trailing: Text(snapshot.docs[index]
                                                .get('senderName')),
                                            subtitle: Text(snapshot.docs[index]
                                                .get('receiverId')),
                                            title: Text(snapshot.docs[index]
                                                .get('projectName')),
                                          ));
                                    },
                                    separatorBuilder: (context, index) =>
                                        Divider(),
                                    itemCount: snapshot.docs.length),
                              );
                            }
                          },
                        );
                      },
                    ),
                  );
                },
              ),
              buildHeadTab(
                txt: "support",
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    isDismissible: true,
                    elevation: 7,
                    builder: (context) => BlocConsumer<AdminCubit, AdminState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        var controlle = TextEditingController();
                        final query =
                            FirebaseFirestore.instance.collection('support');
                        return FirestoreQueryBuilder(
                          query: query,
                          pageSize: 10,
                          builder: (context, snapshot, _) {
                            if (snapshot.isFetching) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text(
                                'Some Thing Wrong',
                                style: t4420BlackText(),
                              ));
                            } else {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.75,
                                width: double.infinity,
                                child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      if (snapshot.isFetching) {
                                        return CircularProgressIndicator();
                                      } else if (snapshot.docs.isEmpty) {
                                        return Text('لا يوجد داتا حتى الان');
                                      }
                                      return Container(
                                          color: Colors.grey[300],
                                          //  height: 60,
                                          width: double.infinity,
                                          child: ListTile(
                                            leading: Text(snapshot.docs[index]
                                                .get('formatDate')),
                                            subtitle: Text(snapshot.docs[index]
                                                .get('orderMsg')),
                                            title: Text(snapshot.docs[index]
                                                .get('senderName')),
                                          ));
                                    },
                                    separatorBuilder: (context, index) =>
                                        Divider(),
                                    itemCount: snapshot.docs.length),
                              );
                            }
                          },
                        );
                      },
                    ),
                  );
                },
              ),
              buildHeadTab(
                txt: "orders",
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    isDismissible: true,
                    elevation: 7,
                    builder: (context) => BlocConsumer<AdminCubit, AdminState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        var controlle = TextEditingController();
                        final query =
                            FirebaseFirestore.instance.collection('orders');
                        return FirestoreQueryBuilder(
                          query: query,
                          pageSize: 10,
                          builder: (context, snapshot, _) {
                            if (snapshot.isFetching) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text(
                                'Some Thing Wrong',
                                style: t4420BlackText(),
                              ));
                            } else {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.75,
                                width: double.infinity,
                                child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      if (snapshot.isFetching) {
                                        return CircularProgressIndicator();
                                      } else if (snapshot.docs.isEmpty) {
                                        return Text('لا يوجد داتا حتى الان');
                                      }
                                      return Container(
                                          color: Colors.grey[300],
                                          //  height: 60,
                                          width: double.infinity,
                                          child: ListTile(
                                            leading: Text(snapshot.docs[index]
                                                .get('formatDate')),
                                            title: Text(snapshot.docs[index]
                                                .get('senderName')),
                                            subtitle: Text(snapshot.docs[index]
                                                .get('orderMsg')),
                                          ));
                                    },
                                    separatorBuilder: (context, index) =>
                                        Divider(),
                                    itemCount: snapshot.docs.length),
                              );
                            }
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          )),
        );
      },
    );
  }
}
