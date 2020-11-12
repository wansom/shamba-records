import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:shambarecords/components/custom_surfix_icon.dart';
import 'package:shambarecords/components/paymentform.dart';
import 'package:shambarecords/constants/color_constant.dart';
import 'package:shambarecords/models/card_model.dart';
import 'package:shambarecords/models/operation_model.dart';
import 'package:shambarecords/models/transaction_model.dart';
import 'package:shambarecords/providers/user_provider.dart';

import '../constants.dart';

final Color backgroundColor = Color(0xFF4A4A58);

class HomeScreen extends StatefulWidget {
  static String routeName = "/dashboard";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final _key = GlobalKey<ScaffoldState>();
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;
  // Current selected
  int current = 0;
  String _options;
  final List<String> options = ['100', '1000', '10000', '50000'];

  // Handle Indicator
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      key: _key,
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            menu(context),
            dashboard(context),
          ],
        ),
      ),
    );
  }

  Widget menu(context) {
    final user = Provider.of<UserProvider>(context);
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Name: ${user.userModel?.name}",
                    style: TextStyle(color: Colors.white, fontSize: 22)),
                SizedBox(height: 10),
                Text("ID:${user.userModel?.idnumber} ",
                    style: TextStyle(color: Colors.white, fontSize: 22)),
                SizedBox(height: 10),
                Text("Phone: ${user.userModel?.phone}",
                    style: TextStyle(color: Colors.white, fontSize: 22)),
                SizedBox(height: 10),
                Text("Update Profile",
                    style: TextStyle(color: Colors.white, fontSize: 22)),
                SizedBox(height: 10),
                InkWell(
                  splashColor: Colors.white,
                  onTap: () {
                    user.signOut();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.exit_to_app_outlined,
                            color: Colors.white,
                            size: 30.0,
                          ),
                          onPressed: () {
                            user.signOut();
                          }),
                      Text("Sign Out",
                          style: TextStyle(color: Colors.white, fontSize: 22)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dashboard(context) {
    final user = Provider.of<UserProvider>(context);
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          child: Container(
            margin: EdgeInsets.only(top: 8),
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                // Custom AppBar
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isCollapsed)
                                _controller.forward();
                              else
                                _controller.reverse();

                              isCollapsed = !isCollapsed;
                            });
                          },
                          child:
                              SvgPicture.asset('assets/svg/drawer_icon.svg')),
                      Container(
                        height: 59,
                        width: 59,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage('assets/images/logo.jpg'),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                // Card Section
                SizedBox(
                  height: 25,
                ),

                Padding(
                  padding: EdgeInsets.only(left: 16, bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Welcome',
                        style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: kBlackColor),
                      ),
                      Text(
                        '${user.userModel?.name}',
                        style: GoogleFonts.inter(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: kBlackColor),
                      )
                    ],
                  ),
                ),

                Container(
                  height: 199,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: 16, right: 6),
                    itemCount: cards.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(right: 10),
                        height: 199,
                        width: 344,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          color: Colors.green,
                        ),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              child:
                                  SvgPicture.asset(cards[index].cardElementTop),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: SvgPicture.asset(
                                  cards[index].cardElementBottom),
                            ),
                            Positioned(
                              left: 29,
                              top: 48,
                              child: Text(
                                'CARD NUMBER',
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: kWhiteColor),
                              ),
                            ),
                            Positioned(
                              left: 29,
                              top: 65,
                              child: Text(
                                cards[index].cardNumber,
                                style: GoogleFonts.inter(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: kWhiteColor),
                              ),
                            ),
                            Positioned(
                              right: 21,
                              top: 35,
                              child: Image.asset(
                                cards[index].cardType,
                                width: 27,
                                height: 27,
                              ),
                            ),
                            Positioned(
                              left: 29,
                              bottom: 45,
                              child: Text(
                                'CARD HOLDERID',
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: kWhiteColor),
                              ),
                            ),
                            Positioned(
                              left: 29,
                              bottom: 21,
                              child: Text(
                                '${user.userModel?.idnumber}',
                                style: GoogleFonts.inter(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: kWhiteColor),
                              ),
                            ),
                            Positioned(
                              left: 202,
                              bottom: 45,
                              child: Text(
                                'EXPIRY DATE',
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: kWhiteColor),
                              ),
                            ),
                            Positioned(
                              left: 202,
                              bottom: 21,
                              child: Text(
                                cards[index].cardExpired,
                                style: GoogleFonts.inter(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: kWhiteColor),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Operation Section
                Padding(
                  padding:
                      EdgeInsets.only(left: 16, bottom: 13, top: 29, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Activity',
                        style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: kBlackColor),
                      ),
                      Row(
                        children: map<Widget>(
                          datas,
                          (index, selected) {
                            return Container(
                              alignment: Alignment.centerLeft,
                              height: 9,
                              width: 9,
                              margin: EdgeInsets.only(right: 6),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: current == index
                                      ? Colors.green
                                      : kTwentyBlueColor),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),

                Container(
                  height: 123,
                  child: ListView.builder(
                    itemCount: datas.length,
                    padding: EdgeInsets.only(left: 16),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            current = index;
                          });
                          PaymentService().makePayment();
                          if (index == 0) {
                            showMaterialModalBottomSheet(
                              context: context,
                              isDismissible: true,
                              builder: (context, scrollController) => Container(
                                height:
                                    MediaQuery.of(context).size.height * (0.75),
                                child: ListView(
                                  children: [
                                    SizedBox(
                                      height: 60.0,
                                    ),
                                    PaymentForm(),
                                  ],
                                ),
                              ),
                            );
                          }
                          if (index == 2) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    //this right here
                                    child: Container(
                                      height: 250,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Select amount You wish to apply for!',
                                              textAlign: TextAlign.center,
                                            ),
                                            DropdownButtonFormField(
                                              value: _options ?? '100',
                                              items: options.map((option) {
                                                return DropdownMenuItem(
                                                  value: option,
                                                  child: Text('$option '),
                                                );
                                              }).toList(),
                                              onChanged: (val) => setState(
                                                  () => _options = val),
                                              decoration: InputDecoration(
                                                labelText: "paymenttype",
                                                hintText: "Select paymenttype",
                                                // If  you are using latest version of flutter then lable text and hint text shown like this
                                                // if you r using flutter less then 1.20.* then maybe this is not working properly
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .always,
                                                suffixIcon: CustomSurffixIcon(
                                                    svgIcon:
                                                        "assets/icons/Cash.svg"),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 320.0,
                                              child: RaisedButton(
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                  Flushbar(
                                                    title: "Thank You",
                                                    message:
                                                        "Your loan Request has been received",
                                                    duration:
                                                        Duration(seconds: 3),
                                                  )..show(context);
                                                },
                                                child: Text(
                                                  "Confirm",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                color: Colors.green,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 320.0,
                                              child: RaisedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "Reject",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  color: Colors.red),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          }
                        },
                        child: OperationCard(
                            operation: datas[index].name,
                            selectedIcon: datas[index].selectedIcon,
                            unselectedIcon: datas[index].unselectedIcon,
                            isSelected: current == index,
                            context: this),
                      );
                    },
                  ),
                ),

                // Transaction Section
                Padding(
                  padding:
                      EdgeInsets.only(left: 16, bottom: 13, top: 29, right: 10),
                  child: Text(
                    'Transaction Records',
                    style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: kBlackColor),
                  ),
                ),
                ListView.builder(
                  itemCount: transactions.length,
                  padding: EdgeInsets.only(left: 16, right: 16),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 76,
                      margin: EdgeInsets.only(bottom: 13),
                      padding: EdgeInsets.only(
                          left: 24, top: 12, bottom: 12, right: 22),
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: kTenBlackColor,
                            blurRadius: 10,
                            spreadRadius: 5,
                            offset: Offset(8.0, 8.0),
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                height: 57,
                                width: 57,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image:
                                        AssetImage(transactions[index].photo),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 13,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  AutoSizeText(
                                    transactions[index].name,
                                    style: GoogleFonts.inter(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: kBlackColor),
                                  ),
                                  Text(
                                    transactions[index].date,
                                    style: GoogleFonts.inter(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: kGreyColor),
                                  )
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                transactions[index].amount,
                                style: GoogleFonts.inter(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.green),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OperationCard extends StatefulWidget {
  final String operation;
  final String selectedIcon;
  final String unselectedIcon;
  final bool isSelected;
  final _HomeScreenState context;

  OperationCard(
      {this.operation,
      this.selectedIcon,
      this.unselectedIcon,
      this.isSelected,
      this.context});

  @override
  _OperationCardState createState() => _OperationCardState();
}

class _OperationCardState extends State<OperationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      width: 123,
      height: 123,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: kTenBlackColor,
              blurRadius: 10,
              spreadRadius: 5,
              offset: Offset(8.0, 8.0),
            )
          ],
          borderRadius: BorderRadius.circular(15),
          color: widget.isSelected ? Colors.green : kWhiteColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
              widget.isSelected ? widget.selectedIcon : widget.unselectedIcon),
          SizedBox(
            height: 9,
          ),
          Text(
            widget.operation,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: widget.isSelected ? kWhiteColor : Colors.green),
          )
        ],
      ),
    );
  }
}
