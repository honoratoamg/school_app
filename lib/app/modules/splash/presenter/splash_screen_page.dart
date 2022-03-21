import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'controllers/splash_screen_controller.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState
    extends ModularState<SplashScreenPage, SplashScreenController>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    controller.run();
    controller.initAnimationController(this);
  }

  @override
  void dispose() {
    controller.disposeAnimationController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.9),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                  scale: controller.splashIconAnimationController,
                  child: Icon(
                    Icons.school,
                    size: MediaQuery.of(context).size.width * 0.5,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                const Center(
                  child: Text(
                    'Bem vindo(a) ao School App!',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                const Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                      backgroundColor: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
