import 'package:flutter/material.dart';

class NewMovementDialog extends StatefulWidget {
  const NewMovementDialog({super.key});

  @override
  State<NewMovementDialog> createState() => _NewMovementDialogState();
}

class _NewMovementDialogState extends State<NewMovementDialog> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {},
            label: const Text('Save'),
            icon: const Icon(Icons.save),
          ),
          appBar: AppBar(
            titleSpacing: 16,
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text("Add new expense"),
          ),
          body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "Title",
                      hintText: "Expense name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "Category",
                      hintText: "Expense category",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: "Price",
                            hintText: "Expense price",
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                          child:
                              // TextFormField(
                              //   decoration: const InputDecoration(
                              //     floatingLabelBehavior: FloatingLabelBehavior.always,
                              //     labelText: "Type",
                              //     hintText: "Expense type",
                              //     border: OutlineInputBorder(),
                              //   ),
                              // ),
                              DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          label: Text("Type"),
                          border: OutlineInputBorder(),
                        ),
                        value: selectedValue,
                        hint: Text('Select Value'),
                        items: <String>['Option 1', 'Option 2']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue = newValue;
                          });
                        },
                      )),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
