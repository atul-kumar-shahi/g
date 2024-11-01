import 'package:flutter/material.dart';

class DetailsSection extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController balanceController;
  final TextEditingController parentCategoryController;
  final bool isBalanceEditable; // New parameter to control balance editability

  DetailsSection({
    required this.nameController,
    required this.balanceController,
    required this.parentCategoryController,
    this.isBalanceEditable = false, // Default is false for other screens
  });

  @override
  _DetailsSectionState createState() => _DetailsSectionState();
}

class _DetailsSectionState extends State<DetailsSection> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(15.0), // Circular border
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Details Header
          Stack(
            children: [
              Center(
                child: Text(
                  'Details',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: -6,
                bottom: 0, // Move the icon to the right corner
                child: IconButton(
                  icon: Icon(
                    isEditing ? Icons.check : Icons.edit,
                    color: Colors.black,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      isEditing = !isEditing;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Name field
          _buildEditableTextField(
            label: 'Name',
            controller: widget.nameController,
          ),
          const SizedBox(height: 10),

          // Balance field (editable based on isBalanceEditable and isEditing)
          _buildEditableTextField(
            label: 'Balance',
            controller: widget.balanceController,
            enabled: widget.isBalanceEditable, // Control editability from this parameter
          ),
          const SizedBox(height: 10),

          // Parent Category field
          _buildEditableTextField(
            label: 'Parent Category',
            controller: widget.parentCategoryController,
          ),
        ],
      ),
    );
  }

  Widget _buildEditableTextField({
    required String label,
    required TextEditingController controller,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 10.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0), // Circular borders for text fields
              borderSide: BorderSide(
                color: Colors.grey.shade400,
              ),
            ),
          ),
          readOnly: !isEditing || !enabled, // Editable only if isEditing and enabled
          style: TextStyle(
            fontSize: 14,
            color: !isEditing || !enabled ? Colors.grey : Colors.black,
          ),
        ),
      ],
    );
  }
}

