import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:med_reminder/data/med.dart';
import 'package:med_reminder/ui/home_page/homepage_viewmodel.dart';
import 'package:med_reminder/ui/home_page/med_inputs.dart';
import 'package:med_reminder/ui/widgets/Dialog.dart';
import 'package:med_reminder/utils/get_dose_quantity.dart';
import 'package:med_reminder/utils/get_time_of_day.dart';
import 'package:med_reminder/utils/show_notification.dart';
import 'package:med_reminder/utils/theme_switch.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

//@TODO:Implement photo preview

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
      appBar: AppBar(
        title: const Text('Med Reminder'),
        actions: [
          IconButton(
            onPressed: () {
              widget.viewmodel.getMedsByTime();
            },
            icon: Icon(Icons.list_alt),
          ),
          IconButton(
            onPressed: () {
              showAlertDialog(
                context,
                Text("Add new Med"),
                MedInputs(viewmodel: widget.viewmodel),
                [],
              );
            },
            icon: Icon(Icons.add_box_outlined),
          ),
          IconButton(
            onPressed: () {
              showAlertDialog(
                context,
                Text('Settings'),
                Row(
                  children: [
                    Row(
                      spacing: 10,
                      children: [
                        Text("Dark Mode: ", style: TextStyle(fontSize: 18)),
                        StatefulBuilder(
                          builder: (context, setSateDialog) {
                            return Switch(
                              value: widget.themeSwitch.isDarkTheme,

                              onChanged: (bool value) async {
                                setSateDialog(() {
                                  widget.themeSwitch.setTheme(value);
                                });
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                [],
              );
            },

            icon: Icon(Icons.settings),
          ),
        ],
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
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Column(
                          spacing: 3,
                          children: [
                            Text(
                              "Do You Take Your Meds at $dayOfTime?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Wrap(
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    await FlutterLocalNotificationsPlugin()
                                        .cancelAll();
                                  },
                                  child: Text("Yes"),
                                ),
                                TextButton(
                                  onPressed: () async {},
                                  child: Text("No"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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
                    SizedBox(
                      width: double.infinity,
                      child: Card.filled(
                        borderOnForeground: true,
                        margin: EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 8,
                            children: [
                              Row(
                                spacing: 5,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    med.name,
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.primaryContainer,
                                    ),
                                  ),

                                  med.image != null
                                      ? IconButton(
                                        onPressed: () {
                                          showAlertDialog(
                                            context,
                                            Text(med.name),
                                            Image.file(File(med.image!)),
                                            [],
                                          );
                                        },
                                        icon: Icon(Icons.image, size: 23),
                                      )
                                      : SizedBox.shrink(),
                                ],
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Divider(thickness: 0.3),
                              ),
                              Wrap(
                                spacing: 5,
                                children: [
                                  for (Dose dose in med.doses)
                                    Chip(
                                      label: Text(
                                        dose.time,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),

                                      backgroundColor: Colors.green,
                                      labelPadding: EdgeInsets.all(2),
                                      padding: EdgeInsets.all(3),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        side: BorderSide(color: Colors.green),
                                      ),
                                    ),
                                ],
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(text: "Take "),
                                    TextSpan(
                                      text: getDoseQuantityByTime(med),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          med.beforeMeal
                                              ? " Before Meal"
                                              : " After Meal",
                                    ),
                                  ],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        Theme.of(
                                          context,
                                        ).colorScheme.primaryContainer,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
