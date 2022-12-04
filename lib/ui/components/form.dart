import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';

class DropdownForm extends StatelessWidget {
  final List<String> items;
  final Function(String?) onChanged;
  final String content;
  final label;

  const DropdownForm(
      {Key? key,
      required this.onChanged,
      required this.content,
      required this.items,
      this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        labelText: label,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: abu_transparan),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: abu_transparan),
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: background,
      ),
      dropdownColor: background,
      value: content,
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class DropdownFilter extends StatelessWidget {
  final List<String> items;
  final Function(String?) onChanged;
  final String content;

  const DropdownFilter(
      {Key? key,
      required this.onChanged,
      required this.content,
      required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: content,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
