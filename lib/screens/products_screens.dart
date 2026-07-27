import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/app_drawer.dart';
import '../providers/product_list.dart';

class ProductsScreens extends StatelessWidget {
  const ProductsScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Gerenciar Produtos')),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: products.itemsCount,
          itemBuilder: (context, index) {
            return Text(
              products.items[index].title,
              style: TextStyle(fontSize: 30, color: Colors.black),
            );
          },
        ),
      ),
    );
  }
}
