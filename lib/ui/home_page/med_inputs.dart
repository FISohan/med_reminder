import 'dart:io';
import 'package:flutter/material.dart';
import 'package:med_reminder/data/med.dart';
import 'package:med_reminder/ui/home_page/dose_input.dart';
import 'package:med_reminder/ui/home_page/homepage_viewmodel.dart';
import 'package:med_reminder/ui/widgets/Button.dart';
import 'package:med_reminder/ui/widgets/Input.dart';
import 'package:med_reminder/utils/pick_and_save_image.dart';

class MedInputs extends StatefulWidget {
  final HomepageViewmodel viewmodel;
  MedInputs({super.key, required this.viewmodel});

  @override
  State<MedInputs> createState() => _MedInputsState();
}

class _MedInputsState extends State<MedInputs> {
  final _formKey = GlobalKey<FormState>(); // Add a GlobalKey for the form

  late String _name;
  String _notes = "";

  bool _beforeMeal = true;
  File? _medPhoto;

  bool _morning = false;
  bool _afternoon = false;
  bool _evening = false;
  bool _night = false;

  Dose? _morning_dose;
  Dose? _afternoon_dose;
  Dose? _evening_dose;
  Dose? _night_dose;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, // Attach the form key
      child: Column(
        spacing: 10,
        children: [
          InputField(
            labelText: "Name",
            onChanged: (value) => _name = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Name is required";
              }
              return null;
            },
          ),

          _medPhoto == null
              ? Button(
                text: "Add Med Photo",
                onPressed: () async {
                  final File? photo = await pickAndSaveImage();
                  setState(() {
                    _medPhoto = photo;
                  });
                },
                width: double.infinity,
                height: 50,
              )
              : Stack(
                children: [
                  Image.file(
                    _medPhoto!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () async{
                        //TODO: Implement delete photo functionality
                        await _medPhoto?.delete();
                        setState(() {
                          _medPhoto = null;
                        });
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                ],
              ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DoseInput(
                time: "Morning",
                onChanged: (Dose dose, bool active) {
                  _morning = active;
                  if (!active) {
                    _morning_dose = null;
                  } else {
                    _morning_dose = dose;
                  }
                },
              ),
              DoseInput(
                time: "Afternoon",
                onChanged: (Dose dose, bool active) {
                  _afternoon = active;
                  if (!active) {
                    _afternoon_dose = null;
                  } else {
                    _afternoon_dose = dose;
                  }
                },
              ),
              DoseInput(
                time: "Evening",
                onChanged: (Dose dose, bool active) {
                  _evening = active;
                  if (!active) {
                    _evening_dose = null;
                  } else {
                    _evening_dose = dose;
                  }
                },
              ),
              DoseInput(
                time: "Night",
                onChanged: (Dose dose, bool active) {
                  _night = active;
                  if (!active) {
                    _night_dose = null;
                  } else {
                    _night_dose = dose;
                  }
                },
              ),
            ],
          ),
          Row(
            children: [
              Row(
                children: [
                  Radio<bool>(
                    value: _beforeMeal,
                    groupValue: true,
                    onChanged: (bool? val) {
                      setState(() {
                        _beforeMeal = !val!;
                      });
                    },
                  ),
                  Text("Before Meal"),
                ],
              ),
              Row(
                children: [
                  Radio<bool>(
                    value: _beforeMeal,
                    groupValue: false,
                    onChanged: (bool? val) {
                      setState(() {
                        _beforeMeal = !val!;
                      });
                    },
                  ),
                  Text("After Meal"),
                ],
              ),
            ],
          ),
          ListenableBuilder(
            listenable: widget.viewmodel,
            builder: (context, child) {
              return Button(
                text: "Save",
                onPressed: () {

                  List<Dose> dose = [
                    if (_morning) _morning_dose!,
                    if (_evening) _evening_dose!,
                    if (_afternoon) _afternoon_dose!,
                    if (_night) _night_dose!,
                  ];

                  if (_formKey.currentState!.validate() && dose.isNotEmpty) {
                    // Proceed only if the form is valid
                    Med med = Med(
                      name: _name,
                      notes: _notes,
                      image: _medPhoto?.path,
                      beforeMeal: _beforeMeal,
                    );

                    med.doses.addAll(dose);

                    // Save the med object or perform further actions
                    widget.viewmodel.addMed(med);
                    widget.viewmodel.getMedsByTime();
                    Navigator.of(context, rootNavigator: true).pop();
                    // Show success SnackBar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Medication saved successfully!"),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
