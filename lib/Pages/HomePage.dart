import 'package:flutter/material.dart';
import 'package:flutter_app/Pages/FilesPage.dart';
import 'package:flutter_app/Pages/ProfilePage.dart';
import 'package:flutter_app/Pages/UploadPage.dart';
import 'package:flutter/cupertino.dart';
class HomePagee extends StatefulWidget {
  // const HomePagee() : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePagee> {
  int page=0;
  var myColor = const Color(0xff3d4ebc); //blue color
  PageController pageController= PageController();

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      this.page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffd460),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: CupertinoTabBar(
        onTap: navigationTapped,
        currentIndex: page,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home,color: page==0?myColor:Colors.grey[700],),),
          BottomNavigationBarItem(icon: Icon(Icons.upload_file,color: page==1?myColor:Colors.grey[700],)),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_rounded,color: page==2?myColor:Colors.grey[700],)),
      ],),
      body: PageView(
        physics: BouncingScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: [
          Container(
            child: FilesPage(),
          ),
          Container(
            child: UploadPage(),
          ),
          Container(
            child: ProfilePage(),
          ),
        ],
      ),
    );
  }
}
