import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        const Expanded(
          flex: 1,
          child:Icon(Icons.social_distance),
        ),
        Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.add_box_outlined),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.send),
                )
              ],
            ))
      ]),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
