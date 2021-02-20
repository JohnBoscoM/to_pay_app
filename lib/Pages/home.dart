import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:to_pay_app/budget/payments/addPayment_page.dart';
import 'package:to_pay_app/model_providers/theme_provider.dart';
import 'package:to_pay_app/models/bill.dart';
import 'package:to_pay_app/models/user.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final paymentBox = Hive.box('paymentBox');

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
  int totalAmount() {
    double amount = 0;
    paymentBox.toMap().forEach((key, value) {
        amount+= value.cost;
    });
    return amount.truncate();
  }
  int totalUnPaidAmount() {
    double amount = 0;
    paymentBox.toMap().forEach((key, value) {
      if (value.isChecked == false){
        amount+= value.cost;
      }

    });
    return amount.truncate();
  }
  int totalPaidAmount() {
    double amount = 0;
    paymentBox.toMap().forEach((key, value) {
      if (value.isChecked == true){
        amount+= value.cost;
      }

    });
    return amount.truncate();
  }

  int totalMissedAmount() {
    double amount = 0;
    paymentBox.toMap().forEach((key, value) {
      if (value.deadline.isBefore(new DateTime.now()) &&
          value.isChecked == false){
        amount = value.cost;
      }
    });
    return amount.truncate();
  }

  int unpaidBillsCount() {
    var count = 0;
    paymentBox.toMap().forEach((key, value) {
      if (value.isChecked == false){
        count++;
      }

    });
    return count;
  }
  int paidBillsCount() {
    var count = 0;
    paymentBox.toMap().forEach((key, value) {
      if (value.isChecked == true){
        count++;
      }

    });
    return count;
  }

  int missedBillsCount() {
    var count = 0;
    paymentBox.toMap().forEach((key, value) {
      if (value.deadline.isBefore(new DateTime.now()) &&
          value.isChecked == false){
        count++;
      }
    });
    return count;
  }




  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final _width = MediaQuery.of(context).size.width;
    Text status(String name) {
      if(name == "Paid"){
       return  Text(
         'Total ' + name + " " + paidBillsCount().toString(),
         style: TextStyle(
             color: themeProvider.themeMode().textColor,
             fontSize: 15,
             fontFamily: 'avenir',
             fontWeight: FontWeight.w700),

       );
      }
      if(name == "UnPaid"){
        return  Text(
          'Total ' + name + " " + unpaidBillsCount().toString(),
          style: TextStyle(
              color: themeProvider.themeMode().textColor,
              fontSize: 15,
              fontFamily: 'avenir',
              fontWeight: FontWeight.w700),
        );
      }
      if(name == "Missed"){
        return  Text(
          'Total ' + name + " " + missedBillsCount().toString(),
          style: TextStyle(
              color: themeProvider.themeMode().textColor,
              fontSize: 15,
              fontFamily: 'avenir',
              fontWeight: FontWeight.w700),
        );
      }
      return Text("Status");
    };
    return Scaffold(
      backgroundColor: themeProvider.themeMode().blendBackgroundColor,
      //appBar: AppBar(
      //   backgroundColor: themeProvider.themeMode().appColor,
      //   elevation: 0,
      //   leading: Container(
      //       padding: EdgeInsets.only(top: 0, left: 10),
      //       child: Icon(
      //         Icons.menu_rounded,
      //         size: 30,
      //         color: Colors.white,
      //       )),
      //   actions: [
      //     Icon(
      //       Icons.notifications_none_rounded,
      //       size: 30,
      //       color: Colors.white,
      //     )
      //   ],
      // ),
      body: Container(
        //padding: EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                //color: themeProvider.themeMode().appColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35)),
                gradient: LinearGradient(
                    colors: themeProvider.themeMode().backgroundGradient,
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
                      Container(
                        padding: EdgeInsets.only(top: 30),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.menu_rounded,
                                size: 40,
                                color: Colors.white,
                              ),
                            ]),
                      ),
                      SizedBox(
                        height: 60,
                      ),

                      Text(
                        "Overview",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            fontFamily: "avenir"),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Total Expenses: " + totalAmount().toString() + " kr",
                        style: TextStyle(
                            color: Colors.amber,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            fontFamily: "avenir"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Paid: " + totalPaidAmount().toString() + " kr",
                        style: TextStyle(
                            color: Colors.amber,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            fontFamily: "avenir"),
                      ),

                      // SizedBox(
                      //   height: 15,
                      // ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      height: 250,
                      width: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage("assets/images/urban-overview.png"),
                            alignment: Alignment.bottomRight,
                            fit: BoxFit.scaleDown),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Status",
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'avenir'),
                  ),
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
            SingleChildScrollView(
              padding: EdgeInsets.all(15),
              scrollDirection: Axis.horizontal,
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
                  avatarWidget("missed", status("Missed"), themeProvider,
                      themeProvider.themeMode().missedGradient),
                  avatarWidget("upcoming", status("UnPaid"), themeProvider,
                      themeProvider.themeMode().unpaidGradient),
                  avatarWidget("payed", status("Paid"), themeProvider,
                      themeProvider.themeMode().paidGradient),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    'UnPaid Bills',
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'avenir'),
                  ),
                ),
                Container(
                  height: 60,
                  width: 60,
                  child: Icon(Icons.list_rounded),
                )
              ],
            ),

            buildList(themeProvider),

            // child: GridView.count(
            //   crossAxisCount: 3,
            //   childAspectRatio: 0.72,
            //   children: [
            //     serviceWidget("house", "House\n", themeProvider),
            //     serviceWidget("food_1", "Food\n", themeProvider),
            //     serviceWidget("train", "Transport\n", themeProvider),
            //     serviceWidget("education", "Education\n", themeProvider),
            //     serviceWidget("car", "Car\n", themeProvider),
            //     serviceWidget("bulb", "Electricity\n", themeProvider),
            //     serviceWidget("fitness", "Fitness\n", themeProvider),
            //     serviceWidget("piggy_bank", "Savings\n", themeProvider),
            //     serviceWidget("clothes", "Clothes\n", themeProvider),
            //     serviceWidget("fun", "Fun\n", themeProvider),
            //     serviceWidget(
            //         "entertainment", "Entertainment\n", themeProvider),
            //     serviceWidget("more_icon", "More\n", themeProvider),
            //   ],
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple[600],
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {},
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

  Widget buildList(ThemeProvider themeProvider) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: themeProvider.themeMode().blendBackgroundColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        ),
        child: ListView.builder(
          itemCount: paymentBox.length,
          itemBuilder: (context, index) {
            final paymentItem = paymentBox.get(index);
            if (paymentItem.isChecked == false) {
              return Container(
                margin: new EdgeInsets.only(
                    left: 20.0, top: 0, right: 20.0, bottom: 15),
                child: new Container(
                  decoration: BoxDecoration(
                    color: themeProvider
                        .themeMode()
                        .color,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  padding: new EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      new ListTile(
                        onLongPress: () {},
                        leading: Container(
                          height: 70,
                          width: 70,
                          margin: EdgeInsets.only(right: 0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: themeProvider
                                .categoryIcon(paymentItem.category)
                                .color,
                          ),
                          child: Icon(
                            themeProvider
                                .categoryIcon(paymentItem.category)
                                .icon,
                            size: 30,
                          ),
                        ),

                        // Checkbox(
                        //     value: paymentItem.isChecked,
                        //     onChanged: (bool value) {
                        //       setState(() {
                        //         paymentItem.isChecked = value;
                        //       });
                        //     }),
                        isThreeLine: false,
                        dense: true,
                        //font change
                        contentPadding: EdgeInsets.all(1),
                        title: Text(
                          paymentItem.title,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              fontFamily: "avenir",
                              letterSpacing: 0.5),
                          textAlign: TextAlign.left,
                        ),
                        subtitle: Container(
                          child: Text(
                            paymentItem.deadline.toString().substring(0, 10),
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: "avenir",
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5),
                            textAlign: TextAlign.left,
                          ),
                        ),

                        trailing: Text(
                          paymentItem.cost.truncate().toString() + " kr",
                          style: TextStyle(
                              color: Colors.amber,
                              fontSize: 16,
                              fontFamily: "avenir",
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5),
                        ),

                        // onChanged: (bool val) {
                        //   itemChange(val, index);
                        // }
                      ),
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Container avatarWidget(String img, Text textWidget, ThemeProvider themeProvider,
      List<Color> statusColor) {
    return Container(
      margin: EdgeInsets.only(right: 10, left: 10),
      height: 180,
      width: 170,
      decoration: BoxDecoration(
        color: themeProvider.themeMode().color,
        boxShadow: themeProvider.themeMode().itemShadow,
        //  gradient: LinearGradient(
        //    colors:statusColor
        //    ),
        borderRadius: BorderRadius.all(Radius.circular(15)),

        // color: Colors.grey[900]
        //Color(0xfff1f3f6)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        Text(
        "Total 159 kr",
        style: TextStyle(
            color: Colors.amber[700],
            fontSize: 15,
            fontFamily: 'avenir',
            fontWeight: FontWeight.w700),
      ),
          Container(
            height: 120,
            width: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,

              image: DecorationImage(
                  image: AssetImage('assets/images/$img.png'),
                  fit: BoxFit.contain),
              //border: Border.all(color: Colors.grey[500], width: 2)
            ),
          ),
          // Text(
          //   name,
          //   style: TextStyle(
          //       fontSize: 13,
          //       fontFamily: 'avenir',
          //       fontWeight: FontWeight.w700),
          // ),
          textWidget,
        ],
      ),
    );
  }
}
