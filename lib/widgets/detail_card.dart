import 'package:flutter/material.dart';
import '../transaction_page.dart';
import 'checkbox.dart';

class DetailCard extends StatefulWidget {
  const DetailCard({
    super.key,
    required this.amount,
    required this.name,
    this.onClick,
    required this.onBalanceChange,
    required this.convertAmount,
  });

  final String amount;
  final String name;
  final Function()? onClick;
  final ValueChanged<double> onBalanceChange;
  final double Function(String) convertAmount;

  @override
  _DetailCardState createState() => _DetailCardState();
}

class _DetailCardState extends State<DetailCard> {
  bool _isChecked = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onBalanceChange(widget.convertAmount(widget.amount));
    });
  }

  void _onCheckboxChanged(bool? value) {
    setState(() {
      _isChecked = value ?? false;
      final balanceChange = _isChecked
          ? widget.convertAmount(widget.amount)
          : -widget.convertAmount(widget.amount);
      widget.onBalanceChange(balanceChange);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Opacity(
        opacity: _isChecked ? 1.0 : 0.5,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransactionScreen(
                        accountName: widget.name,
                        amount: widget.amount,
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.name,
                              style: const TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            const Text(
                              'Account detail',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 12.0,
                              color: Colors.green,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          widget.amount,
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const SizedBox(
                    height: 40,
                    child: VerticalDivider(
                      width: 10,
                      thickness: 1,
                    ),
                  ),
                  MyCheckbox(
                    value: _isChecked,
                    onChanged: _onCheckboxChanged,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

