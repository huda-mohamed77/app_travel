import 'package:flutter/material.dart';

class CustmsTextfeid extends StatefulWidget {
  final String lable;
  final Icon icon;

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscure;

  const CustmsTextfeid({
    super.key,
    required this.lable,
    required this.icon,

    this.controller,
    this.validator,
    this.obscure = false,
  });
  @override
  State<CustmsTextfeid> createState() => _CustomTextfaieldState();
}

class _CustomTextfaieldState extends State<CustmsTextfeid> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscure;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.blueGrey),
      controller: widget.controller,
      obscureText: _obscureText,
      validator: widget.validator,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        label: Text(widget.lable, style: TextStyle(color: Color(0xFF366EA1))),
        prefixIcon: widget.icon,
        suffixIcon: widget.obscure
            ? IconButton(
                icon: Icon(
                  color: Colors.blue,
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
    );
  }
}
