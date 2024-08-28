import 'package:expense_app/models/expense.dart';
import 'package:expense_app/widgets/expense_list/expense_item.dart';
import 'package:flutter/material.dart';

// here is the scrollable list view of the expenses
class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key, required this.expense, required this.onRemoveExpense});

  final List<Expense> expense;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(context) {
    return ListView.builder(
        itemCount: expense.length,
        itemBuilder: (ctx, index) => Dismissible(
            key: ValueKey(expense[index]),
            direction: DismissDirection.endToStart,
            background: Container(
              // height: 20,
              color: Theme.of(context).colorScheme.error.withOpacity(0.6),
              // alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            onDismissed: (direction) {
              onRemoveExpense(expense[index]);
            },
            child: ExpenseItem(expense: expense[index])));
  }
}
