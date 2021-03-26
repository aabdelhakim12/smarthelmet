import 'package:flutter/material.dart';
import 'screens/history/custom.dart';
import 'screens/location.dart';
import 'screens/signin.dart';

class DrawerS extends StatefulWidget {
  @override
  _DrawerSState createState() => _DrawerSState();
}

class _DrawerSState extends State<DrawerS> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            color: Theme.of(context).primaryColor,
            height: 80,
            padding: EdgeInsets.only(
              top: 25,
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Smart Helmet',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 1,
          ),
          Container(
            color: Colors.amber[700],
            child: ListTile(
              leading: Icon(Icons.list_alt_rounded),
              title: Text(
                'workers list',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(CustomDatabase.routeName);
              },
            ),
          ),
          Container(
            color: Colors.indigo[800],
            child: ListTile(
              leading: Icon(Icons.map_outlined),
              title: Text(
                'Map',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(Location.routeName);
              },
            ),
          ),
          Container(
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                'log out',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(SignInScreen.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
