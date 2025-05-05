import 'dart:io';

import 'package:flutter/material.dart';
import 'package:med_reminder/data/med.dart';
import 'package:med_reminder/ui/widgets/Dialog.dart';
import 'package:med_reminder/utils/get_dose_quantity.dart';

class MedInfoCard extends StatelessWidget {
  final Med med;

  const MedInfoCard({super.key, required this.med});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    med.name,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primaryContainer,
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
              SizedBox(width: double.infinity, child: Divider(thickness: 0.3)),
              Row(
                spacing: 5,
                children: [
                  for (Dose dose in med.doses)
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(5),
                        ),
                      child: Center(
                        child: Text(dose.time),
                      ),
                    )
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
                      text: med.beforeMeal ? " Before Meal" : " After Meal",
                    ),
                  ],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
