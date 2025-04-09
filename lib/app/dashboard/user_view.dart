import 'package:fl_admin_dashboard/config/config.dart';
import 'package:fl_admin_dashboard/domain/auth/auth.dart';
import 'package:fl_admin_dashboard/presentation/dashboard/dashboard.dart';
import 'package:fl_admin_dashboard/presentation/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'users_view.dart';

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
            _UserViewForm(usuario),
          ],
        ),
      ],
    );
  }
}

class _UserViewForm extends ConsumerStatefulWidget {
  const _UserViewForm(this.usuario);
  final Usuario usuario;

  @override
  ConsumerState<_UserViewForm> createState() => _UserViewFormState();
}

class _UserViewFormState extends ConsumerState<_UserViewForm> {
  final nombre = TextEditingController();
  final correo = TextEditingController();

  @override
  void initState() {
    final user = widget.usuario;
    nombre.text = user.nombre;
    correo.text = user.correo;
    super.initState();
  }

  void onSubmit() async {
    final userNotifier = ref.read(
      userProviderByIdProvider(widget.usuario.id).notifier,
    );
    await userNotifier.updateUser(
      correo: correo.text,
      name: nombre.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WhiteCard(
      title: 'Información general',
      child: Form(
        // key: provider.formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: nombre,
              decoration: CustomInputs.formInputDecoration(
                hint: "Nombre del usuario",
                label: "Nombre",
                icon: Icons.supervised_user_circle_outlined,
              ),
              validator: Validators.createValidation(
                message: 'Debe ingresar un nombre',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: correo,
              decoration: CustomInputs.formInputDecoration(
                hint: "Correo del usuario",
                label: "Correo",
                icon: Icons.mark_email_read_outlined,
              ),
              validator: Validators.createValidation(isEmail: true),
            ),
            const SizedBox(height: 20),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 150),
              child: ElevatedButton(
                onPressed: onSubmit,
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.indigo),
                  shadowColor: WidgetStatePropertyAll(Colors.transparent),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
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
    final user = ref.watch(userProviderByIdProvider(id));
    final userNotifier = ref.read(userProviderByIdProvider(id).notifier);

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
                  ClipOval(
                    child: user.when(
                      data: (data) => avatar(data.avatar),
                      error: (_, __) => Icon(Icons.error),
                      loading: () => CircularProgressIndicator.adaptive(),
                    ),
                  ),
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
                          final file = await PickerPlugin.pickImage();
                          if (file != null) {
                            await userNotifier.updateUserAvatar(file);
                            (context as Element).markNeedsBuild();
                          }
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
              user.value?.nombre ?? '',
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
      placeholder: 'assets/images/loading.gif',
      image: avatar,
    );
  }
}
