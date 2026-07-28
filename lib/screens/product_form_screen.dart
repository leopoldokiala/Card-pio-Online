import 'dart:math';

import 'package:flutter/material.dart';
import '../components/product_form_field.dart';
import '../models/product.dart';

enum Category { alimento, refrigerante }

class ProductFormScreen extends StatefulWidget {
  const ProductFormScreen({super.key});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();

  final _imageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object?>{};
  Category? _selectedCategory;

  void _updateImage() {
    setState(() {});
  }

  void _submitForm() {
    _formKey.currentState?.save();
    final newProduct = Product(
      id: Random().nextDouble().toString(),
      title: _formData['name'] as String,
      description: _formData['description'] as String,
      price: _formData['price'] as double,
      imageUrl: _formData['imageUrl'].toString(),
      category: _formData['category'] as String,
    );
    debugPrint(newProduct.title);
    debugPrint(newProduct.imageUrl);
    debugPrint(newProduct.category);
  }

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(_updateImage);
  }

  @override
  void dispose() {
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.dispose();
    _imageController.removeListener(_updateImage);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Produto')),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
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
                  child: _imageController.text.isEmpty
                      ? Column(
                          mainAxisAlignment: .center,
                          children: [
                            Icon(
                              Icons.photo_camera,
                              size: 70,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            Text('Adicionar foto do Produto'),
                          ],
                        )
                      : FittedBox(
                          child: Image.network(
                            _imageController.text,
                            fit: BoxFit.cover,
                          ),
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
                textInputAction: TextInputAction.next,
                label: 'Nome',
                maxLines: 1,
                onSaved: (name) => _formData['name'] = name ?? '',
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_imageUrlFocus);
                },
              ),
              ProductFormField(
                controller: _imageController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                maxLines: 1,
                label: 'URL da imagem',
                focusNode: _imageUrlFocus,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
              ),
              ProductFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.next,
                focusNode: _priceFocus,
                label: 'Preço',

                onSaved: (price) =>
                    _formData['price'] = double.tryParse(price ?? '0.0') ?? 0.0,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocus);
                },
              ),
              Row(
                children: [
                  Text(
                    'Selecione uma categoria:',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(width: 8.0),
                  DropdownButton<Category>(
                    value: _selectedCategory,
                    items: Category.values.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                        ), // ou usar switch para traduzir
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCategory = newValue!;
                      });
                    },
                  ),
                ],
              ),
              ProductFormField(
                keyboardType: TextInputType.text,
                focusNode: _descriptionFocus,
                label: 'Descrição',
                maxLines: 3,
                textInputAction: TextInputAction.done,
                onSaved: (description) =>
                    _formData['description'] = description ?? '',
                onFieldSubmitted: (_) => _submitForm(),
              ),
              SizedBox(height: 8.0),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.secondary,
                  ),
                ),
                onPressed: () {
                  _submitForm();
                },
                child: Text(
                  'Salvar Produto',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
