import 'package:expense_tracker_app/core/commons/widgets/common_gradient_button.dart';
import 'package:expense_tracker_app/core/commons/widgets/icon_text_field.dart';
import 'package:expense_tracker_app/core/commons/widgets/loader.dart';
import 'package:expense_tracker_app/core/utils/functions.dart';
import 'package:expense_tracker_app/core/utils/enums.dart';
import 'package:expense_tracker_app/core/utils/show_snackbar.dart';
import 'package:expense_tracker_app/core/wrappers/firebase_auth_wrapper.dart';
import 'package:expense_tracker_app/features/home/domain/entity/expense_entity.dart';
import 'package:expense_tracker_app/features/home/views/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class AddNewExpensePage extends StatefulWidget {
  final Currency currency;
  const AddNewExpensePage({
    required this.currency,
    super.key,
  });

  @override
  State<AddNewExpensePage> createState() => _AddNewExpensePageState();
}

class _AddNewExpensePageState extends State<AddNewExpensePage> {
  final _formKey = GlobalKey<FormState>();
  ExpenseCategory? _selectedExpense;
  DateTime? _selectedDate;

  // TextEditiongControllers
  final TextEditingController expenseTextController = TextEditingController();
  final TextEditingController noteTextController = TextEditingController();

  Future<void> _showDatePicker() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    expenseTextController.dispose();
    noteTextController.dispose();
  }

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
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeExpenseAddedSuccessState) {
            Navigator.of(context).pop();
            showSnackBar(context, "Expense added successfully.");
          } else if (state is HomeFailedState) {
            showSnackBar(context, "something went wrong :(");
          }
        },
        builder: (context, state) {
          if (state is HomeLoadingState) return const Loader();

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Expanded(
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
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                SizedBox(
                                  height: 80,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: IconTextFieldWidget(
                                    inputType: TextInputType.number,
                                    allowAmountValueOnly: true,
                                    controller: expenseTextController,
                                    icon: getIconForCurrency(widget.currency),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                IconTextFieldWidget(
                                  controller: noteTextController,
                                  icon: Icons.note_alt,
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  height: 60,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.list,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                              hint: const Text(
                                                  "Select Expense Category"),
                                              value: _selectedExpense,
                                              items: ExpenseCategory.values
                                                  .map((value) =>
                                                      DropdownMenuItem<
                                                              ExpenseCategory>(
                                                          value: value,
                                                          child: Text(
                                                              enumValueToString(
                                                                  value))))
                                                  .toList(),
                                              onChanged: (selectedValue) {
                                                setState(() {
                                                  if (selectedValue ==
                                                      _selectedExpense) {
                                                    _selectedExpense = null;
                                                  } else {
                                                    _selectedExpense =
                                                        selectedValue;
                                                  }
                                                });
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                GestureDetector(
                                  onTap: _showDatePicker,
                                  child: Container(
                                    height: 70,
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month,
                                          size: 17,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .outline,
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          _selectedDate != null
                                              ? "${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}"
                                              : "Select Expense Date",
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                CommonGradientButton(
                    disabled: false,
                    buttonTitle: "SAVE",
                    onTap: () {
                      if (_formKey.currentState!.validate() &&
                          _selectedDate != null &&
                          _selectedExpense != null) {
                        context
                            .read<HomeBloc>()
                            .add(HomeAddExpenseToDatabaseProcessEvent(
                                expense: ExpenseEntity(
                              expenseId: const Uuid().v4(),
                              userId: FirebaseAuthWrapper().currentUser!.uid,
                              title: expenseTextController.text.trim(),
                              note: noteTextController.text.trim(),
                              expenseCategory: _selectedExpense!,
                              expenseAmount: double.parse(
                                  expenseTextController.text.trim()),
                              expenseDate: _selectedDate!,
                            )));
                      }
                    }),
              ],
            ),
          );
        },
      ),
    );
  }
}
