import 'package:elevechurch/layers/domain/entities/category_home.dart';
import 'package:flutter/material.dart';

class CardHome extends StatelessWidget {
  final CategoryHome category;
  final Function()? onPress;
  const CardHome({
    super.key,
    required this.category,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => category.screen,
              ));
          onPress != null ? onPress!() : null;
        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(category.icon),
              const SizedBox(
                height: 8,
              ),
              Text(
                category.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
