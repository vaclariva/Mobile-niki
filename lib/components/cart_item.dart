import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';
import '../models/shoe.dart';

class CartItem extends StatelessWidget {
  final Shoe shoe;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onDelete;

  const CartItem({
    required this.shoe,
    required this.onIncrement,
    required this.onDecrement,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0, // Set the desired elevation
      color: Color.fromARGB(255, 255, 255, 255), // Set the desired color and opacity
      margin: EdgeInsets.symmetric(
          vertical: 5.0, horizontal: 6.0), // Adjust the margins
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              shoe.imagePath,
              width: 50.0, // Set the desired width
              height: 50.0, // Set the desired height
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          shoe.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              icon: Transform.translate(
                offset: Offset(0.0, 0.0), // Adjust the value accordingly
                child: Icon(Icons.delete, color: Colors.red),
              ),
              onPressed: () {
                // Reset quantity to 1 and then delete the item
                shoe.quantity = 1;
                onDelete();
              },
            ),
            Transform.translate(
              offset: Offset(0.0, -20.0), // Adjust the value accordingly
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        right: 1.0), // Adjust the value accordingly
                    child: IconButton(
                      icon: Icon(Icons.add, size: 10.0),
                      onPressed: onIncrement,
                    ),
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    '${shoe.quantity}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 4.0),
                  Container(
                    margin: EdgeInsets.only(
                        left: 1.0), // Adjust the value accordingly
                    child: IconButton(
                      icon: Icon(Icons.remove, size: 10.0),
                      onPressed: onDecrement,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}