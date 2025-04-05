import 'package:flutter/material.dart';
import 'package:med_reminder/data/IMedRepository.dart';
import 'package:med_reminder/data/medRepository.dart';
import 'package:med_reminder/data/object_box_service.dart';
import 'package:med_reminder/ui/home_page/home_page.dart';
import 'package:med_reminder/ui/home_page/homepage_viewmodel.dart';
import 'package:provider/provider.dart';

late ObjectBoxService objectBoxService;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
          contrastLevel: 0.48,
        ),
      ),
      home: HomePage(
        viewmodel: HomepageViewmodel(
          medRepository: context.read<IMedRepository>(),
        ),
      ),
    );
  }
}
