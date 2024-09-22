import 'package:elevechurch/layers/presentation/blocs/auth/auth_bloc.dart';
import 'package:elevechurch/layers/presentation/blocs/auth/auth_event.dart';
import 'package:elevechurch/layers/presentation/screens/user/create_user_page.dart';
import 'package:elevechurch/layers/presentation/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        const Header(),
        SliverToBoxAdapter(
          child: Column(
            children: [
              const Divider(indent: 20, endIndent: 20),
              ListTile(
                leading: const Icon(Icons.edit_outlined),
                title: const Text('Editar dados'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateUserPage(),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.badge_outlined),
                title: const Text('Carterinha do membro'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Container(),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.event_note_outlined),
                title: const Text('Minhas escalas'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Container(),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.attach_money_outlined),
                title: const Text('Histórico financeiro'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Container(),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.notifications_outlined),
                title: const Text('Notificações'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Container(),
                  ),
                ),
              ),
              const Divider(indent: 20, endIndent: 20),
              ListTile(
                leading: const Icon(Icons.shield_outlined),
                title: const Text('Política de Privacidade'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Container(),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('Sobre'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Container(),
                  ),
                ),
              ),
              const Divider(indent: 20, endIndent: 20),
              ListTile(
                leading: const Icon(Icons.logout_outlined),
                title: const Text('Sair da conta'),
                onTap: () => context.read<AuthBloc>().add(AuthLogout()),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
