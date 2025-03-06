import 'package:flutter/material.dart';

class FilterDialog extends StatefulWidget {
  final Function(String sortBy, bool petsAccepted) onApply;

  const FilterDialog({super.key, required this.onApply});

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  String _selectedSort = 'Earliest departure'; // Default sort option
  bool _petsAccepted = false; // Default value for pet acceptance

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Filter"),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Sort by:"),
            ListTile(
              title: Text("Earliest departure"),
              leading: Radio<String>(
                value: 'Earliest departure',
                groupValue: _selectedSort,
                onChanged: (String? value) {
                  setState(() {
                    _selectedSort = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: Text("Lowest price"),
              leading: Radio<String>(
                value: 'Lowest price',
                groupValue: _selectedSort,
                onChanged: (String? value) {
                  setState(() {
                    _selectedSort = value!;
                  });
                },
              ),
            ),
            Divider(),
            Text("Details:"),
            Row(
              children: [
                Checkbox(
                  value: _petsAccepted,
                  onChanged: (bool? value) {
                    setState(() {
                      _petsAccepted = value!;
                    });
                  },
                ),
                Text("Pets accepted"),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Clear all"),
        ),
        TextButton(
          onPressed: () {
            widget.onApply(_selectedSort, _petsAccepted);
            Navigator.of(context).pop(); // Close dialog after applying filters
          },
          child: Text("Apply"),
        ),
      ],
    );
  }
}