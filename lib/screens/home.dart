import 'package:flutter/material.dart';
import 'package:flutter_code_challenge/constants/colors.dart';
import 'package:flutter_code_challenge/screens/beer_list.dart';

import 'random_beer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  final screens = [
    const BeerList(),
    const RandomBeer(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: colorPrimaryDefault,
        onTap: (value) => setState(() {
          currentIndex = value;
        }),
        currentIndex: currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_mark_rounded),
            label: 'Random Beer',
          ),
        ],
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
      ),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
    );
  }
}
