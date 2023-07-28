import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nft_notify/providers/nft_item_provider.dart';
import 'package:nft_notify/search_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', //id
  'High Importance Notifications', //title
  description: 'This channel is used for inportant Notoficatgion',
  importance: Importance.max,
  playSound: true,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> _firebaseMessagingBackgoundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

//http certificate
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides(); //http certificate
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  if (!kIsWeb) {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgoundHandler);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Nfts()),
      ],
      child: MaterialApp(
        title: 'NFTNotify',
        theme: ThemeData.dark().copyWith(
          primaryColor: Colors.blueGrey,
          //  colorScheme:
          //  ColorScheme.fromSwatch().copyWith(secondary: Colors.red),
        ),
        themeMode: ThemeMode.dark,
        // home: const SearchScreen(),
        home: const PreWolcomWidget(),
      ),
    );
  }
}

// Handl Cloud Messging
class PreWolcomWidget extends StatefulWidget {
  const PreWolcomWidget({Key? key}) : super(key: key);

  @override
  _PreWolcomWidgetState createState() => _PreWolcomWidgetState();
}

class _PreWolcomWidgetState extends State<PreWolcomWidget> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              importance: Importance.max,
              priority: Priority.max,
              color: Theme.of(context).primaryColor,
              playSound: true,
              icon: '@mipmap/launcher_icon',
            )));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      //message.data
      print('message.data');
      print(message.data);
      //message.messageId
      print('message.messageId');
      print(message.messageId);
      //message.notification.title
      print('message.notification.title');
      print(message.notification?.title);
      //message.notification.android.channelId
      print('message.notification.android.channelId');
      print(message.notification?.android?.channelId);
      if (notification != null && android != null) {
        if (message.notification?.android?.channelId == "111") {
          Provider.of<Nfts>(context, listen: false)
              .makeNftListed("EUJNV4s6gx6redioESEzLDx3TTvjLiz67KSkUFESp19X");
        }
        if (message.notification?.android?.channelId == "222") {
          //floor price is deacreasing!!
          Provider.of<Nfts>(context, listen: false)
              .makeNftDecreasing("45fhWt5fpdvoB3gUXuJtBHWhgCaR1yvtg5UNfK3UkkvQ");
        }

        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text(notification.title ?? 'Facture Maroc'),
                  content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(notification.body ??
                            'Gerez vos Factures,devis ... sur FactureMaroc app et FactureMaroc.com')
                      ],
                    ),
                  ),
                ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SearchScreen();
  }
}
