import 'package:flutter/material.dart';

class CardProgramming extends StatelessWidget {
  const CardProgramming({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 320,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Culto de celebração',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Icon(Icons.calendar_month),
                  SizedBox(
                    width: 8,
                  ),
                  Text('28/08/2024 às 19:30')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
