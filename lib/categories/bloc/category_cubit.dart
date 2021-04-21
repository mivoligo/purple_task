import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/model/category.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryState.initial());

  void updateName({required String name}) {}
}
