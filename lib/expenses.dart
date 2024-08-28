import 'package:expense_app/widgets/chart/chart.dart';
import 'package:expense_app/widgets/expense_list/expense_list.dart';
import 'package:expense_app/widgets/expense_list/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_app/models/expense.dart';

// here is the main class of the expenses app
class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Power BI Udemy Course',
        amount: 14.99,
        date: DateTime(2024, 6, 11),
        category: Category.investment),
    Expense(
        title: 'Dinner at Roadhouse',
        amount: 65.00,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: 'Trip to Ohrid',
        amount: 1000.00,
        date: DateTime(2024, 05, 19),
        category: Category.travel),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        useSafeArea: true,
        // full screen
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(
              onAddExpense: _addExpense,
            ));
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    // the index of the deleted expense
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    // overwrites snack bar which still has on the screen
    ScaffoldMessenger.of(context).clearSnackBars();
    // snack bar which contains widget (Text) to tell expenses are deleted
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 4),
      content: const Text('Expenses deleted.'),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              // insert the deleted expense at its original index
              _registeredExpenses.insert(expenseIndex, expense);
            });
          }),
    ));
  }

  @override
  Widget build(context) {
    final width = MediaQuery.of(context).size.width;
    // print(MediaQuery.of(context).size.height);

    // Centered text in the main to prompt user to add expenses if empty
    Widget mainContent = const Center(
      child: Text('No tracked expenses. Start adding by clicking +'),
    );

    // replace mainContent if the user adds expenses
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpenseList(
        expense: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Expense Tracker',
            style: TextStyle(fontSize: 22),
          ),
          actions: [
            IconButton(
                onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
          ]),
      body: width < 500
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(child: mainContent),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registeredExpenses)),
                Expanded(child: mainContent),
              ],
            ),
    );
  }
}
