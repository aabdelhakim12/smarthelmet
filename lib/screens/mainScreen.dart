import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trialapp/screens/signin.dart';
import 'history/custom.dart';
import 'location.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/mainscr';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController pageController = new PageController();
  int pageIndex = 0;

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 200),
      curve: Curves.bounceOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            FlatButton(
              child: Icon(Icons.logout),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(SignInScreen.routeName);
              },
            )
          ],
          title: Text(
            'Smart helmet',
            style: TextStyle(
              color: Colors.white,
              fontSize: 45,
              fontFamily: 'Signatra',
            ),
          ),
          bottom: TabBar(
            indicatorColor: Colors.purple[50],
            tabs: [
              Tab(
                // icon: Icon(Icons.list),
                text: 'Temperature detection',
              ),
              Tab(
                icon: Icon(Icons.location_on),
                text: 'location',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CustomDatabase(),
            Location(),
          ],
        ),
      ),
    );
  }
}
