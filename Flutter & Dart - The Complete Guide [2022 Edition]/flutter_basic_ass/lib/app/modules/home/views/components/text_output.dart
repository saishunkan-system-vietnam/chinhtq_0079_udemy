import 'package:flutter/material.dart';

class TextOutput extends StatelessWidget {
  const TextOutput({
    Key? key,
    required this.textValue
  }) : super(key: key);

  final String textValue;

  @override
  Widget build(BuildContext context) {
    return Text(this.textValue,style: TextStyle(color: Colors.redAccent,fontSize: 20));
  }
}
