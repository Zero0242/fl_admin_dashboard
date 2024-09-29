import 'package:fl_admin_dashboard/features/auth/auth.dart';
import 'package:fl_admin_dashboard/features/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../layout/dashboard_layout.dart';
import '../providers/providers.dart';
import '../views/views.dart';

class UserView extends ConsumerWidget {
  const UserView({super.key, required this.uid});
  final String uid;

  static const String route = 'users/:uid';
  static const String fullRoute = '${DashboardLayout.path}/$route';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProviderByIdProvider(uid));
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      physics: const ClampingScrollPhysics(),
      children: <Widget>[
        Text('User View', style: CustomLabels.h1),
        const SizedBox(height: 10),
        userAsync.when(
          loading: () => WhiteCard(
            child: Container(
              height: 300,
              alignment: Alignment.center,
              child: const CircularProgressIndicator.adaptive(),
            ),
          ),
          data: (data) => _UserViewBody(data),
          error: (error, stackTrace) => WhiteCard(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Row(),
                Text('Usuario no encontrado', style: CustomLabels.h2),
                LinkText(
                  text: 'Volver Atrás',
                  onTap: () {
                    context.go(UsersView.fullRoute);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _UserViewBody extends StatelessWidget {
  const _UserViewBody(this.usuario);
  final Usuario usuario;

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {0: FixedColumnWidth(250)},
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            _AvatarContainer(usuario.id),
            const _UserViewForm(),
          ],
        ),
      ],
    );
  }
}

class _UserViewForm extends StatelessWidget {
  const _UserViewForm();

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<UserFormProvider>(context);
    // final user = provider.user!;

    return WhiteCard(
      title: 'Información general',
      child: Form(
        // key: provider.formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: <Widget>[
            TextFormField(
              // initialValue: user.nombre,
              // onChanged: (value) => provider.copyUserWith(nombre: value),
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
              // initialValue: user.correo,
              // onChanged: (value) => user.correo = value,
              decoration: CustomInputs.formInputDecoration(
                hint: "Correo del usuario",
                label: "Correo",
                icon: Icons.mark_email_read_outlined,
              ),
              validator: (value) {
                return null;

                // if (value == null || value.isEmpty) {
                //   return 'Ingrese un Correo';
                // }
                // if (!EmailValidator.validate(value)) {
                //   return 'El correo no es válido';
                // }
                // return null;
              },
            ),
            const SizedBox(height: 20),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 150),
              child: ElevatedButton(
                onPressed: () async {
                  // final save = await provider.updateUser();
                  // if (save) {
                  //   NotificationService.showSnackBar('Usuario actualizado');
                  //   Provider.of<UsersProvider>(context, listen: false).refreshUser(user);
                  // } else {
                  //   NotificationService.showSnackBarError('No se pudo guardar');
                  // }
                },
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.indigo),
                  shadowColor: WidgetStatePropertyAll(Colors.transparent),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.save_outlined),
                    Text('Guardar'),
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

class _AvatarContainer extends ConsumerWidget {
  const _AvatarContainer(this.id);
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProviderByIdProvider(id)).value!;

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
                children: <Widget>[
                  ClipOval(child: avatar(user.avatar)),
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
                        onPressed: () async {
                          // final result = await FilePicker.platform.pickFiles();

                          // if (result != null) {
                          //   NotificationService.showLoadIndicator(context);
                          //   final updatedUser = await provider.uploadImage(result.files.first.bytes!);

                          //   userProvider.refreshUser(updatedUser);
                          // }
                          // Navigator.of(context).pop();
                        },
                        child: const Icon(Icons.camera_alt_outlined, size: 20),
                      ),
                    ),
                  ),
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

  Widget avatar(String? avatar) {
    if (avatar == null) return Image.asset('assets/images/no-image.jpg');
    return FadeInImage.assetNetwork(
      placeholder: 'assets/images/loader.gif',
      image: avatar,
    );
  }
}
