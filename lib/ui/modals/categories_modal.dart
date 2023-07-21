import 'package:admin_dashboard/ui/buttons/custom_outlined_button.dart';
import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';

import '../../models/category.dart';

class CategoryModal extends StatefulWidget {
  const CategoryModal({super.key, this.categoria});
  final Categoria? categoria;
  @override
  State<CategoryModal> createState() => _CategoryModalState();
}

class _CategoryModalState extends State<CategoryModal> {
  String _nombre = '';
  String? _id;

  @override
  void initState() {
    _id = widget.categoria?.id;
    _nombre = widget.categoria?.nombre ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      padding: const EdgeInsets.all(20),
      decoration: buildDecoration(),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(widget.categoria?.nombre ?? 'Nueva Categoria', style: CustomLabels.h1.copyWith(color: Colors.white)),
              IconButton(onPressed: Navigator.of(context).pop, icon: const Icon(Icons.close, color: Colors.white))
            ],
          ),
          Divider(color: Colors.white.withOpacity(0.3)),
          TextFormField(
            initialValue: widget.categoria?.nombre,
            onChanged: (value) => _nombre = value,
            style: const TextStyle(color: Colors.white),
            decoration: CustomInputs.authInputDecoration(
              hint: 'Nombre de la categoría',
              label: 'Categoría',
              iconData: Icons.new_releases_outlined,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            child: CustomOutlinedButton(
              color: Colors.white,
              textColor: Colors.white,
              text: 'Guardar',
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }

  BoxDecoration buildDecoration() {
    return const BoxDecoration(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
      color: Color(0xff0f2041),
      boxShadow: [
        BoxShadow(color: Colors.black26),
      ],
    );
  }
}
