import 'package:all_balance_frontend/one_time_plan_form.dart';
import 'package:all_balance_frontend/repeating_plan_form.dart';
import 'package:flutter/material.dart';

class FuturePlanPage extends StatelessWidget {
  const FuturePlanPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
              child: Opacity(
                child: Image.asset(
                  'assets/images/plan.png',
                  fit: BoxFit.cover,
                ),
                opacity: 0.4,
              )
          ),
          // Content overlay
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Let Plan your Future',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(), // Add spacer to push content to middle
                  Center( // Wrap content in Center widget
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'What are you thinking to plan ?',
                          textAlign: TextAlign.center, // Center the text
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 400), // Constrain width for larger screens
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center, // Center the buttons
                            children: [
                              _buildOptionButton(
                                text: 'One Time',
                                isSelected: true,
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const OneTimePlanForm()));

                                },
                              ),
                              const SizedBox(width: 12),
                              _buildOptionButton(
                                text: 'Repeating',
                                isSelected: false,
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const RepeatingPlanForm()));

                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(), // Add spacer to push content to middle
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.green : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? Colors.green : Colors.grey.shade300,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.info_outline,
                size: 16,
                color: isSelected ? Colors.white : Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}