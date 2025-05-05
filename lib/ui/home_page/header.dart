import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:med_reminder/ui/widgets/Dialog.dart';

class Header extends StatelessWidget {
  String dayOfTime;

  Header({super.key, required this.dayOfTime});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Wrap(
                children: [
                  TextButton(
                    onPressed: () async {
                      await FlutterLocalNotificationsPlugin().cancelAll();
                    },
                    child: Text("Yes"),
                  ),
                  TextButton(
                    onPressed: () {
                      showAlertDialog(
                        context,
                        Icon(Icons.block_sharp),
                        Text("You Should Take Medicine! Or Die."),
                        [],
                      );
                    },
                    child: Text("No"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
