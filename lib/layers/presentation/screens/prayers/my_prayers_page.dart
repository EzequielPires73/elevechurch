import 'package:elevechurch/layers/data/models/user_model.dart';
import 'package:elevechurch/layers/domain/entities/prayer.dart';
import 'package:elevechurch/layers/domain/entities/user.dart';
import 'package:elevechurch/layers/presentation/blocs/auth/auth_bloc.dart';
import 'package:elevechurch/layers/presentation/blocs/prayer/prayer_bloc.dart';
import 'package:elevechurch/layers/presentation/blocs/prayer/prayer_event.dart';
import 'package:elevechurch/layers/presentation/blocs/prayer/prayer_state.dart';
import 'package:elevechurch/layers/presentation/widgets/cards/card_prayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyPrayersPage extends StatefulWidget {
  const MyPrayersPage({super.key});

  @override
  State<MyPrayersPage> createState() => _MyPrayersPageState();
}

class _MyPrayersPageState extends State<MyPrayersPage> {
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

  loadPrayers() {
    context.read<PrayerBloc>().add(LoadMyPrayersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Minha lista de orações',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocListener<PrayerBloc, PrayerState>(
        listener: (context, state) {
          if (state is PrayerLoadingState) {
            setState(() {
              isLoading = true;
            });
          } else if (state is MyPrayersLoadedState) {
            setState(() {
              prayers = state.prayers;
              cardLoading = null;
              isLoading = false;
            });
          } else if (state is PrayerCardLoadingState) {
            setState(() {
              cardLoading = state.id;
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
          ),
          child: isLoading
              ? ListView.separated(
                  itemCount: 3,
                  itemBuilder: (context, index) => const CardPrayerSkeleton(),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 16,
                  ),
                )
              : ListView.separated(
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
                      listMyPrayers: true,
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 16,
                  ),
                ),
        ),
      ),
    );
  }
}
