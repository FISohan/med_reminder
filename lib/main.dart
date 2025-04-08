import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:med_reminder/data/IMedRepository.dart';
import 'package:med_reminder/data/medRepository.dart';
import 'package:med_reminder/data/object_box_service.dart';
import 'package:med_reminder/ui/home_page/home_page.dart';
import 'package:med_reminder/ui/home_page/homepage_viewmodel.dart';
import 'package:med_reminder/utils/theme_switch.dart';
import 'package:provider/provider.dart';

late ObjectBoxService objectBoxService;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await FlutterLocalNotificationsPlugin().initialize(initializationSettings);
  await AndroidAlarmManager.initialize();
  objectBoxService = await ObjectBoxService.create();

  runApp(
    MultiProvider(
      providers: [
        Provider<ObjectBoxService>(create: (context) => objectBoxService),
        Provider<IMedRepository>(
          create:
              (context) => Medrepository(
                objectBoxService: context.read<ObjectBoxService>(),
              ),
        ),
        ChangeNotifierProvider<HomepageViewmodel>(
          create:
              (context) => HomepageViewmodel(
                medRepository: context.read<IMedRepository>(),
              ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkModeNotifier,
      builder: (_, mode, _) {
        return MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.teal,
              brightness: mode ? Brightness.dark : Brightness.light,
            ),
          ),
          home: HomePage(viewmodel: context.read<HomepageViewmodel>()),
        );
      },
    );
  }
}
