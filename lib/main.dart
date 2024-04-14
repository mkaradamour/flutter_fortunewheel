import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

//
// Created by Mohanad Damour
//
//! Github
//! https://github.com/mkaradamour
//

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> items = [
    '100',
    '200',
    '300',
    '400',
    '500',
    '600',
    '700',
    '800',
    '900',
    '1000',
  ];
  int selected = 0, selectedIndex = 0;
  bool animating = false;
  StreamController<int> streamController = StreamController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Fortune Wheel"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Builder(
            builder: (context) {
              return Text("You rolled, ${items[selectedIndex]}");
            },
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            height: 300,
            child: FortuneWheel(
                animateFirst: false,
                onAnimationEnd: () {
                  // print('on animation end');
                  setState(() {
                    // selected = 2;
                    selectedIndex = selected;
                    animating = false;
                  });
                },
                onAnimationStart: () {
                  // print('on animation start');
                  setState(() {
                    animating = true;
                  });
                },
                onFling: () {
                  selected = Random().nextInt(items.length);
                  streamController.add(selected);
                },
                selected: streamController.stream,
                items: items.map((e) => FortuneItem(child: Text(e))).toList()),
          ),
          const SizedBox(height: 8.0),
          ElevatedButton(
              onPressed: () {
                if (!animating) {
                  selected = Random().nextInt(items.length);
                  streamController.add(selected);
                }

                // print(item);
              },
              child: animating ? const Text("Rolling...") : const Text("Roll"))
        ],
      ),
    );
  }
}
