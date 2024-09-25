import 'package:elevechurch/core/utils/contants.dart';
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
  @override
  void initState() {
    loadPrayers();
    super.initState();
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
              children:
                  prayersCategories.map((e) => CardHome(category: e)).toList(),
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
          BlocBuilder<PrayerBloc, PrayerState>(
            builder: (context, state) {
              if (state is PrayersLoadedState) {
                return SliverPadding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 16,
                  ),
                  sliver: SliverList.separated(
                    itemCount: state.prayers.length,
                    itemBuilder: (context, index) => CardPrayer(
                      prayer: state.prayers[index],
                      isPraying: false,
                      onPraying: () {},
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 16,
                    ),
                  ),
                );
              } else if (state is PrayerLoadingState) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return const SliverToBoxAdapter();
              }
            },
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
