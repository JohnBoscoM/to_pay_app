import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.all(50),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: 30),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Icon(
                //   CupertinoIcons.bell_fill,
                //   size: 40,
                //   color: Colors.white,
                // ),
              ]),
        ),
        SizedBox(
          height: 0,
        ),

        Text(
          "New Payment",
          style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w700,
              fontFamily: "avenir"),
        ),
        SizedBox(
          height: 0,
        ),
      ],
    ),
        Expanded(
        child: Container(
          margin: EdgeInsets.only(left: 20, top: 25),
          height: 60,
          width: 10,
          decoration: BoxDecoration(
            image: DecorationImage(
                image:
                AssetImage("assets/images/card.png"),
                alignment: Alignment.bottomRight,
                fit: BoxFit.scaleDown),
          ),
        ),
        ),
      ],
      ),
    );
  }
}
