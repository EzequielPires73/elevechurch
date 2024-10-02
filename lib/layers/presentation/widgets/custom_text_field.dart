import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final bool obscureText;
  final bool validatorEnabled;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final int? maxLines;

  const CustomTextField({
    super.key,
    required this.controller,
    this.label,
    this.hintText,
    this.obscureText = false,
    this.inputFormatters,
    this.validator,
    this.validatorEnabled = false,
    this.maxLines = 1,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != null
            ? Text(
                widget.label!,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              )
            : Container(),
        const SizedBox(
          height: 4,
        ),
        TextFormField(
          controller: widget.controller,
          obscureText: _obscureText,
          maxLines: widget.maxLines,
          inputFormatters: widget.inputFormatters,
          validator: widget.validator,
          autovalidateMode: widget.validatorEnabled
              ? AutovalidateMode.onUserInteraction
              : null,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          decoration: InputDecoration(
            hintText: widget.hintText ?? 'Insira sua senha',
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
