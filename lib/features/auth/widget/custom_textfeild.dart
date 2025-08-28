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
      style: TextStyle(color: Colors.white),
      controller: widget.controller,
      obscureText: _obscureText,
      validator: widget.validator,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2.0),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: const Color(0xFF1F2E4C), width: 2.0),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        label: Text(widget.lable, style: TextStyle(color: Colors.white)),
        prefixIcon: widget.icon,
        suffixIcon: widget.obscure
            ? IconButton(
                icon: Icon(
                  color: Color(0xFF1F2E4C),
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
