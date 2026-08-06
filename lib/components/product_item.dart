import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../utils/currency_formatter.dart';
import '../utils/app_route.dart';
import '../providers/product_list.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            width: 90,
            height: 60,
            child: Image.network(product.imageUrl, fit: BoxFit.cover),
          ),
        ),
        title: Text(product.name, style: TextStyle(color: Colors.black)),
        subtitle: Text(
          '${CurrencyFormatter.formatPrice(product.price)} kz',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
        trailing: Column(
          mainAxisSize: .min,
          children: [
            Expanded(
              child: IconButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).pushNamed(AppRoute.productForm, arguments: product);
                },
                icon: Icon(Icons.edit, color: Colors.red.shade600),
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Excluir Produto'),
                        content: Text(
                          'Tem certeza?',
                          style: TextStyle(fontSize: 18),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Não',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Provider.of<ProductList>(
                                context,
                                listen: false,
                              ).removeProduct(product);
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Sim',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
