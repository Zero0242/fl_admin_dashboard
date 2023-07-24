import 'package:admin_dashboard/models/usuario_auth.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:flutter/material.dart';

class UsersDataSource extends DataTableSource {
  UsersDataSource(this.users);
  final List<Usuario> users;
  Widget avatar(Usuario user) => user.img == null
      ? Image.asset('assets/no-image.jpg', width: 35, height: 35)
      : FadeInImage.assetNetwork(placeholder: 'assets/loader.gif', image: user.img!, width: 35, height: 35);
  @override
  DataRow? getRow(int index) {
    final user = users[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(ClipOval(child: avatar(user))),
        DataCell(Text(user.nombre)),
        DataCell(Text(user.correo)),
        DataCell(Text(user.uid)),
        DataCell(
          IconButton(
            onPressed: () {
              NavigationService.navigateTo('${Flurorouter.usersRoute}/${user.uid}');
            },
            icon: const Icon(Icons.edit_outlined),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => users.length;

  @override
  int get selectedRowCount => 2;
}
