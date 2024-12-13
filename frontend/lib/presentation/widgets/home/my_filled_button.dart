
import 'package:flutter/material.dart';
import 'package:khidma/main.dart';

class MyFilledButton extends StatelessWidget {
  final void Function() onPressed;
  
  final String label;

  final Color? backgroundColor;

  const MyFilledButton({
    super.key, required this.label, required this.onPressed, this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation: const MaterialStatePropertyAll(0),
          backgroundColor: MaterialStatePropertyAll(
            backgroundColor ?? Theme.of(context).primaryColor,
          ),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.yellow,
          ),
        ),
      ),
    );
  }
}
