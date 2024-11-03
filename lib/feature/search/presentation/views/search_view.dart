// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
import 'package:bookly_app/constant.dart';
import 'package:bookly_app/feature/book_details/presentation/views/book_details_view.dart';
import 'package:bookly_app/feature/home/cubit/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookly_app/feature/home/cubit/home_cubit.dart';
import 'package:bookly_app/feature/home/presentation/widgets/custom_list_view_item.dart';
class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}
class _SearchViewState extends State<SearchView> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    // Clear previous search results when opening the search view
    BlocProvider.of<HomeCubit>(context).emit(InitialState());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          "Search Books",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              style: TextStyle(color: Colors.white), // Set text color to white
              decoration: InputDecoration(
                labelText: 'Enter book title',
                labelStyle: TextStyle(color: Colors.white), // Label color
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Border color
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Focused border color
                ),
              ),
              onSubmitted: (query) {
                // Clear previous search result before starting new search
                BlocProvider.of<HomeCubit>(context).emit(InitialState());
                // Set to loading state and trigger the search
                BlocProvider.of<HomeCubit>(context).searchBooks(query);
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<HomeCubit, HomeStates>(
                builder: (context, state) {
                  if (state is HomeLoadingState) {
                    // Display loading spinner
                    return Center(child: CircularProgressIndicator());
                  } else if (state is HomeErrorState) {
                    // Show error message
                    return Center(child: Text('Error: ${state.error}'));
                  } else if (state is HomeSuccessState) {
                    // If there are no books, show a message
                    if (state.books.isEmpty) {
                      return Center(child: Text('No books found'));
                    }
                    // Display only the first book in the results
                    final book = state.books.first;
                    return GestureDetector(
                      onTap: () {
                        // Navigate to book detail when tapped
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
                  }
                  // Show nothing if in the initial state
                  if (state is InitialState) {
                    return SizedBox.shrink(); // Return an empty widget
                  }
                  // Default return if no other state matches
                  return SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}