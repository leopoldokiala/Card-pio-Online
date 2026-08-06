import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/product_form_field.dart';
import '../models/category.dart';
import '../providers/product_list.dart';
import '../models/product.dart';

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

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile =
        url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');
    return isValidUrl && endsWithFile;
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();

    Provider.of<ProductList>(context, listen: false).saveProduct(_formData);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(_updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final product = arg as Product;
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['category'] = product.category;
        _formData['imageUrl'] = product.imageUrl;

        _selectedCategory = product.category;
        _imageController.text = product.imageUrl;
      }
    }
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

              ProductFormField(
                initialValue: _formData['name'] as String? ?? '',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                label: 'Nome',
                maxLines: 1,
                onSaved: (name) => _formData['name'] = name ?? '',
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_imageUrlFocus);
                },
                validator: (name) {
                  final newName = name ?? '';
                  if (newName.trim().isEmpty) {
                    return 'Nome é obrigatório';
                  }
                  if (newName.trim().length < 3) {
                    return 'Nome não pode ter menos de 3 letras';
                  }
                  return null;
                },
              ),
              ProductFormField(
                controller: _imageController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                maxLines: 1,
                label: 'URL da imagem',
                focusNode: _imageUrlFocus,
                onSaved: (imageUrl) => _formData['imageUrl'] = imageUrl ?? '',
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
                validator: (image) {
                  final imageUrl = image ?? '';
                  if (!isValidImageUrl(imageUrl)) {
                    return 'Informe uma Url válida';
                  }
                  return null;
                },
              ),
              ProductFormField(
                initialValue: _formData['price']?.toString() ?? '',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.next,
                focusNode: _priceFocus,
                label: 'Preço',
                onSaved: (price) =>
                    _formData['price'] = double.tryParse(price ?? '0.0') ?? 0.0,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocus);
                },
                validator: (price) {
                  final priceString = price ?? '-1';
                  final newPrice = double.tryParse(priceString) ?? -1;
                  if (newPrice <= 0) {
                    return 'Informe um preço válido';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Text(
                    'Selecione uma categoria:',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: DropdownButtonFormField<Category>(
                      initialValue: _selectedCategory,
                      decoration: InputDecoration(
                        labelText: 'Categoria',
                        labelStyle: TextStyle(color: Colors.black),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                            width: 2,
                          ),
                        ),
                      ),
                      items: Category.values.map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name.toUpperCase(),
                          ), // ou usar switch para traduzir
                        );
                      }).toList(),
                      onSaved: (value) => _formData['category'] = value,
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Selecione uma categoria';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),

              ProductFormField(
                initialValue: _formData['description'] as String? ?? '',
                keyboardType: TextInputType.text,
                focusNode: _descriptionFocus,
                label: 'Descrição',
                maxLines: 3,
                textInputAction: TextInputAction.done,
                onSaved: (description) =>
                    _formData['description'] = description ?? '',
                onFieldSubmitted: (_) => _submitForm(),
                validator: (name) {
                  final newName = name ?? '';
                  if (newName.trim().isEmpty) {
                    return 'Descrição é obrigatória';
                  }
                  if (newName.trim().length < 10) {
                    return 'Descrição não deve ter menos de 10 letras';
                  }
                  return null;
                },
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
                  // _formData['category'] == null
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
