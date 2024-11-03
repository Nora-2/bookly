import 'package:bookly_app/core/utils/network/remote/dio_helper.dart';
import 'package:bookly_app/feature/home/cubit/home_states.dart';
import 'package:bookly_app/feature/home/data/models/book_model/book_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitialState());
  static HomeCubit get(context) => BlocProvider.of(context);
  int currentPage = 0;
  bool isLoadingMore = false;
  List<BookModel> books = [];
  List<BookModel> searchResults = []; // Store search results
  void bookData({bool isPagination = false}) async {
    if (isPagination && isLoadingMore) return; // Avoid multiple fetches
    if (!isPagination) emit(HomeLoadingState());
    try {
      if (isPagination) {
        isLoadingMore = true;
        currentPage++;
      } else {
        currentPage = 0;
      }
      final response = await DioHelper.getData(
        url: 'books/v1/volumes',
        query: {
          'q': 'programming', // Modify query as needed
          'startIndex': currentPage * 10,
          'maxResults': 10,
        },
      );
      if (response != null && response.data != null && response.data['items'] != null) {
        final newBooks = (response.data['items'] as List)
            .map((item) => BookModel.fromJson(item))
            .toList();

        if (isPagination) {
          books.addAll(newBooks);
          isLoadingMore = false;
          emit(HomeSuccessState(books: books));
        } else {
          books = newBooks;
          emit(HomeSuccessState(books: books));
        }
      } else {
        emit(HomeErrorState(error: 'No data available.'));
      }
    } catch (e) {
      emit(HomeErrorState(error: e.toString()));
    }
  }
  void fetchMoreBooks() {
    bookData(isPagination: true);
  }

  // Search books by title
  void searchBooks(String query) async {
    emit(HomeLoadingState());
    try {
      final response = await DioHelper.getData(
        url: 'books/v1/volumes',
        query: {
          'q': query,
          'maxResults': 10,
        },
      );
      if (response != null && response.data != null && response.data['items'] != null) {
        searchResults = (response.data['items'] as List)
            .map((item) => BookModel.fromJson(item))
            .toList();
        emit(HomeSuccessState(books: searchResults));
      } else {
        emit(HomeErrorState(error: 'No results found.'));
      }
    } catch (e) {
      emit(HomeErrorState(error: e.toString()));
    }
  }
}