import 'package:flutter/material.dart';

class MyHomeHeader extends StatelessWidget {
  final String headerLabel;
  final bool? showIcon;

  const MyHomeHeader({
    super.key,
    required this.headerLabel,
    this.showIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            headerLabel,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Colors.black,
                ),
          ),
          if (showIcon!)
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.widgets_rounded,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
            ),
        ],
      ),
    );
  }
}
