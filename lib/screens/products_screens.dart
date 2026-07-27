import 'package:flutter/material.dart';
import '../components/app_drawer.dart';

class ProductsScreens extends StatelessWidget {
  const ProductsScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gerenciar Produtos')),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Text(
              'data',
              style: TextStyle(fontSize: 30, color: Colors.black),
            );
          },
        ),
      ),
    );
  }
}
