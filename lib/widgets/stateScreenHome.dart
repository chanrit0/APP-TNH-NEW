import 'package:flutter/material.dart';

class StateScreenHome extends StatelessWidget {
  final Widget? child;
  const StateScreenHome({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/backgroundHome@3x.png'),
                    fit: BoxFit.cover),
              ),
              child: SafeArea(
                  left: false,
                  right: false,
                  child: Container(
                    child: child,
                  ))),
        ),
      ],
    );
  }
}
