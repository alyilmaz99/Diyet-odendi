// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../core/constant/color_constant.dart';

class LoginTextfieldWidget extends StatefulWidget {
  LoginTextfieldWidget({
    super.key,
    this.labelText,
    this.hintText,
    this.showSuffix,
    this.functionCallBack,
    this.validator,
    this.height,
  });
  final String? labelText;
  final String? hintText;
  bool? showSuffix;
  bool showPassword = false;
  Function(String)? functionCallBack;
  String? Function(String?)? validator;
  final double? height;

  @override
  State<LoginTextfieldWidget> createState() => _LoginTextfieldWidgetState();
}

class _LoginTextfieldWidgetState extends State<LoginTextfieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        height: widget.height,
        child: TextFormField(
          key: widget.key,
          obscureText: widget.showPassword,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: widget.height ?? 20, horizontal: 10.0),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorConst.textFieldBorder,
                width: 0.1,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            labelText: widget.labelText,
            suffixIcon: widget.showSuffix!
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        widget.showPassword = !widget.showPassword;
                      });
                    },
                    icon: const Icon(Icons.remove_red_eye),
                  )
                : null,
            hintText: widget.hintText,
          ),
          onChanged: widget.functionCallBack,
          validator: widget.validator,
        ),
      ),
    );
  }
}
