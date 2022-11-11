import 'package:flutter/material.dart';
import 'package:lab2_task/screens/lab13/dbHelper/db_helper.dart';
import 'package:lab2_task/screens/lab13/model/product.dart';
import 'package:lab2_task/screens/lab13/model/sort_by.dart';
import 'package:lab2_task/screens/lab13/pages/add_products.dart';
import 'package:lab2_task/screens/lab13/widgets/product_tile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Product> products = [];
  bool isLoading = false;

  Future loadProducts() async {
    setState(() {
      isLoading = true;
    });
    products = await DbHelper.instance.getAllProducts();
    setState(() {
      isLoading = false;
    });
    print("Loaded Succesfully");
  }

  @override
  void initState() {
    super.initState();
    DbHelper.instance;
    loadProducts().then((value) {
      products = SortByTrigger.initialSort(products);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 13'),
        actions: [
          PopupMenuButton<String>(
            icon: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'Sort by',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const Icon(Icons.arrow_drop_down_outlined, size: 20),
              ],
            ),
            iconSize: MediaQuery.of(context).size.width * 0.25,
            onSelected: (val) {
              switch (val) {
                case 'initial':
                  products = SortByTrigger.initialSort(products);
                  break;
                case 'name':
                  products = SortByTrigger.sortByName(products);
                  break;
                case 'type':
                  products = SortByTrigger.sortByType(products);
                  break;
                case 'family':
                  products = SortByTrigger.sortByFamily(products);
                  break;
                case 'unit':
                  products = SortByTrigger.sortByUnits(products);
                  break;
              }
              setState(() {});
            },
            itemBuilder: (context) {
              return buildDropDownItems();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: products.isNotEmpty
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: products.isEmpty
                        ? Center(
                            child: Text(
                              'No products added!',
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        : ListView.builder(
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              return ProductTile(
                                product: products[index],
                                onTapped: () {
                                  loadProducts().then((value) {
                                    products =
                                        SortByTrigger.initialSort(products);
                                    setState(() {});
                                  });
                                },
                              );
                            },
                          ),
                  ),
            SizedBox(width: MediaQuery.of(context).size.width),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                ),
                onPressed: () async {
                  final result =
                      await navigateTo(context, const AddProductsPage())
                          as List<Product>;
                  if (result != null) {
                    for (Product product in result) {
                      await DbHelper.instance.insertProduct(product);
                    }
                    print("Added Succesfully");
                    loadProducts().then((value) {
                      products = SortByTrigger.initialSort(products);
                      setState(() {});
                    });
                  }
                  setState(() {});
                },
                label: const Text('Add New Products'),
                icon: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PopupMenuItem<String>> buildDropDownItems() {
    return [
      // const PopupMenuItem(
      //   child: Text('initial'),
      //   value: 'initial',
      // ),
      const PopupMenuItem(
        child: Text('name'),
        value: 'name',
      ),
      const PopupMenuItem(
        child: Text('type'),
        value: 'type',
      ),
      const PopupMenuItem(
        child: Text('family'),
        value: 'family',
      ),
      const PopupMenuItem(
        child: Text('unit'),
        value: 'unit',
      ),
    ];
  }
}

navigateTo(context, Widget destination) async {
  return await Navigator.push(
      context, MaterialPageRoute(builder: (context) => destination));
}
