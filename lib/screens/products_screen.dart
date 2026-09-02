import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/app_drawer.dart';
import '../providers/product_list.dart';
import '../components/product_item.dart';
import '../utils/app_route.dart';
import '../providers/product_list.dart';

class ProductsScreens extends StatefulWidget {
  const ProductsScreens({super.key});

  @override
  State<ProductsScreens> createState() => _ProductsScreensState();
}

class _ProductsScreensState extends State<ProductsScreens> {
  bool _isLoading = true;

  Future<void> _refreshProducts(BuildContext context) async {
    return await Provider.of<ProductList>(
      context,
      listen: false,
    ).loadProducts().then(
      (value) => setState(() {
        _isLoading = false;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Produtos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoute.productForm);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        color: Theme.of(context).colorScheme.secondary,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: products.itemsCount,
            itemBuilder: (context, index) {
              return ProductItem(products.items[index]);
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoute.productForm);
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
