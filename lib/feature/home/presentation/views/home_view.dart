// ignore_for_file: prefer_const_constructors
import 'package:bookly_app/constant.dart';
import 'package:bookly_app/feature/book_details/presentation/views/book_details_view.dart';
import 'package:bookly_app/feature/home/cubit/home_states.dart';
import 'package:bookly_app/feature/home/presentation/widgets/custom_app_bar.dart';
import 'package:bookly_app/feature/home/presentation/widgets/custom_list_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookly_app/feature/home/cubit/home_cubit.dart';
class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  _HomeViewState createState() => _HomeViewState();
}
class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }
  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      // Trigger fetching more books when user scrolls to the end
      BlocProvider.of<HomeCubit>(context).fetchMoreBooks();
    }
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        children: [
          CustomAppBar(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: BlocBuilder<HomeCubit, HomeStates>(
                builder: (context, state) {
                  if (state is HomeLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is HomeErrorState) {
                    return Center(child: Text('Error: ${state.error}'));
                  } else if (state is HomeSuccessState) {
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: state.books.length + (BlocProvider.of<HomeCubit>(context).isLoadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == state.books.length) {
                          // Show the progress indicator only if more books are being loaded
                          return Center(child: CircularProgressIndicator());
                        }
                        final book = state.books[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookDetailView(book: book),
                              ),
                            );
                          },
                          child: CustomListViewItem(
                            title: book.volumeInfo.title ?? 'No Title',
                            author: book.volumeInfo.authors?.join(', ') ?? 'Unknown Author',
                            imageUrl: book.volumeInfo.imageLinks?.thumbnail ?? '',
                          ),
                        );
                      },
                    );
                  }
                  return SizedBox.shrink(); // Return an empty widget for initial state
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}