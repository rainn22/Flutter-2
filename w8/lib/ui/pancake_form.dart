import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/provider/pancake_provide.dart';
import 'package:app/main.dart';

class PancakeForm extends StatefulWidget {
  final Pancake? pancake;

  const PancakeForm({super.key, this.pancake});

  @override
  State<PancakeForm> createState() => _PancakeFormState();
}

class _PancakeFormState extends State<PancakeForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.pancake != null) {
      _colorController.text = widget.pancake!.color;
      _priceController.text = widget.pancake!.price.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Pancakeprovider>(context);
    return AlertDialog(
      title: Text(widget.pancake == null ? 'Add Pancake' : 'Edit Pancake'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _colorController,
              decoration: const InputDecoration(labelText: 'Color'),
              validator: (value) => value!.isEmpty ? 'Enter a color' : null,
            ),
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'Enter a price' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final color = _colorController.text;
              final price = double.parse(_priceController.text);

              if (widget.pancake == null) {
                provider.addPancake(color, price);
              } else {
                provider.updatePancake(widget.pancake!.id, color, price);
              }
              Navigator.of(context).pop();
            }
          },
          child: Text(widget.pancake == null ? 'Add' : 'Save'),
        ),
      ],
    );
  }
}

void showPancakeForm(BuildContext context, {Pancake? pancake}) {
  showDialog(
    context: context,
    builder: (context) => PancakeForm(pancake: pancake),
  );
}
