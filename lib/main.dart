import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'widgets/widgets.dart';
import 'package:scrumboard/pages/scrumboard.dart';
import 'package:scrumboard/mixin/mixin.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_database/firebase_database.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //ignore: avoid_print
  print("handling a background message ${message.messageId}");
}

/**
 * Initialize get's run before main, so call out notifications here, and database connections etc.
 */
void initInfo() {
  var androidInitialize =
  const AndroidInitializationSettings('@mipmap/ic_launcher');
  var iosInitialize = const DarwinInitializationSettings(); //IOS
  var initializationsSettings = InitializationSettings(android: androidInitialize, iOS: iosInitialize);
  flutterLocalNotificationsPlugin.initialize(
    initializationsSettings,
    onDidReceiveNotificationResponse: ((NotificationResponse details) async {
      // ignore: avoid_print
      print(details.payload);
    }),
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );

  /**
   * Controls the notification layout and data.
   */
  FirebaseMessaging.onMessage.listen((message) async {
    // ignore: avoid_print
    print("............ onMessage.................");
    // ignore: avoid_print
    print(
        "onMessage: ${message.notification?.title}/${message.notification?.body}");
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      message.notification!.body.toString(),
      htmlFormatBigText: true,
      contentTitle: message.notification!.title.toString(),
      htmlFormatContentTitle: true,
    );
    AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.high,
      styleInformation: bigTextStyleInformation,
      priority: Priority.high,
      playSound: true,
    );
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: const DarwinNotificationDetails());
    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      payload: message.data['body'],
    );
  });
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initInfo();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  runApp(const ScrumboardApp());
}

/**
 * The app main, containing the app bar, and what screen to show as the homescreen.
 */
class ScrumboardApp extends StatelessWidget {
  const ScrumboardApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.grey[900],
            primarySwatch: Colors.amber
        ),
        home: ScrumboardMainScreen(),
      );
}

/**
 * The main screen.
 */
class ScrumboardMainScreen extends StatefulWidget {
  const ScrumboardMainScreen({super.key});

  @override
  State<ScrumboardMainScreen> createState() => _ScrumboardMainScreenState();
}
/**
 * What to show on the main screen.
 */
class _ScrumboardMainScreenState extends State<ScrumboardMainScreen> with NewCardDialog {
  String? _token;
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  @override
  void initState() {
    super.initState();
    requestPermission();
    fetchToken();
    initInfo();
    // ignore: avoid_print
    print("............ READY ..................");
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Scrumboard'),
          actions: [
            IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  dialogBuilder(context, null);
                },
            ),
            IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return ClearScrumboardWidget();
                      },
                    );
                  },
            ),
          ],
        ),
        drawer: const NavigationDrawer(),
        body: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return ScrumboardPage();
          },
        ),
      );

  Future<void> requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    switch (settings.authorizationStatus) {
      case AuthorizationStatus.authorized:
      // ignore: avoid_print
        print("....... User granted permission....");
        break;
      case AuthorizationStatus.provisional:
      // ignore: avoid_print
        print("....... User granted provisional permission....");
        break;
      default:
      // ignore: avoid_print
        print("....... User denied permission....");
        break;
    }
  }

  Future<void> fetchToken() async {
    await FirebaseMessaging.instance
        .getToken()
    // ignore: avoid_print
        .then((token) => {_token = token, print("Token: $_token")});

    //save the token to Firebase live database
    String? modelInfo = Platform.isAndroid
        ? (await fetchModelInfo() as AndroidDeviceInfo).model
        : (await fetchModelInfo() as IosDeviceInfo).name;

    FirebaseDatabase.instance
        .ref("usertokens")
        .child(modelInfo!)
        .set({"token": _token});
  }

  Future<BaseDeviceInfo> fetchModelInfo() async {
    if (Platform.isAndroid) {
      return await deviceInfoPlugin.androidInfo;
    }
    if (Platform.isIOS) {
      return await deviceInfoPlugin.iosInfo;
    }
    throw Exception("Only Android or IOS is supported!");
  }
}
