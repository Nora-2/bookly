// ignore_for_file: prefer_const_constructors
import 'package:bookly_app/constant.dart';
import 'package:bookly_app/feature/splash/presentation/widgets/splash_view_body.dart';
import 'package:flutter/material.dart';
class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:kPrimaryColor,
      body:SplashViewBody(),
    );
  }
}