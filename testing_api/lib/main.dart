import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_api/api_service.dart';
import 'package:testing_api/ui/home_page.dart';
import 'package:logging/logging.dart';

void main() {
  _setUpLogging();
  runApp(MyApp());
}

void _setUpLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((event) =>
      {print('${event.level.name}: ${event.time}: ${event.message}')});
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => ApiService.create(),
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
