import 'package:flutter/material.dart';

class ThreeDotMenu extends StatelessWidget {
  final VoidCallback? onDetailsVisible;

  const ThreeDotMenu({
    Key? key,
    this.onDetailsVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert),
      onSelected: (String result) {
        if (result == 'edit') {
          _handleEdit(context);
        } else if (result == 'delete') {
          _handleDelete(context);
        }
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 'edit',
          child: Text('Edit'),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Text('Delete'),
        ),
      ],
    );
  }

  void _handleEdit(BuildContext context) {
    // If there is a callback to show details, invoke it
    if (onDetailsVisible != null) {
      onDetailsVisible!();
    }

    // Optionally, show a message or perform other actions
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Edit clicked!')),
    );
  }

  void _handleDelete(BuildContext context) {
    // Show a delete confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete'),
        content: Text('Are you sure you want to delete this item?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Perform delete action here (e.g., call API, remove item from state)
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Item deleted')),
              );
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}

