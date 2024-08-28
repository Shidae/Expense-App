import 'dart:math';

import 'package:expense_app/expenses.dart';
import 'package:expense_app/models/expense.dart';
import 'package:flutter/material.dart';

// here all the expense items(title, amount, date, category)
// are displayed in cards
class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});

  // expect one entry out of the lists
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // access the theme from the main.dart
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  '€${expense.amount.toStringAsFixed(2)}',
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(expense.formattedDate),
                  ],
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
