import 'package:elevechurch/layers/presentation/blocs/auth/auth_bloc.dart';
import 'package:elevechurch/layers/presentation/blocs/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return SliverPadding(
          padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: MediaQuery.of(context).padding.top + 20,
              bottom: 20),
          sliver: SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Olá, ${state.user?.name.split(' ').getRange(0, 1).join(' ')} 👋',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      const Text(
                        'Seja muito bem vindo ao Eleve Church!',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => {},
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(color: Colors.indigo, width: 3)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: state.user?.avatar != null
                          ? Image.network(
                              state.user!.avatar!,
                              fit: BoxFit.cover,
                            )
                          : const Center(
                              child: Icon(Icons.person_outline),
                            ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
