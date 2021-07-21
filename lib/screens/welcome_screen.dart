import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static final String id = 'welcome';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  final double upperBound = 90.0;
  AnimationController animController;
  Animation animation;
  Animation colorAnimation;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
      duration: Duration(milliseconds: 1000),
      lowerBound: 0.0,
      upperBound: 1.0,
      vsync: this,
    );

    animation =
        CurvedAnimation(parent: animController, curve: Curves.easeOutCubic);

    colorAnimation = ColorTween(begin: Colors.transparent, end: Colors.white)
        .animate(animController);

    animation.addStatusListener((status) {
      print('animation status: $status');
      /*
      if (status == AnimationStatus.completed) {
        animController.reverse();
        return;
      }
      if (status == AnimationStatus.dismissed) {
        animController.forward();
        return;
      }
      */
    });
    animController.forward();
    animController.addListener(() {
      setState(() {});
    });
  }

  double animValueDouble({int division = 1}) {
    return ((animation.value * upperBound) / division).floorToDouble();
  }

  int animValueInt({int division = 1}) {
    return ((animation.value * upperBound) ~/ division);
  }

  var sb = StringBuffer();
  String getAnimatedTitle() {
    sb.clear();
    for (var i = 0; i < 7; i++) {
      sb.writeCharCode(animValueInt() + i);
    }
    return sb.toString();
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorAnimation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: animValueDouble(),
                  ),
                ),
                Text(
                  animValueInt() == upperBound
                      ? 'Flash Chat'
                      : getAnimatedTitle(),
                  style: TextStyle(
                    fontSize: animValueDouble(division: 2),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 22.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent.withOpacity(animation.value),
                borderRadius: BorderRadius.circular(22),
                child: MaterialButton(
                  onPressed: () {
                    //Go to login screen.
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Log In',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent.withOpacity(animation.value),
                borderRadius: BorderRadius.circular(22),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    //Go to registration screen.
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Register',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
