import 'package:flutter/material.dart';
import '../components/product_form_field.dart';

class ProductFormScreen extends StatefulWidget {
  const ProductFormScreen({super.key});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _priceFocus = FocusNode();
  final _descFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Produto')),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
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
            ProductFormField(
              keyboardType: TextInputType.text,

              label: 'Nome',
              maxLines: 1,
              onFieldSubmitted: (p0) {
                FocusScope.of(context).requestFocus(_priceFocus);
              },
            ),
            ProductFormField(
              keyboardType: TextInputType.text,
              focusNode: _priceFocus,
              label: 'Preço',
              maxLines: 1,
              onFieldSubmitted: (p0) {
                FocusScope.of(context).requestFocus(_descFocus);
              },
            ),
            ProductFormField(
              keyboardType: TextInputType.text,
              focusNode: _descFocus,
              label: 'Descrição',
              maxLines: 3,
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.secondary,
                ),
              ),
              onPressed: () {},
              child: Text(
                'Salvar Produto',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
