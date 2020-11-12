import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:shambarecords/components/custom_surfix_icon.dart';
import 'package:shambarecords/components/default_button.dart';
import 'package:shambarecords/components/form_error.dart';
import 'package:shambarecords/constants.dart';
import 'package:shambarecords/size_config.dart';

class PaymentForm extends StatefulWidget {
  @override
  _PaymentFormState createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  final _formKey = GlobalKey<FormState>();

  String amount;
  String phone;
  String initial = '254';
  String _paymenttype;
  final List<String> errors = [];
  bool pressed = false;
  final List<String> paymenttype = [
    'Society Contribution',
    'Monthly Installment',
    'Loan Repayment',
  ];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              onSaved: (newValue) => amount = newValue,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  removeError(error: kamountNullError);
                }
                amount = value;
              },
              validator: (value) {
                if (value.isEmpty) {
                  addError(error: kamountNullError);
                  return "";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "Amount",
                hintText: "Enter contribution amount",
                // If  you are using latest version of flutter then lable text and hint text shown like this
                // if you r using flutter less then 1.20.* then maybe this is not working properly
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Cash.svg"),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(30)),
            TextFormField(
              initialValue: initial,
              onSaved: (newValue) => phone = newValue,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  removeError(error: kamountNullError);
                }
                phone = value;
              },
              validator: (value) {
                if (value.isEmpty) {
                  addError(error: kPhoneNumberNullError);
                  return "";
                }
                if (value.length != 12) {
                  addError(error: 'number format 254705122230');
                  return "";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "Phone",
                hintText: "254705517018",

                // If  you are using latest version of flutter then lable text and hint text shown like this
                // if you r using flutter less then 1.20.* then maybe this is not working properly
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon:
                    CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            DropdownButtonFormField(
              value: _paymenttype ?? 'Chama Payment',
              items: paymenttype.map((sugar) {
                return DropdownMenuItem(
                  value: sugar,
                  child: Text('$sugar '),
                );
              }).toList(),
              onChanged: (val) => setState(() => _paymenttype = val),
              decoration: InputDecoration(
                labelText: "paymenttype",
                hintText: "Select paymenttype",
                // If  you are using latest version of flutter then lable text and hint text shown like this
                // if you r using flutter less then 1.20.* then maybe this is not working properly
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon:
                    CustomSurffixIcon(svgIcon: "assets/icons/Settings.svg"),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            FormError(errors: errors),
            SizedBox(height: SizeConfig.screenHeight * 0.03),
            DefaultButton(
              text: "Continue",
              press: () {
                if (_formKey.currentState.validate()) {
                  // Do what you want to do
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          //this right here
                          child: Container(
                            height: 200,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'You are about to pay Ksh. $amount for $_paymenttype !',
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    width: 320.0,
                                    child: RaisedButton(
                                      onPressed: () async {
                                        await startCheckout();
                                        Navigator.pop(context);
                                        // Flushbar(
                                        //   flushbarPosition: FlushbarPosition.TOP,
                                        //   flushbarStyle: FlushbarStyle.FLOATING,
                                        //   reverseAnimationCurve:
                                        //       Curves.decelerate,
                                        //   forwardAnimationCurve:
                                        //       Curves.elasticOut,
                                        //   backgroundColor: Colors.red,
                                        //   boxShadows: [
                                        //     BoxShadow(
                                        //         color: Colors.blue[800],
                                        //         offset: Offset(0.0, 2.0),
                                        //         blurRadius: 3.0)
                                        //   ],
                                        //   backgroundGradient: LinearGradient(
                                        //       colors: [
                                        //         Colors.blueGrey,
                                        //         Colors.black
                                        //       ]),
                                        //   isDismissible: false,
                                        //   duration: Duration(seconds: 4),
                                        //   icon: Icon(
                                        //     Icons.check,
                                        //     color: Colors.greenAccent,
                                        //   ),
                                        //   showProgressIndicator: true,
                                        //   progressIndicatorBackgroundColor:
                                        //       Colors.blueGrey,
                                        //   messageText: Text(
                                        //     " Loading...!",
                                        //     style: TextStyle(
                                        //         fontSize: 18.0,
                                        //         color: Colors.green,
                                        //         fontFamily:
                                        //             "ShadowsIntoLightTwo"),
                                        //   ),
                                        // )..show(context);
                                      },
                                      child: Text(
                                        "Accept",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      color: Colors.green,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 320.0,
                                    child: RaisedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          print(phone);
                                        },
                                        child: Text(
                                          "Reject",
                                          style: TextStyle(color: Colors.white),
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
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.1),
          ],
        ),
      ),
    );
  }

  Future<void> startCheckout() async {
    Navigator.pop(context);
    //Preferably expect 'dynamic', response type varies a lot!
    dynamic transactionInitialisation;
    //Better wrap in a try-catch for lots of reasons.
    try {
      //Run it
      transactionInitialisation = await MpesaFlutterPlugin.initializeMpesaSTKPush(
          businessShortCode: "174379",
          transactionType: TransactionType.CustomerPayBillOnline,
          amount: double.parse(amount),
          partyA: phone,
          partyB: "174379",
          callBackURL: Uri(
              scheme: "https", host: "my-app.herokuapp.com", path: "/callback"),
          accountReference: "Shamba Records",
          phoneNumber: phone,
          baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
          transactionDesc: "purchase",
          passKey:
              "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919");

      print("TRANSACTION RESULT: " + transactionInitialisation.toString());

      /*Update your db with the init data received from initialization response,
      * Remaining bit will be sent via callback url*/
      return transactionInitialisation;
    } catch (e) {
      //For now, console might be useful
      print("CAUGHT EXCEPTION: " + e.toString());
    }
  }
}
