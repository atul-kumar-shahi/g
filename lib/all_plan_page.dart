import 'package:all_balance_frontend/add_page.dart';
import 'package:all_balance_frontend/widgets/total_all_plan.dart';
import 'package:flutter/material.dart';

class FinancialPlanner extends StatelessWidget {
  const FinancialPlanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Plans'),
         centerTitle: true,
      ),
      body: Column(
        children: [
          TotalSelector(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const FuturePlanPage()));
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
