import '../models/product.dart';
import '../models/category.dart';

final dummyData = [
  Product(
    id: 'p1',
    name: 'Hambúrguer Especial',
    description: 'Hambúrguer artesanal com queijo e bacon.',
    price: 6500.00, // AOA
    imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd',
    category: Category.alimento,
  ),
  Product(
    id: 'p2',
    name: 'Salada de Escarola',
    description: 'Salada de Escarola com Bacon e Molho de Mostarda.',
    price: 5339.00, // AOA
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2NTdyoN8TYRYog-UhfEDi6inLA_-pE9KkwQ&s',
    category: Category.alimento,
  ),
  Product(
    id: 'p3',
    name: 'Coca-Cola',
    description: 'A melhor Coca-Cola de sempre.',
    price: 1169.00, // AOA
    imageUrl:
        'https://thumbs.dreamstime.com/b/uma-lata-de-lat%C3%A3o-coca-fresca-com-pano-fundo-parede-tijolos-empresa-cocacola-%C3%A9-marca-mais-popular-do-mundo-207487293.jpg',
    category: Category.refrigerante,
  ),
  Product(
    id: 'p4',
    name: 'Tequila Ouro',
    description: 'Tequila Ouro Jose Cuervo 750.',
    price: 32000.00, // AOA
    imageUrl:
        'https://images.tcdn.com.br/img/img_prod/1303599/tequila_jose_cuervo_especial_gold_750_ml_71_2_32f600077f21797ba6eaa38045e306bb.jpg',
    category: Category.refrigerante,
  ),
];
