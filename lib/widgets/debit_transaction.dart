import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'detail_transaction.dart'; // Import this for date formatting

class DebitTransactionCard extends StatelessWidget {
  final String userName;
  final String time;
  final String amount;

  const DebitTransactionCard({
    Key? key,
    required this.userName,
    required this.time,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionDetailScreen(
              transactionType: 'Debit',
              userName: userName,
              amount: amount,
              time: time,
              refNo: '429134603453', // Example reference number, adjust as needed
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        child: Icon(Icons.person, color: Colors.grey),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Debited at ${_formatTime(time)}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '-₹$amount',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              height: 1,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(String time) {
    try {
      final DateTime parsedTime = DateTime.parse(time);
      final DateFormat formatter = DateFormat.jm();
      return formatter.format(parsedTime);
    } catch (e) {
      return time;
    }
  }
}

