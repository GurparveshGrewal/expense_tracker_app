import 'package:expense_tracker_app/core/commons/widgets/common_gradient_button.dart';
import 'package:expense_tracker_app/core/commons/widgets/icon_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddNewExpensePage extends StatelessWidget {
  const AddNewExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController expenseTextController = TextEditingController();
    final TextEditingController noteTextController = TextEditingController();

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
                            child: IconTextFieldWidget(
                              controller: expenseTextController,
                              icon: FontAwesomeIcons.dollarSign,
                            ),
                          ),
                          const SizedBox(height: 30),
                          IconTextFieldWidget(
                            controller: expenseTextController,
                            icon: FontAwesomeIcons.list,
                          ),
                          const SizedBox(height: 20),
                          IconTextFieldWidget(
                            controller: noteTextController,
                            icon: Icons.note_alt,
                          ),
                          const SizedBox(height: 20),
                          // TODO : remove unwanted text fields.
                          IconTextFieldWidget(
                            controller: expenseTextController,
                            icon: FontAwesomeIcons.calendarDay,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            CommonGradientButton(buttonTitle: "SAVE", onTap: () {}),
          ],
        ),
      ),
    );
  }
}
