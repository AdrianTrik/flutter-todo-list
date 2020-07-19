import 'package:carrefour/views/main-view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/loading-flag.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoadingFlag(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lista de compras',
        home: MainView(),
      ),
    );
  }
}
