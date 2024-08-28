import 'package:expense_app/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// here is where the user query is displayed in the bottom sheet
class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // this widget is in memory when the ModalBottomSheet is open
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category? _selectedCategory;

  // Capitalize only first letter
  String capitalize(String s) {
    return s[0].toUpperCase() + s.substring(1);
  }

  @override
  // the widget has to be disposed after the Sheet is closed to save memory
  void dispose() {
    // only State class can use this method, Stateless widget can't
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final earliestDate = DateTime(now.year - 12, now.month, now.day);

    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: earliestDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    // check amount
    final enteredAmount =
        double.tryParse(_amountController.text); // tryParse('Hello') => null
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0; // bool
    // check title
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null ||
        _selectedCategory == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            'Invalid input',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          content: const Text('Please enter valid input.'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('OK')),
          ],
        ),
      );
      return;
    }
    // if there is no invalid input, add a valid expense
    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory!),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, keyboardSpace + 20),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLength: 20,
                decoration: const InputDecoration(label: Text('Title: ')),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          prefixText: '€ ', label: Text('Amount: ')),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: _presentDatePicker,
                          // add onTap handler to make the text clickable
                          child: InkWell(
                            onTap: _presentDatePicker,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              // color: Colors.blue.withOpacity(0.1),
                              child: Text(_selectedDate == null
                                  ? 'No date selected'
                                  : formatter.format(_selectedDate!)),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(Icons.calendar_month_outlined))
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(children: [
                DropdownButton(
                    hint: const Text(
                      'Select category',
                      style: TextStyle(fontSize: 16),
                    ),
                    dropdownColor: Theme.of(context).colorScheme.surface,
                    value: _selectedCategory,
                    items: Category.values
                        .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                capitalize(category.name),
                                style: TextStyle(
                                    fontSize: 16,
                                    // to be able to automatically varied to dark mode
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        _selectedCategory = value;
                      });
                    }),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: _submitExpenseData,
                  // style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 16),),
                  child: const Text('Save'),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
