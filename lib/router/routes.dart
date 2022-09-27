import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../pages/detailspage.dart';
import '../pages/formpage.dart';
import '../pages/homepage/index.dart';

class RouteManager {
  static const String homePage = '/';
  static const String formPage = '/form';
  static const String detailsPage = '/details';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    late Map<String, dynamic> valuePassed;

    if (settings.arguments != null) {
      valuePassed = settings.arguments as Map<String, dynamic>;
    }

    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case formPage:
        return PageTransition(
            type: PageTransitionType.bottomToTop, child: FormPage());
      case detailsPage:
        return MaterialPageRoute(
            builder: (_) => DetailsPage(
                  pill: valuePassed['pill'],
                  index: valuePassed['index'],
                ));

      //     // default:
      //     //   return MaterialPageRoute(builder: (_) => LoginScreen());

      default:
        throw FormatException(settings.name!.toString());
    }
  }
}
