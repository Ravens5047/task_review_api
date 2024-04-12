import 'package:flutter/material.dart';
import 'package:task_api_review/resources/app_color.dart';

class TdTextFieldPassword extends StatefulWidget {
  const TdTextFieldPassword({
    super.key,
    this.controller,
    this.onChanged,
    this.focusNode,
    this.keyboardType,
    this.hintText,
    this.onFieldSubmitted,
    this.textInputAction,
    this.validator,
  });

  final TextEditingController? controller;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final String? hintText;
  // final Icon? prefixIcon;
  final Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  // final bool readOnly;

  @override
  State<TdTextFieldPassword> createState() => _TdTextFieldPasswordState();
}

class _TdTextFieldPasswordState extends State<TdTextFieldPassword> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineInputBorder(Color color) => OutlineInputBorder(
          borderSide: BorderSide(color: color, width: 1.2),
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        );

    return Stack(
      children: [
        Container(
          height: 48.6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: const [
              BoxShadow(
                color: AppColor.shadow,
                offset: Offset(0.0, 3.0),
                blurRadius: 6.0,
              ),
            ],
          ),
        ),
        TextFormField(
          controller: widget.controller,
          onChanged: widget.onChanged,
          obscureText: !showPassword,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType,
          onFieldSubmitted: widget.onFieldSubmitted,
          textInputAction: widget.textInputAction,
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.6),
            filled: true,
            fillColor: Colors.pink.shade50,
            border: outlineInputBorder(AppColor.red),
            focusedBorder: outlineInputBorder(AppColor.blue),
            enabledBorder: outlineInputBorder(AppColor.orange),
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: AppColor.grey),
            labelText: widget.hintText,
            prefixIcon: const Icon(Icons.password, color: AppColor.orange),
            suffixIcon: GestureDetector(
              onTap: () => setState(() => showPassword = !showPassword),
              child: showPassword
                  ? Icon(Icons.remove_red_eye_rounded,
                      color: AppColor.brown.withOpacity(0.68))
                  : const Icon(Icons.remove_red_eye_outlined,
                      color: AppColor.green),
            ),
          ),
        ),
      ],
    );
  }
}
