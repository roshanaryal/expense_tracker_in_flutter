import 'package:expense_tracker/widget/chart/chart.dart';
import 'package:expense_tracker/widget/epenses-list/expenses_list.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widget/new_expenses.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _myRegisteredExpense = [
    Expense(
        title: "Flutter course",
        amount: 1250,
        date: DateTime.now(),
        category: Category.leisure),
    Expense(
        title: "Pokhara",
        amount: 1250,
        date: DateTime.now(),
        category: Category.travel),
    Expense(
        title: "MOMO",
        amount: 1250,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: "Tea and friend",
        amount: 1250,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  void _RemoveFromExpenseList(Expense expense) {
    final index = _myRegisteredExpense.indexOf(expense);
    setState(() {
      _myRegisteredExpense.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 5),
      content: const Text("Expense deleted "),
      action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _myRegisteredExpense.insert(index, expense);
            });
          }),
    ));
  }

  void addToExpenseList(Expense expense) {
    setState(() {
      _myRegisteredExpense.add(expense);
    });
  }

  void _openAddExpenseOverLays() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpenses(
              addToExpenseList: addToExpenseList,
            ));
  }

  @override
  Widget build(context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(width);
    print(height);

    Widget mainContent = _myRegisteredExpense.isEmpty
        ? const Center(
            child: Text("No expenses found ,try adding some"),
          )
        : ExpensesList(
            expenseList: _myRegisteredExpense,
            onRemoveExpenseList: _RemoveFromExpenseList,
          );

    return Scaffold(
      appBar: AppBar(
        title: Text("Expenses tracker"),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverLays, icon: const Icon(Icons.add))
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _myRegisteredExpense),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _myRegisteredExpense)),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
