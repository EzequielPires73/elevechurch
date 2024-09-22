import 'package:elevechurch/layers/domain/entities/category_home.dart';
import 'package:elevechurch/layers/presentation/screens/church/church_page.dart';
import 'package:elevechurch/layers/presentation/screens/congregations/congregations_page.dart';
import 'package:elevechurch/layers/presentation/screens/donations/donations_page.dart';
import 'package:elevechurch/layers/presentation/screens/ebd/ebd_page.dart';
import 'package:elevechurch/layers/presentation/screens/events/events_page.dart';
import 'package:elevechurch/layers/presentation/screens/lives/lives_page.dart';
import 'package:elevechurch/layers/presentation/screens/ministries/ministries_page.dart';
import 'package:elevechurch/layers/presentation/screens/pastoral_agenda/pastoral_agenda_page.dart';
import 'package:elevechurch/layers/presentation/screens/publications/publications_page.dart';
import 'package:flutter/material.dart';

List<CategoryHome> categories = [
  const CategoryHome(
    title: 'Igreja',
    icon: Icons.church_outlined,
    screen: ChurchPage(),
  ),
  const CategoryHome(
    title: 'Ministérios',
    icon: Icons.local_fire_department_outlined,
    screen: MinistriesPage(),
  ),
  const CategoryHome(
    title: 'Publicações',
    icon: Icons.newspaper_outlined,
    screen: PublicationsPage(),
  ),
  const CategoryHome(
    title: 'Ag. Pastoral',
    icon: Icons.calendar_month_outlined,
    screen: PastoralAgendaPage(),
  ),
  const CategoryHome(
    title: 'Doação',
    icon: Icons.volunteer_activism_outlined,
    screen: DonationsPage(),
  ),
  const CategoryHome(
    title: 'Ao vivo',
    icon: Icons.videocam_outlined,
    screen: LivesPage(),
  ),
  const CategoryHome(
    title: 'Congregações',
    icon: Icons.place_outlined,
    screen: CongregationsPage(),
  ),
  const CategoryHome(
    title: 'Eventos',
    icon: Icons.calendar_month_outlined,
    screen: EventsPage(),
  ),
  const CategoryHome(
    title: 'EBD',
    icon: Icons.menu_book_outlined,
    screen: EbdPage(),
  ),
];
