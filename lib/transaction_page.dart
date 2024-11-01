import 'package:flutter/material.dart';
import 'package:all_balance_frontend/widgets/credit_transaction.dart';
import 'package:all_balance_frontend/widgets/debit_transaction.dart';
import 'package:all_balance_frontend/widgets/detail_widget.dart';
import 'package:all_balance_frontend/widgets/three_dot_icon.dart';

class TransactionScreen extends StatefulWidget {
  final String accountName;
  final String amount;

  const TransactionScreen({
    Key? key,
    required this.accountName,
    required this.amount,
  }) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  bool _detailsVisible = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();
  final TextEditingController _parentCategoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.accountName;

    double amountAsDouble = _convertAmount(widget.amount);
    String formattedAmount = _formatBalanceWithIndianCommas(amountAsDouble);

    _balanceController.text = '₹$formattedAmount';
    _parentCategoryController.text = 'All Balances';
  }

  double _convertAmount(String amount) {
    if (amount.endsWith('K')) {
      return (double.parse(amount.replaceAll('₹', '').replaceAll('K', '')) * 1000).roundToDouble();
    } else if (amount.endsWith('L')) {
      return (double.parse(amount.replaceAll('₹', '').replaceAll('L', '')) * 100000).roundToDouble();
    } else {
      return double.parse(amount.replaceAll('₹', '')).roundToDouble();
    }
  }

  String _formatBalanceWithIndianCommas(double balance) {
    String balanceStr = balance.toStringAsFixed(0);
    int length = balanceStr.length;

    if (length > 3) {
      balanceStr = balanceStr.substring(0, length - 3) + ',' + balanceStr.substring(length - 3);
    }

    for (int i = length - 3; i > 2; i -= 2) {
      if (i - 2 > 0) {
        balanceStr = balanceStr.substring(0, i - 2) + ',' + balanceStr.substring(i - 2);
      }
    }

    return balanceStr;
  }

  @override
  Widget build(BuildContext context) {
    double amountAsDouble = _convertAmount(widget.amount);
    String formattedAmount = _formatBalanceWithIndianCommas(amountAsDouble);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          ThreeDotMenu(
            onDetailsVisible: () {
              setState(() {
                _detailsVisible = true;  // Show details when "Edit" is clicked
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Bank Account', style: TextStyle(fontSize: 17)),
                    SizedBox(width: 3),
                    Icon(Icons.brightness_1, size: 7),
                    SizedBox(width: 3),
                    Text('State Bank of India', style: TextStyle(fontSize: 17)),
                  ],
                ),
                Text(
                  '₹$formattedAmount',
                  style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _detailsVisible = !_detailsVisible;
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (!_detailsVisible)
                        const Text(
                          'Details',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      if (_detailsVisible)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: DetailsSection(
                            nameController: _nameController,
                            balanceController: _balanceController,
                            parentCategoryController: _parentCategoryController,
                            isBalanceEditable: true, // Allow balance editing only here
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text('Transactions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text('Sat, 17 Jul 2024', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
                ),
                DebitTransactionCard(userName: 'Raj Kishor', time: DateTime.now().toString(), amount: '57'),
                CreditTransactionCard(userName: 'Raj Kishor', time: DateTime.now().toString(), amount: '125'),
                DebitTransactionCard(userName: 'Raj Kishor', time: DateTime.now().toString(), amount: '57'),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text('Sat, 17 Jul 2024', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
                ),
                DebitTransactionCard(userName: 'Raj Kishor', time: DateTime.now().toString(), amount: '57'),
                CreditTransactionCard(userName: 'Raj Kishor', time: DateTime.now().toString(), amount: '125'),
                DebitTransactionCard(userName: 'Raj Kishor', time: DateTime.now().toString(), amount: '57'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
