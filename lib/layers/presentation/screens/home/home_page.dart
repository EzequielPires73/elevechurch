import 'package:elevechurch/core/utils/contants.dart';
import 'package:elevechurch/layers/presentation/widgets/cards/card_home.dart';
import 'package:elevechurch/layers/presentation/widgets/cards/card_programing.dart';
import 'package:elevechurch/layers/presentation/widgets/header.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const Header(),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid.count(
              crossAxisCount: 3,
              childAspectRatio: 1.2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: categories.map((e) => CardHome(category: e)).toList(),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Text('Programações'),
            ),
          ),
          SliverToBoxAdapter(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 92),
              child: ListView.separated(
                itemCount: 4,
                separatorBuilder: (context, index) => const SizedBox(
                  width: 16,
                ),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Padding(
                  padding: index == 0
                      ? const EdgeInsets.only(left: 16)
                      : index == 3
                          ? const EdgeInsets.only(right: 16)
                          : EdgeInsets.zero,
                  child: const CardProgramming(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
