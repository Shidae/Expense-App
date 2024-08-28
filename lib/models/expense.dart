import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

// call UUid() class to create an object with unique id
const uuid = Uuid();

final formatter = DateFormat.yMd();

enum Category { leisure, travel, food, investment, rent }

// initialize icons corresponding to each Category
// the map is saved into the class property category
const categoryIcons = {
  Category.leisure: Icons.sports_baseball_outlined,
  Category.travel: Icons.beach_access_outlined,
  Category.food: Icons.fastfood_outlined,
  Category.investment: Icons.attach_money_outlined,
  Category.rent: Icons.house_outlined,


};

// here is the blueprint of outputting the expenses
class Expense {
  Expense({required this.title,
    required this.amount,
    required this.date,
    required this.category})
      : id = uuid.v4();

  final String id; // unique ID for each entry
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  // instead of outputting default format, reformat it
  String get formattedDate => formatter.format(date);
}

class ExpenseBucket {
  const ExpenseBucket({required this.expenses, required this.category});

  // forCategory is an utility constructor function that filters out expenses
  // that belong to a specific category.
  // the constructor function receives all expenses and category.
  // set initializer : after the parentheses
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses.where((expenses) => expenses.category ==
      category).toList();


  final Category category;
  final List<Expense> expenses;

  // get the total amount of expenses
  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;

  }
}
