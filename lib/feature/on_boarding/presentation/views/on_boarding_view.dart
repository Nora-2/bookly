// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:async';
import 'package:bookly_app/feature/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
class OnBoardingView extends StatefulWidget {
  const OnBoardingView({ Key ?key}) : super(key: key);
  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}
class _OnBoardingViewState extends State<OnBoardingView> {
  bool isOut = false;
  int index = 0;
  double width(context)=>MediaQuery.of(context).size.width;
  double height(context)=>MediaQuery.of(context).size.height;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor:Colors.white,
        automaticallyImplyLeading:false,
      ),
      backgroundColor:Colors.white,
      body:SafeArea(child:
      Column(
        children:
        [
          SizedBox(
            width:width(context),
            height:height(context)*.5,
            child:AnimatedScale
              (
                scale:isOut?0:1,
                duration:Duration(milliseconds:250),
                child:Image.asset(images[index]),
              ),
          ),
          Expanded(child:Stack(
            children:
            [
              AnimatedPositioned(
                duration:Duration(milliseconds:250),
                left:isOut? width(context)+100:width(context)*.08,
                child:Text(titles[index],style:TextStyle(color:Colors.black,
                    fontSize:20,
                    fontWeight:FontWeight.bold),),),
            ],
          ),),
          Expanded(child:Stack(
            children:
            [
              AnimatedPositioned(
                duration:Duration(milliseconds:250),
                right:isOut? width(context)+100:0,
                child:SizedBox(
                  width:width(context),
                  child:Padding(padding:EdgeInsets.only(left:28),
                    child:Text(descriptions[index],style:TextStyle(color:Colors.grey,
                      fontSize:18,
                      fontWeight:FontWeight.bold),),),
                ),),
            ]
          ),),
          Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children:
            [
              CustomIndicator(active:index==0),
              SizedBox(width:5,),
              CustomIndicator(active:index==1),
              SizedBox(width:5,),
              CustomIndicator(active:index==2),
            ],
          ),
          Padding(padding:EdgeInsets.all(30.0),
            child:Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children:
              [
                InkWell(
                  child:Text('Skip',
                    style:TextStyle(color:Colors.blue,
                      fontSize:20.0,
                      fontWeight:FontWeight.bold),
                  ),
                  onTap:()
                  {
                    Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>HomeView(),),);
                  },
                ),
                IconButton(onPressed:()
                {
                  if(index == 2)
                  {
                    Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>HomeView(),),);
                  }
                  else
                  {
                    setState(() {
                      isOut =! isOut;
                    });
                  }
                  Timer(Duration(milliseconds:300),
                          ()
                      {
                        index = index>1?0:index+1;
                        setState(() {
                          isOut =! isOut;
                        });
                      }
                  );
                }, icon:Container(
                  padding:EdgeInsets.all(15.0),
                  decoration:BoxDecoration(
                    color:Colors.blue,
                    borderRadius:BorderRadius.circular(30.0),
                  ),
                  child:Text('Next',
                    style:TextStyle(fontSize:18.0,
                        color:Colors.white,
                        fontWeight:FontWeight.bold),),
                )),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
List titles =
[
    "Reading is the Key to Knowledge",
    "Regular Reading Boosts the Mind",
    "Books for Every Interest & Style",
];
List descriptions =
[
    "Learn through books and benefit from the experiences and insights of others.",
    "Check out the bestsellers and most loved reads of the month.",
    "From novels to biographies , explore genres that pique your interest.",
];
List images =
[
    "assets/images/bookreading.png",
    "assets/images/redingtime.png",
    "assets/images/readinglist.png",
];
class CustomIndicator extends StatelessWidget {
  final bool active;
  const CustomIndicator({ Key ?key , required this.active}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(duration:Duration(milliseconds:250),
      decoration:BoxDecoration(
        borderRadius:BorderRadius.circular(100.0),
        color:active?Colors.blue:Colors.grey,
      ),
      width:active?30:10,
      height:10,
    );
  }
}