import 'package:bookly_app/feature/home/data/models/book_model/book_model.dart';
abstract class HomeStates {}
class InitialState extends HomeStates {}
class HomeLoadingState extends HomeStates {}
class HomeSuccessState extends HomeStates {
  final List<BookModel> books;
  HomeSuccessState({required this.books});
}
class HomeErrorState extends HomeStates {
  final String error;

  HomeErrorState({required this.error});
}