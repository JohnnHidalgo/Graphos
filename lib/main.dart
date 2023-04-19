import 'package:flutter/material.dart';
import 'screens/DrawGraphos/DrawGraphos.dart';
void main() => runApp(MyApp());

// esta es una pruba de concepto

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DrawGraphos(),
    );
  }
}
