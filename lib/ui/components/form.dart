import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:intl/intl.dart';
import 'package:textfield_search/textfield_search.dart';

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
      style: TextStyle(fontSize: 13, color: abu_tua),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: abu_tua),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kuning),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: abu_tua),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: abu_transparan),
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: EdgeInsets.all(5),
        filled: true,
        fillColor: background2,
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
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: background2,
        shape: RoundedRectangleBorder(
          side:
              BorderSide(width: 1.0, style: BorderStyle.solid, color: abu_tua),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButton(
            value: content,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: onChanged,
          )),
    );
  }
}

class TextForm extends StatelessWidget {
  final String hintText;

  const TextForm({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 20),
      child: TextField(
        style: TextStyle(fontSize: 13),
        decoration: InputDecoration(
            hintText: hintText,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kuning),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: abu_tua),
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.all(3),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: abu_transparan))),
      ),
    );
  }
}

class DropdownSearchButton extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const DropdownSearchButton(
      {super.key, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10, bottom: 20),
        child: TextFieldSearch(
            label: label,
            controller: controller,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kuning),
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: abu_tua),
                  borderRadius: BorderRadius.circular(8),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: abu_transparan),
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: background2,
                contentPadding: const EdgeInsets.all(3))));
  }
}

class DropdownSearchItem {
  dynamic label;
  dynamic value;

  DropdownSearchItem({required value, required label});

  factory DropdownSearchItem.fromJson(Map<String, dynamic> json) {
    return DropdownSearchItem(label: json['label'], value: json['value']);
  }
}
