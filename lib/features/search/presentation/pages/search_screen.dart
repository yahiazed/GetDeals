import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:getdealss/config/app_localization.dart';

import '../../../../core/utiles/colors/my_color.dart';
import '../../../../core/utiles/shared_widget/action.dart';
import '../../../../core/utiles/shared_widget/double_border.dart';
import '../../../../core/utiles/shared_widget/input_field.dart';
import '../../../../core/utiles/shared_widget/leading.dart';
import '../../../../core/utiles/shared_widget/shaps.dart';
import '../../../../core/utiles/shared_widget/title.dart';
import '../../../../core/utiles/styles/text_style.dart';
import '../../../add_project/domain/post_model.dart';
import '../../../register/domain/entities/user_model.dart';
import '../cubit/search_cubit.dart';
import '../widgets/search_suffix.dart';

class SearchScreen extends StatelessWidget {
  UserModel user;
  SearchScreen({super.key, required this.user});
  String filterBy = '';
  var searchController = TextEditingController();
  var searchFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

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
              txt: "home".tr(context),
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
                      img: user.photo!,
                    ),
                    title: Text(
                      'أهلا. ${user.name} ',
                      style: const TextStyle(
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
          body: BlocProvider(
            create: (context) => SearchCubit(),
            child: BlocConsumer<SearchCubit, SearchState>(
              listener: (context, state) {},
              builder: (context, state) {
                var cubit = SearchCubit.get(context);

                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: searchFormKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 26.0, vertical: 26),
                          child: InputField(
                            hintTxt: "searchHere",
                            controller: searchController,
                            textInputType: TextInputType.text,
                            sufix: SharedSearchSuffix(
                              filterBy: cubit.filterBy,
                              onSearch: () {
                                if (searchFormKey.currentState!.validate()) {
                                  cubit.getQuery(searchController.text);
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        cubit.isSearch
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Container(
                                  height: 500,
                                  child: FirestoreQueryBuilder(
                                      query: cubit.query,
                                      pageSize: 3,
                                      builder: (context, snapshot, _) {
                                        if (snapshot.isFetching) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        } else if (snapshot.docs.isEmpty) {
                                          return const Text('Not Founded');
                                        }
                                        return GridView.builder(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            gridDelegate:
                                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                                    maxCrossAxisExtent: 200,
                                                    childAspectRatio: 0.7,
                                                    crossAxisSpacing: 20,
                                                    mainAxisSpacing: 20),
                                            itemCount: snapshot.docs.length,
                                            itemBuilder: (context, index) {
                                              final project =
                                                  snapshot.docs[index].data();
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10.0),
                                                child: Container(
                                                  width: 181,
                                                  height: 208,
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  decoration: BoxDecoration(
                                                    color: Colord.bla,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(11),
                                                    ),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                        project.imgUrls
                                                            .split(',')
                                                            .first,
                                                      ),
                                                      opacity: 0.75,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          project.projectName,
                                                          style:
                                                              nameMeduim16white(),
                                                        ),
                                                        Text(
                                                          "المبلغ:${project.projectSumSales} ريال",
                                                          style:
                                                              txtMeduim13white(),
                                                        ),
                                                      ]),
                                                ),
                                              );
                                            });
                                      }),
                                ),
                              )
                            : const Text('Not Founded'),
                      ],
                    ),
                  ),
                );
              },
            ),
          )),
    );
  }
}
