import 'package:flutter/material.dart';
import 'package:kitabulazkar/constants.dart';

class CustomInputDialogBox {
  String _inputData = '-1';
  final TextEditingController _textFieldController = TextEditingController();

  Future<void> displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Page Number'),
          content: TextField(
            autofocus: true,
            keyboardType: TextInputType.number,
            controller: _textFieldController,
            cursorColor: kMainColor,
            decoration: const InputDecoration(
              hintText: "Enter here...",
              prefixIcon: Icon(Icons.find_in_page),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: kMainColor,
                ),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: kInputDialogButtonTextColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text(
                'Search',
                style: kInputDialogButtonTextColor,
              ),
              onPressed: () {
                _inputData = _textFieldController.text.trim();

                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  int getInputDialogData() {
    int resultant = -1;
    try {
      resultant = int.tryParse(_inputData) ?? -1;
    } catch (e) {
      // print(e.toString());
    }
    return resultant >= 0 ? resultant : -1;
  }
}
