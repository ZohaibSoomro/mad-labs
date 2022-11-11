import 'package:flutter/material.dart';
import 'package:lab2_task/screens/lab13/dbHelper/db_helper.dart';

import '../model/product.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({Key? key, required this.product, required this.onTapped});
  final Product product;
  final VoidCallback? onTapped;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
        side: const BorderSide(width: 0.1),
      ),
      child: ListTile(
        onTap: onTapped,
        title: Text(
          product.name.toUpperCase(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: CircleAvatar(
          radius: 27,
          child: Text(
            product.name.toUpperCase().characters.first,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        subtitle: Text(
            "${product.unit} units"), //${product.type.name}(${product.family})\n
        trailing: onTapped == null
            ? null
            : IconButton(
                icon: Icon(Icons.delete, color: Colors.red.shade700),
                onPressed: () {
                  DbHelper.instance.deleteProduct(product.name);
                  onTapped!();
                },
              ),
        contentPadding: const EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
