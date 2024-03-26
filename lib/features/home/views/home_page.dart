import 'package:expense_tracker_app/features/home/views/add_new_expense_page.dart';
import 'package:expense_tracker_app/features/home/views/main_screen.dart';
import 'package:expense_tracker_app/features/stats/views/stats_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activePage = 0;

  void changePage(int pageNumber) {
    setState(() {
      activePage = pageNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: BottomNavigationBar(
            onTap: (pageNumber) {
              changePage(pageNumber);
            },
            currentIndex: activePage,
            elevation: 5,
            backgroundColor: Colors.white,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                  label: '', icon: Icon(CupertinoIcons.home)),
              BottomNavigationBarItem(
                label: '',
                icon: Icon(CupertinoIcons.graph_square_fill),
              ),
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const AddNewExpensePage()));
          },
          child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.tertiary,
                      Theme.of(context).colorScheme.secondary,
                      Theme.of(context).colorScheme.primary,
                    ],
                    transform: const GradientRotation(3.14 / 4),
                  )),
              child: const Icon(CupertinoIcons.add))),
      body: activePage == 0 ? const MainScreen() : const StatsPage(),
    );
  }
}
