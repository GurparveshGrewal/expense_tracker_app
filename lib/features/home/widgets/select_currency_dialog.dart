import 'package:expense_tracker_app/core/commons/widgets/common_gradient_button.dart';
import 'package:expense_tracker_app/core/utils/enums.dart';
import 'package:expense_tracker_app/features/home/views/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectCurrencyDialog extends StatefulWidget {
  const SelectCurrencyDialog({super.key});

  @override
  State<SelectCurrencyDialog> createState() => _SelectCurrencyDialogState();
}

class _SelectCurrencyDialogState extends State<SelectCurrencyDialog> {
  Currency? _selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width / 1.4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome Aboard',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'To proceed ahead, please select your currency.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Currency>(
                    hint: const Text("Select Expense Category"),
                    value: _selectedCurrency,
                    items: Currency.values.map((value) {
                      return DropdownMenuItem<Currency>(
                        value: value,
                        child: Text(_getTextForCurrency(value)),
                      );
                    }).toList(),
                    onChanged: (selectedValue) {
                      setState(() {
                        _selectedCurrency = selectedValue;
                      });
                    },
                  ),
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: CommonGradientButton(
                  disabled: _selectedCurrency == null,
                  buttonTitle: 'Select Currency',
                  onTap: () {
                    Navigator.of(context).pop();
                    context.read<HomeBloc>().add(HomeSaveSelectedCurrencyEvent(
                        selectedCurrency: _selectedCurrency!));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getTextForCurrency(Currency selectedCurrency) {
    switch (selectedCurrency) {
      case Currency.cad:
        return 'CA\$ Canadian Dollar';
      case Currency.eur:
        return '€ Euro';
      case Currency.inr:
        return '₹ Indian Rupee';
      case Currency.usd:
        return '\$ American Dollar';
      default:
        return '?';
    }
  }
}
