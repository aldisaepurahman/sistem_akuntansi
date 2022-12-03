import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';

class DropdownForm extends StatelessWidget {
  final List<String> item;
  final Function(String?) onChanged;
  final String content;

  const DropdownForm(
      {Key? key,
      required this.onChanged,
      required this.content,
      required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: content,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: item.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
