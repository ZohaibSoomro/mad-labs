import 'package:flutter/material.dart';
import 'package:lab2_task/screens/lab13/pages/add_product_form.dart';

import '../model/product.dart';
import '../widgets/product_tile.dart';

class AddProductsPage extends StatefulWidget {
  const AddProductsPage({Key? key}) : super(key: key);

  @override
  State<AddProductsPage> createState() => _AddProductsPageState();
}

class _AddProductsPageState extends State<AddProductsPage> {
  final formKey = GlobalKey<FormState>();
  final productNameController = TextEditingController();
  final productTypeController = TextEditingController();
  final productUnitController = TextEditingController();

  final productFamilyController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    productFamilyController.dispose();
    productTypeController.dispose();
    productUnitController.dispose();
    productNameController.dispose();
  }

  List<Product> productsToAdded = [];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Products'),
          centerTitle: true,
          leading: const Text(''),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: productsToAdded.isNotEmpty
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            children: [
              if (productsToAdded.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: productsToAdded.length,
                    itemBuilder: (context, index) => ProductTile(
                      product: productsToAdded[index],
                      onTapped: null,
                    ),
                  ),
                ),
              SizedBox(width: MediaQuery.of(context).size.width),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                  ),
                  onPressed: () async {
                    final product =
                        await navigateTo(context, const AddProductForm());
                    if (product == null) {
                      print("Action canceled by user");
                    } else {
                      print(product);
                      productsToAdded.add(product);
                      print(productsToAdded);
                    }
                    setState(() {});
                  },
                  label: Text(
                      'Add ${productsToAdded.isNotEmpty ? "More" : "Product"}'),
                  icon: const Icon(Icons.add),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    backgroundColor: productsToAdded.length > 0
                        ? Colors.green
                        : Colors.red.shade600,
                  ),
                  onPressed: () {
                    Navigator.pop<List<Product>>(context, productsToAdded);
                  },
                  label: Text(productsToAdded.length > 0 ? 'Done' : 'Cancel'),
                  icon: Icon(
                      productsToAdded.length > 0 ? Icons.check : Icons.close),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

navigateTo(context, Widget destination) async {
  return await Navigator.push(
      context, MaterialPageRoute(builder: (context) => destination));
}
