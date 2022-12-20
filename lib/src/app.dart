import 'package:flutter/material.dart';

import 'pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Beever Kanye West App',
      theme: ThemeData.light(useMaterial3: true),
      home: const MyHomePage(),
    );
  }
}
