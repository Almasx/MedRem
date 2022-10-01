import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:lark/models/date.dart';
import 'package:lark/router/routes.dart';
import 'package:path_provider/path_provider.dart';
import 'config/themes/theme.dart';
import 'package:provider/provider.dart';

main() async {
  runApp(const MyApp());
  final dir = (await getApplicationDocumentsDirectory()).path;
  File('$dir/data.json').writeAsStringSync('');
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      locked: true,
      channelKey: 'pill_channel',
      channelName: 'Pill Reminder',
      defaultColor: const Color(0xff020202),
      importance: NotificationImportance.High,
      channelShowBadge: true,
      channelDescription: 'Description',
    ),
  ]);
  await AwesomeNotifications().requestPermissionToSendNotifications();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: ((context) => DataModel())),
          ChangeNotifierProvider(create: (context) => ThemeProvider())
        ],
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Medrem',
              themeMode: themeProvider.themeMode,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              initialRoute: RouteManager.homePage,
              onGenerateRoute: RouteManager.generateRoute);
        });
  }
}
