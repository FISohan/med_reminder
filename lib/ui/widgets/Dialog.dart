/// Displays a custom alert dialog with the specified title, content, and actions.
///
/// This function creates and shows an `AlertDialog` widget with customizable
/// properties such as title, content, and actions. The dialog is non-dismissible
/// by tapping outside of it, ensuring the user interacts with the provided actions
/// to close it.
///
/// The dialog also includes a close button in the top-right corner, allowing
/// the user to dismiss the dialog manually.
///
/// Parameters:
/// - `context`: The `BuildContext` in which the dialog is displayed.
/// - `title`: A `Widget` representing the title of the dialog, aligned to the top-left.
/// - `content`: A `Widget` representing the main content of the dialog, displayed
///   within a scrollable area.
/// - `actions`: A list of `Widget` objects representing the action buttons
///   displayed at the bottom of the dialog.
///
/// Returns:
/// A `Future<void>` that completes when the dialog is dismissed.
///
/// Example usage:
/// ```dart
/// showAlertDialog(
///   context,
///   Text('Dialog Title'),
///   Text('This is the content of the dialog.'),
///   [
///     TextButton(
///       onPressed: () {
///         Navigator.of(context).pop();
///       },
///       child: Text('OK'),
///     ),
///   ],
/// );
/// ```

import 'package:flutter/material.dart';

Future<void> showAlertDialog(
  BuildContext context,
  Widget title,
  Widget content,
  List<Widget> actions,
) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button to close the dialog
    builder: (BuildContext context) {
      return AlertDialog(
        title: Align(alignment: Alignment.topLeft, child: title),

        insetPadding: EdgeInsets.all(10),
        iconPadding: EdgeInsets.all(3),
        icon: Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: content,
        ),
        scrollable: true,
        actions: actions,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      );
    },
  );
}
