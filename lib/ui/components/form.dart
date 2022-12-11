import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:dropdown_text_search/dropdown_text_search.dart';

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
        contentPadding: EdgeInsets.symmetric(horizontal: 25),
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
            underline: SizedBox(),
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
  final TextEditingController textController;
  String? label;

  TextForm(
      {super.key,
      required this.hintText,
      required this.textController,
      this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 20),
      child: TextField(
        controller: textController,
        style: TextStyle(
          fontSize: 13,
          fontFamily: 'Inter',
        ),
        decoration: InputDecoration(
            labelText: label,
            hintText: hintText,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kuning),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: abu_tua),
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 25),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: abu_transparan))),
      ),
    );
  }
}

class DropdownSearchButton extends StatelessWidget {
  TextEditingController controller;
  final String hintText;
  final String notFoundText;
  final List<String> items;
  final Function(String?) onChange;
  final bool isNeedChangeColor;
  final Color? colorWhenChanged;

  DropdownSearchButton({
    super.key,
    required this.controller,
    required this.hintText,
    required this.notFoundText,
    required this.items,
    required this.onChange,
    required this.isNeedChangeColor,
    this.colorWhenChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownTextSearch(
      onChange: onChange,
      noItemFoundText: notFoundText,
      controller: controller,
      overlayHeight: 300,
      items: items,
      filterFnc: (String a, String b) {
        return a.toLowerCase().startsWith(b.toLowerCase());
      },
      decorator: InputDecoration(
          filled: isNeedChangeColor,
          fillColor: colorWhenChanged,
          hintStyle: TextStyle(
            fontFamily: 'Inter',
          ),
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kuning),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: abu_tua),
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 25),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: abu_transparan))),
    );
  }
}
