import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:provider/provider.dart';
import 'package:shambarecords/providers/records_stream.dart';
import 'package:shambarecords/providers/user_provider.dart';
import 'package:shambarecords/routes.dart';
import 'package:shambarecords/screens/dummy.dart';
import 'package:shambarecords/theme.dart';

void main() {
  /*Set Consumer credentials before initializing the payment.
    You can get  them from https://developer.safaricom.co.ke/ by creating
    an account and an app.
     */
  MpesaFlutterPlugin.setConsumerKey("Znta2q3LCscb9grTZ7p0CIbc1dJIfTTl");
  MpesaFlutterPlugin.setConsumerSecret("VC0RP4OVeD4tR70H");
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserProvider.initialize()),
        ChangeNotifierProvider.value(value: RecordStream.initialize()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(),
        initialRoute: Dummy.routeName,
        routes: routes,
      ),
    );
  }
}
