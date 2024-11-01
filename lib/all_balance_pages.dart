import 'package:all_balance_frontend/widgets/balance_details.dart';
import 'package:flutter/material.dart';
import 'package:all_balance_frontend/widgets/card_overview.dart';

class AllBalancesPage extends StatefulWidget {
  const AllBalancesPage({super.key});

  @override
  _AllBalancesPageState createState() => _AllBalancesPageState();
}


class _AllBalancesPageState extends State<AllBalancesPage> {
  double _totalBalance = 0.0;

  // Function to convert string amount with suffixes to a numeric value
  double _convertAmount(String amount) {
    if (amount.endsWith('K')) {
      return (double.parse(amount.replaceAll('₹', '').replaceAll('K', '')) * 1000).roundToDouble();
    } else if (amount.endsWith('L')) {
      return (double.parse(amount.replaceAll('₹', '').replaceAll('L', '')) * 100000).roundToDouble();
    } else {
      return double.parse(amount.replaceAll('₹', '')).roundToDouble();
    }
  }


  // Function to update the total balance
  void _updateTotalBalance(double change) {
    setState(() {
      _totalBalance += change;
    });
  }

  // Function to navigate to the Balance Details Page
  void navigateToDetails(String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BalanceDetailsPage(title: title),
      ),
    );
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
        balanceStr = balanceStr.substring(0, i - 2) + ',' + balanceStr.substring(i - 2);
      }
    }

    return balanceStr;
  }


  // Function to show a message using ScaffoldMessenger
  void _showInfoMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Total balance is the sum of all the categories included"),
        duration: Duration(seconds: 2), // Duration for which the snackbar is shown
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Dummy data for balance amounts
    final balances = [
      '₹1.57L',
      '₹1.45K',
      '₹2.56L',
      '₹900',
      '₹1.32',
    ];

    // Corresponding names for the balances
    final balanceNames = [
      'Bank Account',
      'Digital Wallets',
      'Investments',
      'Cash',
      'Uncategorised',
    ];

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            // Display Total Balance
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'All Balance',
                  style: TextStyle(fontSize: 17),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: _showInfoMessage, // Call the function to show the message
                  child: const Icon(
                    Icons.info_outline,
                    size: 15,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2,),
            // Display the calculated total balance
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₹${_formatBalanceWithIndianCommas(_totalBalance)}',
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
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
            const SizedBox(height: 40),
            // List of balance cards
            SizedBox(
              height: 450,
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(balances.length, (index) {
                    return CardOverview(
                      amount: balances[index],
                      name: balanceNames[index],
                      children: 3,
                      onClick: () => navigateToDetails(balanceNames[index]),
                      onBalanceChange: _updateTotalBalance,
                      convertAmount: _convertAmount,
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
