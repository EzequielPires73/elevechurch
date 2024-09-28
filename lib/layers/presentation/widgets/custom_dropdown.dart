import 'package:elevechurch/core/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomDropdown extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(Object?)? validator;
  final void Function(Object?)? onSelected;
  final List<DropdownMenuEntry<Object>> dropdownMenuEntries;
  final bool validatorEnabled;

  const CustomDropdown({
    super.key,
    required this.controller,
    required this.dropdownMenuEntries,
    this.label,
    this.hintText,
    this.inputFormatters,
    this.validator,
    this.onSelected,
    this.validatorEnabled = false,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  Object? _selectedValue;

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
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
        const SizedBox(height: 4),
        FormField<Object>(
          validator: widget.validator,
          autovalidateMode: widget.validatorEnabled
              ? AutovalidateMode.onUserInteraction
              : null,
          builder: (FormFieldState<Object> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownMenu(
                  expandedInsets: const EdgeInsets.all(0),
                  hintText: widget.hintText ?? 'Selecione uma opção',
                  inputDecorationTheme: isDark
                      ? InputDecorationTheme(
                          hintStyle:
                              const TextStyle(fontWeight: FontWeight.w400),
                          filled: true,
                          fillColor: CustomColors.cardColor,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(width: 0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(width: 0),
                          ),
                        )
                      : InputDecorationTheme(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                width: 1, color: Colors.black12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                width: 1, color: Colors.black87),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                width: 1, color: Colors.black12),
                          ),
                        ),
                  onSelected: (value) {
                    setState(() {
                      _selectedValue = value;
                    });
                    state.didChange(value);
                    if (widget.onSelected != null) {
                      widget.onSelected!(value);
                    }
                  },
                  dropdownMenuEntries: widget.dropdownMenuEntries,
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      state.errorText ?? '',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
