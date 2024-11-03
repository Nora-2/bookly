// ignore_for_file: prefer_const_constructors
import 'package:bookly_app/core/utils/assets.dart';
import 'package:bookly_app/feature/search/presentation/views/search_view.dart';
import 'package:flutter/material.dart';
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 10, top: 40),
      child: Row(
        children: [
          Image(image: AssetImage(AssetsData.logo), height: 25),
          Spacer(),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchView()),
              );
            },
            icon: Icon(Icons.search, size: 30, color: Colors.white),
          ),
        ],
      ),
    );
  }
}