import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Overview",
              style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  fontFamily: 'avenir'),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.grey[900]
                //Color(0xfff1f3f6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "24,240",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w700, fontFamily: "ubuntu",color: Colors.white),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Current Balance",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400,color: Colors.white,fontFamily: "avenir"),
                      )
                    ],
                  ),
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.deepOrange[400]
                        //Color(0xffffac30)
                        ),
                    child: Icon(
                      Icons.add,
                      size: 30,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Status",
                  style: TextStyle(
                    color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'avenir'),
                ),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      // image: DecorationImage(
                      //   image: AssetImage('asset/images/scanqr.png')
                      // )
                      ),
                )
              ],
            ),
            Container(
              //scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // Container(
                  //   height: 70,
                  //   width: 70,
                  //   margin: EdgeInsets.only(right: 20),
                  //   decoration: BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     color: Color(0xffffac30),
                  //   ),
                  //   child: Icon(
                  //     Icons.add,
                  //     size: 40,
                  //   ),
                  // ),
                  avatarWidget("upcoming_pay", "Upcoming Bills"),
                  avatarWidget("check_bill", "Payed Bills"),
                  avatarWidget("missed-bills-color", "Missed Bills"),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'avenir'),
                ),
                Container(
                  height: 60,
                  width: 60,
                  child: Icon(Icons.dialpad),
                )
              ],
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                childAspectRatio: 0.72,
                children: [
                  serviceWidget("house", "House\n"),
                  serviceWidget("food_1", "Food\n"),
                  serviceWidget("train", "Transport\n"),
                  serviceWidget("education", "Education\n"),
                  serviceWidget("car", "Car\n"),
                  serviceWidget("bulb", "Electricity\n"),
                  serviceWidget("fitness", "Fitness\n"),
                  serviceWidget("piggy_bank", "Savings\n"),
                  serviceWidget("clothes", "Clothes\n"),
                  serviceWidget("fun", "Fun\n"),
                  serviceWidget("entertainment", "Entertainment\n"),
                  serviceWidget("more_icon", "More\n"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Column serviceWidget(String img, String name) {
    return Column(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color:Colors.grey[900]
                // Color(0xfff1f3f6),
              ),
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/$img.png'))),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          name,
          style: TextStyle(
            fontFamily: 'avenir',
            fontSize: 14,
            color: Colors.white
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Container avatarWidget(String img, String name) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      height: 115,
      width: 107.1,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.grey[900]
          //Color(0xfff1f3f6)
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                image: DecorationImage(
                    image: AssetImage('assets/images/$img.png'),
                    fit: BoxFit.contain),
                //border: Border.all(color: Colors.grey[500], width: 2)
                ),
          ),
          Text(
            name,
            style: TextStyle(
                fontSize: 13,
                fontFamily: 'avenir',
                color: Colors.white,
                fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}
