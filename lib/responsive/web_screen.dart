import 'package:flutter/material.dart';
// import 'package:instagram_clone/screens/add_post_screen.dart';
import 'package:instagram_clone/screens/feed_screen.dart';
// import 'package:instagram_clone/screens/profile_screen.dart';
// import 'package:instagram_clone/screens/search_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/const.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  int _page = 0;
  late PageController pagecontroller;
  @override
  void initState() {
    super.initState();
    pagecontroller = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pagecontroller.dispose();
  }

  void navigationTapped(int page) {
    pagecontroller.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      //upadte the page variable
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: Align(
          alignment: const FractionalOffset(0.6, 0),
          child: Image.asset(
            'lib/assets/instagram-removebg-preview.png',
            // fit: BoxFit.cover,
            height: 80,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                navigationTapped(0);
              },
              icon: Icon(
                Icons.home,
                color: _page == 0 ? primaryColor : secondaryColor,
              )),
          IconButton(
              onPressed: () {
                navigationTapped(1);
              },
              icon: Icon(
                Icons.search,
                color: _page == 1 ? primaryColor : secondaryColor,
              )),
          IconButton(
              onPressed: () {
                navigationTapped(2);
              },
              icon: Icon(
                Icons.add_a_photo,
                color: _page == 2 ? primaryColor : secondaryColor,
              )),
          IconButton(
              onPressed: () {
                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const (),));
                navigationTapped(3);
              },
              icon: Icon(
                Icons.favorite,
                color: _page == 3 ? primaryColor : secondaryColor,
              )),
          IconButton(
              onPressed: () {
                navigationTapped(4);
              },
              icon: Icon(
                Icons.person,
                color: _page == 4 ? primaryColor : secondaryColor,
              )),
        ],
      ),
      body: PageView(
        controller: pagecontroller,
        onPageChanged: onPageChanged,
        children: homescreenItems,
      ),
    );
  }
}
