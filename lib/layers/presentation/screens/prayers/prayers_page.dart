import 'package:elevechurch/core/utils/contants.dart';
import 'package:elevechurch/layers/data/models/user_model.dart';
import 'package:elevechurch/layers/domain/entities/prayer.dart';
import 'package:elevechurch/layers/domain/entities/user.dart';
import 'package:elevechurch/layers/presentation/blocs/auth/auth_bloc.dart';
import 'package:elevechurch/layers/presentation/blocs/prayer/prayer_bloc.dart';
import 'package:elevechurch/layers/presentation/blocs/prayer/prayer_event.dart';
import 'package:elevechurch/layers/presentation/blocs/prayer/prayer_state.dart';
import 'package:elevechurch/layers/presentation/screens/prayers/create_prayer_page.dart';
import 'package:elevechurch/layers/presentation/widgets/cards/card_home.dart';
import 'package:elevechurch/layers/presentation/widgets/cards/card_prayer.dart';
import 'package:elevechurch/layers/presentation/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrayersPage extends StatefulWidget {
  const PrayersPage({super.key});

  @override
  State<PrayersPage> createState() => _PrayersPageState();
}

class _PrayersPageState extends State<PrayersPage> {
  late final User? user;
  List<Prayer> prayers = [];
  bool isLoading = true;
  int? cardLoading;

  @override
  void initState() {
    user = context.read<AuthBloc>().state.user;
    loadPrayers();
    super.initState();
  }

  @override
  void didUpdateWidget(PrayersPage oldWidget) {
    print('Entrou');

    super.didUpdateWidget(oldWidget);
  }

  loadPrayers() {
    context.read<PrayerBloc>().add(LoadPrayersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const Header(),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid.count(
              crossAxisCount: 2,
              childAspectRatio: 1.6,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: prayersCategories
                  .map((e) => CardHome(
                        category: e,
                        onPress: () async {
                          loadPrayers();
                        },
                      ))
                  .toList(),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 8,
              ),
              child: const Text('Orações adicionadas recentemente'),
            ),
          ),
          BlocListener<PrayerBloc, PrayerState>(
            listener: (context, state) {
              if (state is PrayerLoadingState) {
                setState(() {
                  isLoading = true;
                });
              } else if (state is PrayersLoadedState) {
                setState(() {
                  prayers = state.prayers;
                  cardLoading = null;
                  isLoading = false;
                });
              } else if (state is PrayerCardLoadingState) {
                setState(() {
                  cardLoading = state.id;
                });
              } else if (state is PrayerFoundState) {
                setState(() {
                  cardLoading = null;
                  prayers = state.prayers ?? prayers;
                });
              }
            },
            child: SliverPadding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
              ),
              sliver: isLoading
                  ? SliverList.separated(
                      itemCount: 3,
                      itemBuilder: (context, index) =>
                          const CardPrayerSkeleton(),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 16,
                      ),
                    )
                  : SliverList.separated(
                      itemCount: prayers.length,
                      itemBuilder: (context, index) {
                        var isPraying = prayers[index]
                                .praying
                                ?.firstWhere(
                                  (e) => e.id == user?.id,
                                  orElse: () =>
                                      UserModel(id: 0, name: '', email: ''),
                                )
                                .id ==
                            user?.id;
                        return CardPrayer(
                          prayer: prayers[index],
                          isPraying: isPraying,
                          isLoading: cardLoading == prayers[index].id,
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 16,
                      ),
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var response = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreatePrayerPage(),
            ),
          );

          if (response != null) {
            await loadPrayers();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
