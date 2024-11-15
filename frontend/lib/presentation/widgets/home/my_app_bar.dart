
import 'package:flutter/material.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';

class MyAppBar extends StatelessWidget {
  final String label;

  const MyAppBar({
    super.key, required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                label,
                style: textTheme.titleMedium!.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
