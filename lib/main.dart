import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'my_home.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  final counterModel = CounterModel();
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider.value(
        value: CounterModel(),
        child: const FirstPage(),
      ),
    );
  }
}
