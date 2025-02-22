// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
class SlidingText extends StatelessWidget {
  const SlidingText({Key? key,    required this.slidingAnimation,
  }) : super(key: key);

  final Animation<Offset> slidingAnimation;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation:slidingAnimation, builder:(context,_)
    {
      return SlideTransition(position:slidingAnimation,
        child: Text('Read Free Books',textAlign:TextAlign.center,style:TextStyle(fontWeight:FontWeight.bold,fontSize:18.0,color:Colors.white),),);
    });
  }
}