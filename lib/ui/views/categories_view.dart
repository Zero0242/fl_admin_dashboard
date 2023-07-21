import 'package:flutter/material.dart';

import '../cards/white_card.dart';
import '../labels/custom_labels.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: <Widget>[
        Text('Vista Categoria', style: CustomLabels.h1),
        const SizedBox(height: 10),
        const WhiteCard(
          title: 'Categoria Titulo',
          child: Text('Hola Mundo'),
        )
      ],
    );
  }
}
