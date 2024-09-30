import 'package:elevechurch/layers/domain/entities/program.dart';
import 'package:elevechurch/layers/presentation/screens/programings/programing_view_page.dart';
import 'package:flutter/material.dart';

// Instancia um objeto Program
Program cultoDaVitoria = Program(
  id: 101,
  title: 'Culto da Vitória',
  description: 'Um culto especial para celebrar a vitória em Cristo.',
  image:
      'https://storage.googleapis.com/storage/v1/b/agenda-pastoral-2906d.appspot.com/o/maxresdefault-142d.webp?generation=1716823651416357&alt=media',
  pushNotification: true,
  live: true,
  active: true,
  recurrent: true,
  date: '2024-10-05', // Data única ou a próxima data
  church: null,
  monday: null, // Não ocorre na segunda-feira
  tuesday: null, // Não ocorre na terça-feira
  wednesday: null, // Não ocorre na quarta-feira
  thursday: '16:30', // Ocorre às 16:30 na quinta-feira
  friday: null, // Não ocorre na sexta-feira
  saturday: null, // Não ocorre no sábado
  sunday: null, // Não ocorre no domingo
  createdAt: '2024-09-30',
  updatedAt: '2024-09-30',
);

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
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProgramingViewPage(
                program: cultoDaVitoria,
              ),
            )),
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
