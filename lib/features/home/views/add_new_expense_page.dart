import 'package:expense_tracker_app/core/commons/icon_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddNewExpensePage extends StatelessWidget {
  const AddNewExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              "Add Expense",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            height: 80,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: const IconTextFieldWidget(
                              icon: FontAwesomeIcons.dollarSign,
                            ),
                          ),
                          const SizedBox(height: 30),
                          const IconTextFieldWidget(
                            icon: FontAwesomeIcons.list,
                          ),
                          const SizedBox(height: 20),
                          const IconTextFieldWidget(
                            icon: Icons.note_alt,
                          ),
                          const SizedBox(height: 20),
                          const IconTextFieldWidget(
                            icon: FontAwesomeIcons.calendarDay,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                print("clicked Save");
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.tertiary,
                      Theme.of(context).colorScheme.secondary,
                      Theme.of(context).colorScheme.primary,
                    ],
                  ),
                ),
                child: const Center(
                  child: Text(
                    "SAVE",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
