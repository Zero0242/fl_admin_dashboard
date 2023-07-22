import 'package:admin_dashboard/models/usuario_auth.dart';
import 'package:admin_dashboard/providers/user_form_provider.dart';
import 'package:admin_dashboard/providers/users_provider.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../cards/white_card.dart';
import '../labels/custom_labels.dart';

class UserView extends StatefulWidget {
  const UserView({super.key, required this.uid});
  final String uid;

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  Usuario? _user;
  @override
  void initState() {
    final form = Provider.of<UserFormProvider>(context, listen: false);
    Provider.of<UsersProvider>(context, listen: false).getUser(widget.uid).then((userDB) {
      if (userDB != null) {
        form.user = userDB;
        setState(() => _user = userDB);
      } else {
        NavigationService.navigateTo(Flurorouter.usersRoute);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _user = null;
    Provider.of<UserFormProvider>(context, listen: false).user = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: <Widget>[
          Text('User View', style: CustomLabels.h1),
          const SizedBox(height: 10),
          if (_user == null)
            WhiteCard(
              child: Container(
                height: 300,
                alignment: Alignment.center,
                child: const CircularProgressIndicator.adaptive(),
              ),
            ),
          if (_user != null) const _UserViewBody(),
        ],
      ),
    );
  }
}

class _UserViewBody extends StatelessWidget {
  const _UserViewBody();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
        columnWidths: const {0: FixedColumnWidth(250)},
        children: const <TableRow>[
          // Todo ancho columna
          TableRow(children: <Widget>[
            // Todo avatar
            _AvatarContainer(),
            // Todo formulario editar
            _UserViewForm(),
          ])
        ],
      ),
    );
  }
}

class _UserViewForm extends StatelessWidget {
  const _UserViewForm();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserFormProvider>(context);
    final user = provider.user!;

    return WhiteCard(
      title: 'Información general',
      child: Form(
        key: provider.formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: <Widget>[
            TextFormField(
              initialValue: user.nombre,
              onChanged: (value) => provider.copyUserWith(nombre: value),
              decoration: CustomInputs.formInputDecoration(
                hint: "Nombre del usuario",
                label: "Nombre",
                icon: Icons.supervised_user_circle_outlined,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese un nombre';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: user.correo,
              onChanged: (value) => user.correo = value,
              decoration: CustomInputs.formInputDecoration(
                hint: "Correo del usuario",
                label: "Correo",
                icon: Icons.mark_email_read_outlined,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese un Correo';
                }
                if (!EmailValidator.validate(value)) {
                  return 'El correo no es válido';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 150),
              child: ElevatedButton(
                  onPressed: () async {
                    final save = await provider.updateUser();
                    if (save) {
                      NotificationService.showSnackBar('Usuario actualizado');
                      Provider.of<UsersProvider>(context, listen: false).refreshUser(user);
                    } else {
                      NotificationService.showSnackBarError('No se pudo guardar');
                    }
                  },
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.indigo),
                      shadowColor: MaterialStatePropertyAll(Colors.transparent)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.save_outlined),
                      Text('Guardar'),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class _AvatarContainer extends StatelessWidget {
  const _AvatarContainer();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserFormProvider>(context);
    final user = provider.user!;
    return WhiteCard(
      width: 250,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Profile', style: CustomLabels.h2),
            const SizedBox(height: 20),
            SizedBox(
              width: 150,
              height: 160,
              child: Stack(
                children: [
                  ClipOval(child: Image.asset('assets/no-image.jpg')),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 5),
                      ),
                      child: FloatingActionButton(
                        backgroundColor: Colors.indigo,
                        elevation: 9,
                        onPressed: () {},
                        child: const Icon(Icons.camera_alt_outlined, size: 20),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              user.nombre,
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
