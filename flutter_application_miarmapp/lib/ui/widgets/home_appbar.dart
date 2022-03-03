import 'package:flutter/material.dart';
import 'package:flutter_application_miarmapp/ui/pages/create_post.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        const Expanded(
          flex: 1,
          child: Icon(Icons.social_distance),
        ),
        Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PostScreen()));
                    },
                    icon: Icon(Icons.add_box_outlined),
                  ),
                ),
                const Padding(
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
