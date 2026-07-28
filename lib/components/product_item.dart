import 'package:flutter/material.dart';
import '../models/product.dart';
import '../utils/currency_formatter.dart';

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
        title: Text(product.title, style: TextStyle(color: Colors.black)),
        subtitle: Text(
          '${CurrencyFormatter.formatPrice(product.price)} kz',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
        trailing: Column(
          mainAxisSize: .min,
          children: [
            Expanded(
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit, color: Colors.red.shade600),
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () {},
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
