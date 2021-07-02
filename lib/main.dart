import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_push_notification/greenPage.dart';
import 'package:flutterfire_push_notification/redPage.dart';
import 'package:flutterfire_push_notification/services/localNotiServ.dart';

// For getting notification, even when app is fully terminated.
Future<void> backgroundMessageHandler(RemoteMessage remoteMessage) async {
  print(remoteMessage.data.toString());
  print(remoteMessage.notification!.title);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      routes: {
        GreenPage.routeName: (ctx) => GreenPage(),
        RedPage.routeName: (ctx) => RedPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    LocalNotificationService.initialize(context);

    // Gives tapable messages, even is fully closed mode.
    FirebaseMessaging.instance.getInitialMessage().then(
      ((message) {
        if (message != null) {
          final routeFromMessage = message.data['route'];
          Navigator.of(context).pushNamed(routeFromMessage);
        }
      }),
    );

    // Forground only
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
      }
      LocalNotificationService.display(message);
    });

    // Notification tray, tappable & App must be opened or in background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data['route'];
      Navigator.of(context).pushNamed(routeFromMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Text('You will recieve notification soon....'),
        ),
      ),
    );
  }
}
