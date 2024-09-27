import 'package:finallysocialapp/utils/Routes/routes_name.dart';
import 'package:finallysocialapp/view/LoginView/login_view.dart';
import 'package:finallysocialapp/view/SignupView/signup_view.dart';
import 'package:finallysocialapp/view/SplashView/splash_view.dart';
import 'package:finallysocialapp/view/dasboard/dashboard_screen.dart';
import 'package:finallysocialapp/view/forgot_password/forgot_view.dart';
import 'package:flutter/material.dart';


class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
        case RouteName.loginView:
        return MaterialPageRoute(builder: (_) => const LoginView());
        case RouteName.signupView:
        return MaterialPageRoute(builder: (_) => const SignUpView());
        case RouteName.dashboardview:
        return MaterialPageRoute(builder: (_) => const DashBoardView());
        case RouteName.forgotview:
        return MaterialPageRoute(builder: (_) => const ForgotView());

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
