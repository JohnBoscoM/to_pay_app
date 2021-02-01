import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Text(
              "Welcome",
              style: TextStyle(
                  color: Colors.white, fontSize: 40, fontFamily: "avenir"),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text("Keep track of all your expenses",
                style: TextStyle(
                    color: Colors.white, fontSize: 18, fontFamily: "avenir")),
          ),
        ],
      ),
    );
  }
}
