import 'package:flutter/material.dart';

class BorderedTextField extends StatelessWidget {
  const BorderedTextField(
      {Key? key,
      this.label,
      this.hint,
      this.onChanged,
      this.validator,
      this.obscureText = false,
      this.initialValue})
      : super(key: key);

  final String? initialValue;
  final String? label;
  final String? hint;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final bool obscureText;

  factory BorderedTextField.email(
      {Key? key, void Function(String?)? onChanged, String? initialValue}) {
    return BorderedTextField(
        key: key,
        label: 'Email',
        hint: 'Enter your email',
        initialValue: initialValue,
        onChanged: onChanged,
        validator: (value) {
          final isValid = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value!);
          if (isValid) {
            return null;
          }
          return 'Please enter a valid email';
        });
  }

  factory BorderedTextField.password(
      {Key? key, void Function(String?)? onChanged, String? initialValue}) {
    return BorderedTextField(
      key: key,
      label: 'Password',
      hint: 'Enter your password',
      initialValue: initialValue,
      onChanged: onChanged,
      obscureText: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
    );
  }
}
