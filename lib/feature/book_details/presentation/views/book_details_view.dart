// ignore_for_file: use_super_parameters, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bookly_app/constant.dart';
import 'package:bookly_app/feature/home/data/models/book_model/book_model.dart';
class BookDetailView extends StatelessWidget {
  final BookModel book;
  const BookDetailView({required this.book, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        backgroundColor: kPrimaryColor,
        title: Text(
          book.volumeInfo.title ?? 'Book Details',
          style: TextStyle(color: Colors.white),
          maxLines: 1,
        ),
      ),
      body: SingleChildScrollView(
        physics:BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(book.volumeInfo.imageLinks?.thumbnail ?? ''),
            SizedBox(height: 16),
            Text(
              book.volumeInfo.title ?? 'No Title',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              'Author: ${book.volumeInfo.authors?.join(', ') ?? 'Unknown Author'}',
              style: TextStyle(fontSize: 18, color: Colors.yellowAccent),
            ),
            SizedBox(height: 8),
            Text(
              'Publisher: ${book.volumeInfo.publisher ?? 'Unknown Publisher'}',
              style: TextStyle(fontSize: 18, color: Colors.yellowAccent),
            ),
            SizedBox(height: 8),
            Text(
              'Description: ${book.volumeInfo.description ?? 'No Description'}',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                // Check if the book has a preview link or PDF link
                String? pdfLink = book.volumeInfo.previewLink;
                if (pdfLink != null) {
                  // Open the PDF using the url_launcher package
                  if (await canLaunch(pdfLink)) {
                    await launch(pdfLink);
                  } else {
                    // Show error if the PDF cannot be opened
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Could not open the PDF")),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("No PDF available")),
                  );
                }
              },
              icon: Icon(Icons.picture_as_pdf, color: Colors.white),
              label: Text("Open PDF", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent, // Background color
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded edges
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}