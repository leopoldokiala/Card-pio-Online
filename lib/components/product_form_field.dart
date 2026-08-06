import 'package:flutter/material.dart';

class ProductFormField extends StatelessWidget {
  final TextInputType keyboardType;
  final String label;
  final FocusNode? focusNode;
  final int? maxLines;
  final Function(String?)? onSaved;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final String? initialValue;
  const ProductFormField({
    required this.keyboardType,
    required this.label,
    required this.validator,
    this.maxLines,
    this.onFieldSubmitted,
    this.focusNode,
    this.textInputAction,
    this.controller,
    this.onSaved,
    this.initialValue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: initialValue,
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        focusNode: focusNode,
        maxLines: maxLines,
        cursorColor: Theme.of(context).colorScheme.secondary,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
              width: 2,
            ),
          ),
        ),
        onSaved: onSaved,
        onFieldSubmitted: (value) {
          onFieldSubmitted?.call(value);
        },
        validator: (value) {
          return validator?.call(value);
        },
      ),
    );
  }
}
