import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../add_project/domain/post_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  static SearchCubit get(context) => BlocProvider.of(context);
  bool isSearch = false;
  String filterBy = '';
  String filterText = 'null';
  late Query<ProjectModel> query;
  late Query<ProjectModel> queryFilterKind;
  getQuery(String value) {
    emit(StartSearchState());

    filterText = value;
    query = FirebaseFirestore.instance
        .collection('projects')
        .where('projectDescription',
            isGreaterThanOrEqualTo: value, isLessThanOrEqualTo: '$value\uf7ff')
        .withConverter<ProjectModel>(
          fromFirestore: (snapshot, _) =>
              ProjectModel.fromJson(snapshot.data()!),
          toFirestore: (project, _) => project.toJson(),
        );
    isSearch = true;
    value = '';
    emit(EndSearchState());
  }
}
