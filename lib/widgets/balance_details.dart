import 'package:all_balance_frontend/widgets/three_dot_icon.dart';
import 'package:flutter/material.dart';
import 'detail_card.dart';
import 'detail_widget.dart';

class BalanceDetailsPage extends StatefulWidget {
  final String title;

  const BalanceDetailsPage({required this.title});

  @override
  _BalanceDetailsPageState createState() => _BalanceDetailsPageState();
}

class _BalanceDetailsPageState extends State<BalanceDetailsPage> {
  bool _detailsVisible = false;
  double _totalBalance = 0.0;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();
  final TextEditingController _parentCategoryController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.title;
    _balanceController.text = '₹8,57,621.87';
    _parentCategoryController.text = 'All Balances';
  }

  double _convertAmount(String amount) {
    if (amount.endsWith('K')) {
      return (double.parse(amount.replaceAll('₹', '').replaceAll('K', '')) *
              1000)
          .roundToDouble();
    } else if (amount.endsWith('L')) {
      return (double.parse(amount.replaceAll('₹', '').replaceAll('L', '')) *
              100000)
          .roundToDouble();
    } else {
      return double.parse(amount.replaceAll('₹', '')).roundToDouble();
    }
  }

  void _updateTotalBalance(double change) {
    setState(() {
      _totalBalance += change;
    });
  }

  String _formatBalanceWithIndianCommas(double balance) {
    String balanceStr = balance.toStringAsFixed(0);
    int length = balanceStr.length;

    if (length > 3) {
      balanceStr = balanceStr.substring(0, length - 3) +
          ',' +
          balanceStr.substring(length - 3);
    }

    for (int i = length - 3; i > 2; i -= 2) {
      if (i - 2 > 0) {
        balanceStr =
            balanceStr.substring(0, i - 2) + ',' + balanceStr.substring(i - 2);
      }
    }

    return balanceStr;
  }

  @override
  Widget build(BuildContext context) {
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
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(widget.title, style: TextStyle(fontSize: 17),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₹${_formatBalanceWithIndianCommas(_totalBalance)}',
                style:
                    const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 4,),
              Column(
                children: [
                  const Text('+9%', style: TextStyle(color: Colors.green)),
                  SizedBox(height: 10),

                ],
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Details Section
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
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // List of accounts
          Expanded(
            child: ListView(
              children: [
                DetailCard(
                  amount: '₹1.57L',
                  name: 'SBI',
                  onBalanceChange: _updateTotalBalance,
                  convertAmount: _convertAmount,
                ),
                DetailCard(
                  amount: '₹1.57L',
                  name: 'ICICI',
                  onBalanceChange: _updateTotalBalance,
                  convertAmount: _convertAmount,
                ),
                DetailCard(
                  amount: '₹1.57L',
                  name: 'PNB',
                  onBalanceChange: _updateTotalBalance,
                  convertAmount: _convertAmount,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

