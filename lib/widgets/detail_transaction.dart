import 'package:flutter/material.dart';
import 'package:indian_currency_to_word/indian_currency_to_word.dart';
import 'package:intl/intl.dart';

class TransactionDetailScreen extends StatelessWidget {
  final String transactionType; // "Credit" or "Debit"
  final String userName;
  final String amount;
  final String time;
  final String refNo;

  const TransactionDetailScreen({
    Key? key,
    required this.transactionType,
    required this.userName,
    required this.amount,
    required this.time,
    required this.refNo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isCredit = transactionType == 'Credit';
    final Color amountColor = isCredit ? Colors.green : Colors.black;
    final convertor = AmountToWords();
    double finalAmount = double.parse(amount);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Amount',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${isCredit ? '+' : '-'}₹$amount',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: amountColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${convertor.convertAmountToWords(finalAmount, ignoreDecimal: true)} Only',
                ),
                SizedBox(height: 5,),
                const Divider(),
                const SizedBox(height: 10),

                // Replacing RichText and TextSpan with individual Text widgets
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    isCredit ? 'Received From' : 'Paid To',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Text(
                  userName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  'State Bank Of India -X1269',
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      formatDate(DateTime.now()), // Format the date
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),

                const Divider(),

                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    isCredit ? 'Credited To' : 'Debited From',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Text('State Bank Of India -X1569\nRef No: $refNo',style: TextStyle(fontSize: 16),),

                const Divider(),

                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: const Text(
                    'The above information is fetched from',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 212, 199, 199),
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Message',
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20,),
                      const Text(
                        'Dear UPI user A/C X1269 debited by 105.0 on date 17Jul24 trf to RAJEEV KUMAR Refno 419933501803. If not u? call 1800111109. -SBIA',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatDate(DateTime dateTime) {
    // DateFormat to create the desired output
    final DateFormat formatter = DateFormat('d MMMM yyyy, h:mm a');
    return formatter.format(dateTime);
  }
}

