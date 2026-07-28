import 'package:flutter/material.dart';

class ProductFormField extends StatelessWidget {
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final String label;
  final int maxLines;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  const ProductFormField({
    required this.keyboardType,
    required this.label,
    required this.maxLines,
    this.onFieldSubmitted,
    this.focusNode,
    this.textInputAction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
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
        onFieldSubmitted: (value) {
          onFieldSubmitted?.call(value);
        },
      ),
    );
  }
}
