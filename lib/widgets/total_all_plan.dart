import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'card_overview.dart';

class TotalSelector extends StatefulWidget {
  const TotalSelector({super.key});

  @override
  State<TotalSelector> createState() => _TotalSelectorState();
}

class _TotalSelectorState extends State<TotalSelector> {
  String selectedType = 'Time Period Total';
  String selectedPeriod = 'Days';
  final TextEditingController _numberController = TextEditingController(text: '10');
  final List<String> timePeriods = ['Days', 'Weeks', 'Months', 'Years'];

  double _totalBalance = 0.0;

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
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

  void _updateTotalBalance(double change) {
    setState(() {
      _totalBalance += change;
    });
  }

  @override
  Widget build(BuildContext context) {
    final balances = ['₹60K', '₹30K', '₹20K'];
    final balanceNames = ['Needs', 'Desires', 'Saving'];

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 198, 195, 195),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PopupMenuButton<String>(
                        initialValue: selectedType,
                        onSelected: (String value) {
                          setState(() {
                            selectedType = value;
                          });
                        },
                        child: Row(
                          children: [
                            Text(
                              selectedType,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(Icons.keyboard_arrow_down, color: Colors.green[700]),
                          ],
                        ),
                        itemBuilder: (BuildContext context) => [
                          const PopupMenuItem<String>(
                            value: 'Time Period Total',
                            child: Text('Time Period Total'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'Absolute Total',
                            child: Text('Absolute Total'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '₹${_totalBalance.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  if (selectedType == 'Time Period Total')
                    Row(
                      children: [
                        SizedBox(
                          width: 24,
                          child: TextField(
                            controller: _numberController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        PopupMenuButton<String>(
                          initialValue: selectedPeriod,
                          onSelected: (String value) {
                            setState(() {
                              selectedPeriod = value;
                            });
                          },
                          child: Row(
                            children: [
                              Text(
                                selectedPeriod,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(width: 2),
                              Icon(Icons.keyboard_arrow_down, color: Colors.green[700]),
                            ],
                          ),
                          itemBuilder: (BuildContext context) =>
                              timePeriods.map((String period) {
                                return PopupMenuItem<String>(
                                  value: period,
                                  child: Text(period),
                                );
                              }).toList(),
                        ),
                      ],
                    )
                  else
                    Text(
                      '0 years',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 450,
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(balances.length, (index) {
                return CardOverview(
                  amount: balances[index],
                  name: balanceNames[index],
                  children: 2,
                  onClick: () {},
                  onBalanceChange: _updateTotalBalance,
                  convertAmount: _convertAmount,
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
