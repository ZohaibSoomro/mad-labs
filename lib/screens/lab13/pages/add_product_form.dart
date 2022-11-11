import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lab2_task/screens/lab13/model/product.dart';

class AddProductForm extends StatefulWidget {
  const AddProductForm({Key? key}) : super(key: key);

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final formKey = GlobalKey<FormState>();
  final productNameController = TextEditingController();
  final productUnitController = TextEditingController();
  ProductCategory? productType;
  final productFamilyController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    productFamilyController.dispose();
    productUnitController.dispose();
    productNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add a Product'),
          leading: Text(''),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: productNameController,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "enter product name";
                            }
                            return null;
                          },
                          decoration: buildDecoration('product name'),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Text(
                                'Select type',
                                style: TextStyle(
                                  color: productType != null
                                      ? Colors.grey.shade700
                                      : Colors.red.shade800,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(width: 30),
                              Flexible(
                                child: DropdownButton<ProductCategory>(
                                  value: productType,
                                  onChanged: (val) {
                                    productType = val;
                                    setState(() {});
                                  },
                                  items: List.generate(
                                    ProductCategory.values.length,
                                    (index) =>
                                        DropdownMenuItem<ProductCategory>(
                                      child: Text(
                                          ProductCategory.values[index].name),
                                      value: ProductCategory.values[index],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: productFamilyController,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "enter product family";
                            }
                            return null;
                          },
                          decoration: buildDecoration('product family'),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: productUnitController,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              "enter product unit";
                            }
                            try {
                              int.parse(val!);
                            } catch (e) {
                              return "enter a number";
                            }
                            return null;
                          },
                          decoration: buildDecoration('product unit'),
                        ),
                        const SizedBox(height: 10),
                        buildButton(
                          context,
                          'Add',
                          Icons.add,
                          onPressed: () async {
                            if (formKey.currentState!.validate() &&
                                productType != null) {
                              setState(() {});
                              final product = Product(
                                name: productNameController.text,
                                type: productType!,
                                family: productFamilyController.text,
                                unit: int.parse(productUnitController.text),
                              );
                              Fluttertoast.showToast(
                                msg: "Product added successfully.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.blue,
                                textColor: Colors.white,
                                fontSize: 14.0,
                              );
                              print("Data inserted/updated");
                              Navigator.pop<Product?>(context, product);
                            }
                          },
                        ),
                        buildButton(
                          context,
                          'Cancel',
                          Icons.clear,
                          bgColor: Colors.red.shade600,
                          onPressed: () async {
                            Fluttertoast.showToast(
                              msg: "Action canceled by user.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Colors.white,
                              textColor: Colors.red,
                              fontSize: 14.0,
                            );
                            Navigator.pop<Product?>(context, null);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildDecoration(hint) => InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      hintText: hint);
}

Widget buildButton(context, text, icon,
    {required VoidCallback onPressed, Color bgColor = Colors.blue}) {
  return Container(
    margin: const EdgeInsets.all(3),
    width: MediaQuery.of(context).size.width * 0.6,
    child: ElevatedButton.icon(
      onPressed: onPressed,
      label: Text(text),
      icon: Icon(icon),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 10),
        backgroundColor: bgColor,
      ),
    ),
  );
}
