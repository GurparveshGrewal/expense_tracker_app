import 'dart:ui';

import 'package:expense_tracker_app/features/auth/views/sign_in_page.dart';
import 'package:expense_tracker_app/features/auth/views/sign_up_page.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: const AlignmentDirectional(0.8, -1.3),
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.pink, borderRadius: BorderRadius.circular(100)),
            ),
          ),
          Positioned(
            right: -80,
            bottom: 300,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(100)),
            ),
          ),
          Positioned(
            left: -80,
            bottom: 450,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(100)),
            ),
          ),
          Positioned(
            left: -80,
            bottom: 100,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(100)),
            ),
          ),
          Positioned(
            bottom: -100,
            right: -40,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(100)),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 70.0,
              sigmaY: 70.0,
            ),
            child: Container(),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.8,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: TabBar(
                        unselectedLabelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).colorScheme.tertiary,
                              Theme.of(context).colorScheme.secondary,
                              Theme.of(context).colorScheme.primary,
                            ], // Example gradient colors
                            transform: const GradientRotation(3.14 / 4),
                          ),
                        ),
                        controller: _tabController,
                        labelStyle: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                        labelColor: Colors.white,
                        tabs: const [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: FittedBox(
                              child: Text(
                                'Sign In',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: FittedBox(
                              child: Text(
                                'Sign Up',
                              ),
                            ),
                          )
                        ]),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Expanded(
                      child: TabBarView(
                          controller: _tabController,
                          children: const [
                        SignInPage(),
                        SignUpPage(),
                      ])),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
