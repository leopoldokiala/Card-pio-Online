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
  const ProductFormField({
    required this.keyboardType,
    required this.label,
    this.maxLines,
    this.onFieldSubmitted,
    this.focusNode,
    this.textInputAction,
    this.controller,
    this.onSaved,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        focusNode: focusNode,
        maxLines: maxLines,
        onSaved: onSaved,
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
        onFieldSubmitted: (value) {
          onFieldSubmitted?.call(value);
        },
      ),
    );
  }
}
