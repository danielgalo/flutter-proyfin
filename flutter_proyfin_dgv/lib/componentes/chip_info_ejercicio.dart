import 'package:flutter/material.dart';
class ChipWithMargin extends StatelessWidget {
  final Widget child;
  
  const ChipWithMargin({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const  EdgeInsets.only(right: 8.0), // Ajusta el margen según sea necesario
      child: child,
    );
  }
}