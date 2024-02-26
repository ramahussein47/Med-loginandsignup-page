import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicine/pages/Login.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  runApp(const Medicine());
}

class Medicine extends StatefulWidget {
  const Medicine({super.key});

  @override
  State<Medicine> createState() => _MedicineState();
}

class _MedicineState extends State<Medicine> {
  @override
  Widget build(BuildContext context) {
    return   MaterialApp(


      debugShowCheckedModeBanner: false,
        home: Login(),
    );
  }
}
