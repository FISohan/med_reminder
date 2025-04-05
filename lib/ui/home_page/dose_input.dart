import 'package:flutter/material.dart';
import 'package:med_reminder/data/med.dart';

class DoseInput extends StatefulWidget {
  final String time;
  final Function(Dose dose,bool active) onChanged;
  const DoseInput({super.key, required this.time, required this.onChanged});

  @override
  State<DoseInput> createState() => _DoseInputState();
}

class _DoseInputState extends State<DoseInput> {
  String? quantity;

  bool active = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Checkbox(
          value: active,
          onChanged: (bool? value) {
            setState(() {
              active = value!;
            });
            widget.onChanged(Dose(time: widget.time, quantity: quantity ?? " "), active);
          },
        ),
        Expanded(child: Text(widget.time)),
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            enabled: active,
            decoration: const InputDecoration(labelText: "Quantity"),
            onChanged: (value) {
              if (double.tryParse(value) != null) {
                quantity = value;
                widget.onChanged(Dose(time: widget.time, quantity: value), active);
              } else {
                quantity = null;
                widget.onChanged(Dose(time: widget.time, quantity: ""), active);
              }
            },
            validator: (value) {
              if (active && (value == null || value.isEmpty)) {
                return 'Please enter a quantity';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}