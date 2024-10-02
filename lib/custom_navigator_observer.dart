import 'package:flutter/material.dart';

class CustomNavigatorObserver extends NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    // Verifica se voltou para a página desejada
    print(previousRoute?.settings.name);
    if (previousRoute?.settings.name == 'your_route_name') {
      print('Voltou para a página anterior');
    }
  }
}
