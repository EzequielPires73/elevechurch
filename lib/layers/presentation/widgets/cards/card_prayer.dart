import 'package:elevechurch/core/helpers/date.dart';
import 'package:elevechurch/core/utils/custom_colors.dart';
import 'package:elevechurch/layers/data/repositories/prayer_repository_imp.dart';
import 'package:elevechurch/layers/domain/entities/prayer.dart';
import 'package:elevechurch/layers/presentation/blocs/prayer/prayer_bloc.dart';
import 'package:elevechurch/layers/presentation/blocs/prayer/prayer_event.dart';
import 'package:elevechurch/layers/presentation/screens/prayers/view_prayer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class CardPrayer extends StatefulWidget {
  final Prayer prayer;
  final bool isPraying;
  final bool isLoading;
  final bool? listPraying;
  final bool? listMyPrayers;

  const CardPrayer({
    super.key,
    required this.prayer,
    required this.isPraying,
    this.isLoading = false,
    this.listPraying,
    this.listMyPrayers,
  });

  @override
  State<CardPrayer> createState() => _CardPrayerState();
}

class _CardPrayerState extends State<CardPrayer> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('Página voltou a ser visível');
  }

  Future<void> changePraying() async {
    context.read<PrayerBloc>().add(
          ChangePrayingEvent(
            id: widget.prayer.id!,
            listPraying: widget.listPraying,
            listMyPrayers: widget.listMyPrayers,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Card.filled(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewPrayerPage(
                prayer: widget.prayer,
              ),
            ),
          );
        },
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
                  widget.isPraying
                      ? FilledButton.icon(
                          onPressed: widget.isLoading ? null : changePraying,
                          icon: const Icon(Icons.favorite),
                          label: Text(
                            widget.isLoading ? 'Atualizando...' : 'Orando',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : OutlinedButton(
                          onPressed: widget.isLoading ? null : changePraying,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.favorite_border_outlined,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                widget.isLoading ? 'Atualizando...' : 'Orar',
                                style: const TextStyle(
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

class CardPrayerSkeleton extends StatelessWidget {
  const CardPrayerSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDark ? CustomColors.cardColor : Colors.grey.shade300,
      highlightColor:
          isDark ? CustomColors.scaffoldColor : Colors.grey.shade100,
      child: Card.filled(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 120,
                height: 16,
                color: Colors.grey,
              ),
              const SizedBox(height: 8),
              Container(
                width: 160,
                height: 14,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 14,
                color: Colors.grey,
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: 14,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 80,
                    height: 12,
                    color: Colors.grey,
                  ),
                  Container(
                    width: 80,
                    height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.grey,
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
