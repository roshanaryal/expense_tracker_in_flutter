import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widget/epenses-list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key,
      required this.expenseList,
      required this.onRemoveExpenseList});

  final List<Expense> expenseList;
  final void Function(Expense expense) onRemoveExpenseList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenseList.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          margin: Theme.of(context).cardTheme.margin,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.error.withOpacity(.75),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        direction: DismissDirection.endToStart,
        key: ValueKey(expenseList[index]),
        onDismissed: (direction) {
          // if (direction == DismissDirection.endToStart) {
          onRemoveExpenseList(expenseList[index]);
          // }
        },
        child: ExpenseItem(
          expenseList[index],
        ),
      ),
    );
  }
}
