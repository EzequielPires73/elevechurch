import 'package:elevechurch/core/helpers/date.dart';
import 'package:elevechurch/layers/data/models/user_model.dart';
import 'package:elevechurch/layers/data/repositories/prayer_repository_imp.dart';
import 'package:elevechurch/layers/domain/entities/prayer.dart';
import 'package:elevechurch/layers/domain/entities/user.dart';
import 'package:elevechurch/layers/presentation/blocs/auth/auth_bloc.dart';
import 'package:elevechurch/layers/presentation/blocs/prayer/prayer_bloc.dart';
import 'package:elevechurch/layers/presentation/blocs/prayer/prayer_event.dart';
import 'package:elevechurch/layers/presentation/screens/prayers/view_prayer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardPrayer extends StatefulWidget {
  final Prayer prayer;
  final bool isPraying;
  final Function()? onPraying;

  const CardPrayer({
    super.key,
    required this.prayer,
    required this.isPraying,
    this.onPraying,
  });

  @override
  State<CardPrayer> createState() => _CardPrayerState();
}

class _CardPrayerState extends State<CardPrayer> {
  late final User? user;
  bool isPraying = false;

  @override
  void initState() {
    user = context.read<AuthBloc>().state.user;
    isPraying = widget.prayer.praying
            ?.firstWhere(
              (e) => e.id == user?.id,
              orElse: () => UserModel(id: 0, name: '', email: ''),
            )
            .id ==
        user?.id;
    super.initState();
  }

  Future<void> changePraying() async {
    context.read<PrayerBloc>().add(ChangePrayingEvent(id: widget.prayer.id!));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Card.filled(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewPrayerPage(
                prayer: widget.prayer,
              ),
            )),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.indigo.shade100,
                ),
                child: Text(
                  reasonOptions
                      .firstWhere((e) => e.enumValue == widget.prayer.reason)
                      .name,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.indigo.shade700,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              widget.prayer.user != null
                  ? Text(
                      widget.prayer.user?.name ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : Container(),
              widget.prayer.user?.congregation?.name != null
                  ? Text(
                      widget.prayer.user?.congregation?.name ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : Container(),
              Text(
                widget.prayer.description,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.prayer.createdAt != null
                        ? formatFullDate(widget.prayer.createdAt!)
                        : '',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.amber.shade600 : Colors.black87,
                    ),
                  ),
                  isPraying
                      ? FilledButton.icon(
                          onPressed: changePraying,
                          icon: const Icon(Icons.favorite),
                          label: const Text(
                            'Orando',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : OutlinedButton(
                          onPressed: changePraying,
                          child: const Row(
                            children: [
                              Icon(
                                Icons.favorite_border_outlined,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Orar',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* class CardPrayer extends StatelessWidget {
  final Prayer prayer;
  final bool isPraying;
  final User? user;
  final Function()? onPraying;

  const CardPrayer({
    super.key,
    required this.prayer,
    required this.isPraying,
    this.onPraying,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    
    

    
  }
}
 */