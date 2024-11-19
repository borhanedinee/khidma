
import 'package:flutter/material.dart';
import 'package:khidma/constants.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';

class ProfileBar extends StatelessWidget {
  const ProfileBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.only(left: 5),
      height: 80,
      width: size.width,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(10),
      //   color: Colors.grey.shade100,
      // ),
      child: Row(
        children: [
          // avatar
          SizedBox(
            width: (size.width - 30 * 2) * .15,
            height: 50,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                '$IMAGE_URL/${prefs.getString('useravatar')}',
              ),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: (size.width - 30 * 2) * .54,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  prefs.getString('userfullname') ?? 'user',
                  style: textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  prefs.getString('useremail') ?? 'email',
                  style: textTheme.bodySmall!.copyWith(
                    color: Colors.black54,
                  ),
                  overflow: TextOverflow.ellipsis,
    
                ),
              ],
            ),
          ),
          const Spacer(),
          SizedBox(
              width: (size.width - 30 * 2) * .2,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit_note_rounded))),
        ],
      ),
    );
  }
}
