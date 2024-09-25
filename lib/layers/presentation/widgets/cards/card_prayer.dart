import 'package:elevechurch/core/helpers/date.dart';
import 'package:elevechurch/layers/data/repositories/prayer_repository_imp.dart';
import 'package:elevechurch/layers/domain/entities/prayer.dart';
import 'package:elevechurch/layers/presentation/screens/prayers/view_prayer_page.dart';
import 'package:flutter/material.dart';

class CardPrayer extends StatelessWidget {
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
                prayer: prayer,
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
                      .firstWhere((e) => e.enumValue == prayer.reason)
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
              prayer.user != null
                  ? Text(
                      prayer.user?.name ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : Container(),
              prayer.user?.congregation?.name != null
                  ? Text(
                      prayer.user?.congregation?.name ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : Container(),
              Text(
                prayer.description,
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
                    prayer.createdAt != null
                        ? formatFullDate(prayer.createdAt!)
                        : '',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.amber.shade600 : Colors.black87,
                    ),
                  ),
                  isPraying
                      ? FilledButton.icon(
                          onPressed: () {},
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
                          onPressed: () {},
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
