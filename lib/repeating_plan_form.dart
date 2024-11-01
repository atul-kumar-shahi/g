import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RepeatingPlanForm extends StatefulWidget {
  const RepeatingPlanForm({Key? key}) : super(key: key);

  @override
  State<RepeatingPlanForm> createState() => _RepeatingPlanFormState();
}

class _RepeatingPlanFormState extends State<RepeatingPlanForm> {
  final PageController _pageController = PageController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _intervalController = TextEditingController();
  final TextEditingController _frequencyController = TextEditingController();
  final TextEditingController _absoluteTotalController = TextEditingController();
  final TextEditingController _timeFrameTotalController = TextEditingController();
  String? _selectedCategory;
  String? _selectedTimeUnit = 'years';
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Repeating',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildFirstPage(),
          _buildSecondPage(),
        ],
      ),
    );
  }

  Widget _buildFirstPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInputField(
            label: 'Name',
            controller: _nameController,
            hintText: 'Plan Name',
          ),
          const SizedBox(height: 16),
          _buildInputField(
            label: 'Description',
            controller: _descriptionController,
            hintText: 'Plan Description',
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          _buildInputField(
            label: 'Amount',
            controller: _amountController,
            hintText: 'Plan Amount',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          _buildDateField(),
          const SizedBox(height: 16),
          _buildIntervalRow(),
          const SizedBox(height: 16),
          _buildInputField(
            label: 'Absolute Total',
            controller: _absoluteTotalController,
            hintText: 'Absolute Total',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          _buildNextButton(),
        ],
      ),
    );
  }

  Widget _buildSecondPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInputField(
            label: 'Time Frame Total',
            controller: _timeFrameTotalController,
            hintText: 'Time Frame Total',
          ),
          const SizedBox(height: 16),
          _buildInputField(
            label: 'Amount',
            controller: _amountController,
            hintText: 'Plan Amount',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          _buildCategoryDropdown(),
          const SizedBox(height: 24),
          _buildBottomButtons(),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[400]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Starting Date',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      hintText: 'Select Date',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      suffixIcon: const Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _selectedTimeUnit,
                decoration: InputDecoration(
                  hintText: 'Time Unit',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                ),
                items: ['days', 'months', 'years']
                    .map((unit) => DropdownMenuItem(
                  value: unit,
                  child: Text(unit),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTimeUnit = value;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIntervalRow() {
    return Row(
      children: [
        Expanded(
          child: _buildInputField(
            label: 'Interval',
            controller: _intervalController,
            hintText: 'days/month/year',
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildInputField(
            label: 'Frequency',
            controller: _frequencyController,
            hintText: 'value',
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Parent category',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedCategory,
          decoration: InputDecoration(
            hintText: 'category',
            hintStyle: TextStyle(color: Colors.grey[400]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
          ),
          items: ['Category 1', 'Category 2', 'Category 3']
              .map((category) => DropdownMenuItem(
            value: category,
            child: Text(category),
          ))
              .toList(),
          onChanged: (value) {
            setState(() {
              _selectedCategory = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildNextButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text('Next'),
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // Add save functionality
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Save plan'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              // Add transactions functionality
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: Colors.grey),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Transactions',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: CalendarDatePicker(
            initialDate: _selectedDate ?? DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            onDateChanged: (DateTime date) {
              Navigator.of(context).pop(date);
            },
          ),
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('d MMMM yyyy').format(picked);
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    _intervalController.dispose();
    _frequencyController.dispose();
    _absoluteTotalController.dispose();
    _timeFrameTotalController.dispose();
    super.dispose();
  }
}