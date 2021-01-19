import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:to_pay_app/budget/payments/addPayment_page.dart';
import 'package:to_pay_app/model_providers/theme_provider.dart';
import 'package:to_pay_app/models/user.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Box _userBox;
  //User user;
  final usernameController = TextEditingController();
  final incomeController = TextEditingController();

  // @override
  // Future<void> initState() {
  //   super.initState();
  //   Hive.registerAdapter(UserAdapter());
  //   _openBox();
  // }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    incomeController.dispose();
    super.dispose();
  }

  Future _openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    _userBox = await Hive.openBox('userBox');
    return;
  }

  String getUserName() {
    return _userBox.get('username');
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
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
                  //color: Colors.white,
                  fontFamily: 'avenir'),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                gradient: LinearGradient(
                    colors: themeProvider.themeMode().gradient,
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight),
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
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            fontFamily: "ubuntu"),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Current Balance",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: "avenir"),
                      )
                    ],
                  ),
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          colors: themeProvider.themeMode().gradient,
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight),
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
                  avatarWidget("upcoming_pay", "Upcoming Bills", themeProvider),
                  avatarWidget("check_bill", "Payed Bills", themeProvider),
                  avatarWidget(
                      "missed-bills-color", "Missed Bills", themeProvider),
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
                  serviceWidget("house", "House\n", themeProvider),
                  serviceWidget("food_1", "Food\n", themeProvider),
                  serviceWidget("train", "Transport\n", themeProvider),
                  serviceWidget("education", "Education\n", themeProvider),
                  serviceWidget("car", "Car\n", themeProvider),
                  serviceWidget("bulb", "Electricity\n", themeProvider),
                  serviceWidget("fitness", "Fitness\n", themeProvider),
                  serviceWidget("piggy_bank", "Savings\n", themeProvider),
                  serviceWidget("clothes", "Clothes\n", themeProvider),
                  serviceWidget("fun", "Fun\n", themeProvider),
                  serviceWidget(
                      "entertainment", "Entertainment\n", themeProvider),
                  serviceWidget("more_icon", "More\n", themeProvider),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
      
        },
      ),
    );
  }

  Column serviceWidget(String img, String name, ThemeProvider themeProvider) {
    return Column(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                gradient: LinearGradient(
                    colors: themeProvider.themeMode().gradient,
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight),
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
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Container avatarWidget(String img, String name, ThemeProvider themeProvider) {
    return Container(
      margin: EdgeInsets.only(right: 21),
      height: 115,
      width: 107.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        gradient: LinearGradient(
            colors: themeProvider.themeMode().gradient,
            begin: Alignment.bottomLeft,
            end: Alignment.topRight),
        // color: Colors.grey[900]
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
                fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}
