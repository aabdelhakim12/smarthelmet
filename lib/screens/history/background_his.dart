import 'package:flutter/material.dart';

class BackgroundHis extends StatelessWidget {
  final Widget child;
  const BackgroundHis({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.purple[50],
      height: size.height,
      width: size.width,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            child: Image.asset(
              "assets/images/Background01.png",
              width: size.width * 0.6,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
