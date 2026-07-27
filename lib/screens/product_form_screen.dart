import 'package:flutter/material.dart';

class ProductFormScreen extends StatelessWidget {
  const ProductFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Produto')),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: .center,
                  children: [
                    Icon(
                      Icons.photo_camera,
                      size: 70,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    Text('Adicionar foto do Produto'),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Row(
                  mainAxisAlignment: .end,
                  children: [
                    Icon(
                      Icons.edit,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 18,
                    ),
                    Text(
                      'Alterar Foto',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
