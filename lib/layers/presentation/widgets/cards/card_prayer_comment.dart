import 'package:elevechurch/core/helpers/date.dart';
import 'package:elevechurch/layers/domain/entities/prayer.dart';
import 'package:flutter/material.dart';

class CardPrayerComment extends StatelessWidget {
  final PrayerComment comment;
  const CardPrayerComment({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Card.filled(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.black87, width: 2)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: comment.user?.avatar != null
                    ? Image.network(
                        comment.user!.avatar!,
                        fit: BoxFit.cover,
                      )
                    : Center(
                        child: Icon(Icons.person_outline),
                      ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment.user?.name ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    comment.content,
                    style: TextStyle(
                        color: isDark ? Colors.white70 : Colors.black87),
                  ),
                  comment.createdAt != null
                      ? Text(
                          '${formatFullDate(comment.createdAt!)}  ${formatTimeByDate(comment.createdAt!)}',
                          style: TextStyle(
                            color: isDark ? Colors.white70 : Colors.black87,
                            fontSize: 12,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            InkWell(
              onTap: () {},
              child: Icon(Icons.more_vert_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
