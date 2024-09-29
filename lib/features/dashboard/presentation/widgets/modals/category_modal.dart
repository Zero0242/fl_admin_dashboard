import 'package:fl_admin_dashboard/features/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/domain.dart';
import '../../providers/providers.dart';

class CategoryModal extends ConsumerStatefulWidget {
  const CategoryModal({super.key, this.categoria});
  final Categoria? categoria;
  @override
  ConsumerState<CategoryModal> createState() => _CategoryModalState();
}

class _CategoryModalState extends ConsumerState<CategoryModal> {
  String _nombre = '';
  String? _id;

  @override
  void initState() {
    _id = widget.categoria?.id;
    _nombre = widget.categoria?.nombre ?? '';
    super.initState();
  }

  void onSubmit() async {
    final provider = ref.read(categoriesNotifierProvider.notifier);
    if (_id == null) {
      provider.addCategory(_nombre);
    } else {
      provider.updateCategory(_id!, _nombre);
    }
    context.pop();
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
              Text(
                widget.categoria?.nombre ?? 'Nueva Categoria',
                style: CustomLabels.h1.copyWith(color: Colors.white),
              ),
              IconButton(
                onPressed: Navigator.of(context).pop,
                icon: const Icon(Icons.close, color: Colors.white),
              ),
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
              onPressed: onSubmit,
            ),
          ),
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
