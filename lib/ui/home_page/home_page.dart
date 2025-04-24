import 'package:flutter/material.dart';
import 'package:med_reminder/data/med.dart';
import 'package:med_reminder/ui/home_page/header.dart';
import 'package:med_reminder/ui/home_page/homepage_app_bar.dart';
import 'package:med_reminder/ui/home_page/homepage_viewmodel.dart';
import 'package:med_reminder/ui/home_page/med_info_card.dart';
import 'package:med_reminder/utils/get_time_of_day.dart';
import 'package:med_reminder/utils/theme_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final HomepageViewmodel viewmodel;
  final ThemeSwitch themeSwitch;
  const HomePage({
    super.key,
    required this.viewmodel,
    required this.themeSwitch,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String dayOfTime;
  List<Med> meds = [];
  bool isEmpty = false;
  late SharedPreferences pref;
  @override
  void initState() {
    dayOfTime = getTimeOfDay();
    final medList = widget.viewmodel.medsByTime;
    widget.viewmodel.getMedsByTime();
    if (medList.isEmpty) {
      isEmpty = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homePageAppBar(
        context: context,
        themeSwitch: widget.themeSwitch,
        viewmodel: widget.viewmodel,
      ),
      body: SingleChildScrollView(
        child: ListenableBuilder(
          listenable: widget.viewmodel,
          builder: (context, child) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                spacing: 5,
                children: [
                  Header(dayOfTime: dayOfTime),
                  widget.viewmodel.medsByTime.isEmpty
                      ? Center(
                        child: Text(
                          "No Meds Found",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                        ),
                      )
                      : SizedBox.shrink(),
                  for (Med med in widget.viewmodel.medsByTime)
                    MedInfoCard(med: med),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
