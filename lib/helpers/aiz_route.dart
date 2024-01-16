import 'package:active_ecommerce_seller_app/middlewares/middleware.dart';
import 'package:active_ecommerce_seller_app/screens/otp.dart';
import 'package:flutter/material.dart';

class AIZRoute {
  static Future<T?> push<T extends Object?>(BuildContext context, Widget route,
      {Middleware<Widget, Widget>? middleware}) {
    Widget goto = route;
    if (middleware != null) {
      goto = middleware.next(route);
    }

    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => goto));
  }

  static Future<T?> pushAndRemoveAll<T extends Object?>(
      BuildContext context, Widget route,
      {Middleware<Widget, Widget>? middleware}) {
    Widget goto = route;
    if (middleware != null) {
      goto = middleware.next(route);
    }

    return Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => goto), (route) => false);
  }

  static Future<T?> slideLeft<T extends Object?>(
      BuildContext context, Widget route,
      {Middleware<Widget, Widget>? middleware}) {
    Widget goto = route;
    if (middleware != null) {
      goto = middleware.next(route);
    }

    return Navigator.push(context, _leftTransition<T>(goto));
  }

  static Future<T?> slideRight<T extends Object?>(
      BuildContext context, Widget route,
      {Middleware<Widget, Widget>? middleware}) {
    Widget goto = route;
    if (middleware != null) {
      goto = middleware.next(route);
    }
    return Navigator.push(context, _rightTransition<T>(goto));
  }

  static Route<T> _leftTransition<T extends Object?>(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static Route<T> _rightTransition<T extends Object?>(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
/*
  static bool _isMailVerifiedRoute(Widget widget) {
    print(widget.runtimeType);
    bool mailVerifiedRoute = false;
    mailVerifiedRoute = <Type>[SelectAddress, Address, Profile]
        .any((element) => widget.runtimeType == element);
    if (is_logged_in.$ &&
        mailVerifiedRoute &&
        SystemConfig.systemUser != null) {
      return !(SystemConfig.systemUser!.emailVerified ?? true);
    }
    return false;
  }*/
}
