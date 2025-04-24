import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:med_reminder/ui/home_page/homepage_viewmodel.dart';
import 'package:med_reminder/ui/home_page/med_inputs.dart';
import 'package:med_reminder/ui/widgets/Dialog.dart';
import 'package:med_reminder/utils/const.dart';
import 'package:med_reminder/utils/get_time_of_day.dart';
import 'package:med_reminder/utils/show_notification.dart';
import 'package:med_reminder/utils/theme_switch.dart';

AppBar homePageAppBar({
  required BuildContext context,
  required HomepageViewmodel viewmodel,
  required ThemeSwitch themeSwitch,
}) {
  return AppBar(
    title: const Text('Med Reminder'),
    actions: [
      IconButton(
        onPressed: () {
          //widget.viewmodel.getMedsByTime();
        },
        icon: Icon(Icons.list_alt),
      ),
      IconButton(
        onPressed: () {
          showAlertDialog(
            context,
            Text("Add new Med"),
            MedInputs(viewmodel: viewmodel),
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
            Column(
              children: [
                Row(
                  spacing: 10,
                  children: [
                    Text("Dark Mode: ", style: TextStyle(fontSize: 18)),
                    StatefulBuilder(
                      builder: (context, setSateDialog) {
                        return Switch(
                          value: themeSwitch.isDarkTheme,

                          onChanged: (bool value) async {
                            setSateDialog(() {
                              themeSwitch.setTheme(value);
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),

                StatefulBuilder(
                  builder: (context, setStateDialog) {
                    return Row(
                      children: [
                        Text("Turn Reminder:", style: TextStyle(fontSize: 18)),
                        Switch(
                          value: viewmodel.isReminderOn,
                          onChanged: (bool value) {
                            setStateDialog(() {
                              viewmodel.setRrminderState(value);
                            });
                            String currentTime = getTimeOfDay();
                            String nextTime = viewmodel.getNextTime();
                            Duration duration = getDurationFromCurrentTime(
                              nextTime,
                            );

                            if (value && nextTime != "-1") {
                              // Set reminder
                              // duration = Duration(seconds: 30);
                              AndroidAlarmManager.oneShot(
                                duration,
                                DEFAULT_ALARM_ID,
                                showNotification,
                              );
                            } else {
                              // clear bg service
                              AndroidAlarmManager.cancel(DEFAULT_ALARM_ID);
                            }
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            [],
          );
        },

        icon: Icon(Icons.settings),
      ), ////////
    ],
  );
}
