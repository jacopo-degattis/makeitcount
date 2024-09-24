import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
import 'package:flutter_iconpicker/Models/icon_picker_icon.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makeitcount/state/models/movement.model.dart';
import 'package:makeitcount/state/providers/movements/movements_repository.provider.dart';

class NewMovement extends ConsumerStatefulWidget {
  final int selectedMonth;
  final List<MovementModel> movementsPreview;

  const NewMovement({
    super.key,
    required this.selectedMonth,
    required this.movementsPreview,
  });

  @override
  ConsumerState<NewMovement> createState() => _NewMovementState();
}

class _NewMovementState extends ConsumerState<NewMovement> {
  Icon? _icon;
  String? formError;
  String movementType = "Income";

  _pickIcon() async {
    IconPickerIcon? icon = await showIconPicker(
      context,
      configuration: const SinglePickerConfiguration(
        iconPackModes: [IconPack.material],
      ),
    );

    _icon = Icon(icon!.data);
    setState(() {});

    debugPrint("Picked icon: ${icon.data}");
  }

  @override
  Widget build(BuildContext context) {
    final movementsRepo = ref.watch(movementsRepositoryProvider);

    final movementTitle = TextEditingController();
    final movementCategory = TextEditingController();
    final movementPrice = TextEditingController();

    bool _validateForm() {
      if (movementTitle.text.isEmpty ||
          movementCategory.text.isEmpty ||
          movementPrice.text.isEmpty ||
          _icon == null) {
        formError =
            "All fields must be filled in order to save the new expense";
        return false;
      }
      return true;
    }

    return Dialog.fullscreen(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.close), // Cross icon to close
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            title: const Text("Add new expense"),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: "Title",
                          hintText: "Name",
                          border: OutlineInputBorder(),
                        ),
                        controller: movementTitle,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _pickIcon();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        height: 65,
                        width: 65,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: Color(0xFF7c6d69),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(4.0)),
                          child: _icon,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: "Category",
                    hintText: "Category",
                    border: OutlineInputBorder(),
                  ),
                  controller: movementCategory,
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: "Price",
                          hintText: "Price",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        controller: movementPrice,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                        child: DropdownButtonFormField<String>(
                      value: movementType,
                      hint: const Text('Income/Outcome'),
                      decoration: const InputDecoration(
                        labelText: "Type",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(), // Outlined border
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                      ),
                      items: <String>['Income', 'Outcome'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          movementType = newValue!;
                        });
                        print(
                            "CHANGED DROPDOWN VALUE TO $newValue, $movementType");
                      },
                    )),
                  ],
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
              label: const Text("Save"),
              onPressed: () {
                // TODO: check that all fields are filled
                // otherwise don't let submit the form

                if (_validateForm()) {
                  movementsRepo.addMovement(
                      movementTitle.text,
                      movementCategory.text,
                      double.parse(movementPrice.text),
                      _icon!.icon!.codePoint,
                      widget.selectedMonth,
                      movementType == "Income" ? true : false);

                  widget.movementsPreview.add(MovementModel(
                    0,
                    movementTitle.text,
                    double.parse(movementPrice.text),
                    movementCategory.text,
                    _icon!.icon!.codePoint,
                    widget.selectedMonth,
                    movementType == "Income" ? true : false,
                  ));

                  Navigator.of(context).pop();
                  return;
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(formError ?? "An error occurred")),
                );
              },
              icon: const Icon(Icons.save)),
        ),
      ),
    );
  }
}
