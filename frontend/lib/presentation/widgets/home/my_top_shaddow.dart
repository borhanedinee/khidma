
import 'package:flutter/material.dart';
import 'package:khidma/main.dart';

class MyTopShaddow extends StatelessWidget {
  const MyTopShaddow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: 100,
      decoration: const BoxDecoration(
        borderRadius: BorderRadiusDirectional.vertical(
          top: Radius.circular(30),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black38,
            Colors.black12,
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}
