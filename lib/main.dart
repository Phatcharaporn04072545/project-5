import 'package:crud1/Screen/homepage.dart';
import 'package:crud1/widget/input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/classes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ImageFile(), 
      child: MaterialApp(
        title: "บุคคล",
        theme: ThemeData.light(),
        home: Homepage(),
        routes: {
          InputScreen.routeName: (context) => InputScreen(),
      },
    )
    );
  }
}
