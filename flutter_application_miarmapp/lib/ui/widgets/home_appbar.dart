import 'package:flutter/material.dart';
import 'package:flutter_application_miarmapp/ui/pages/chat_screen.dart';
import 'package:flutter_application_miarmapp/ui/pages/create_post.dart';
import 'package:flutter_application_miarmapp/ui/pages/home_screen.dart';
import 'package:flutter_application_miarmapp/ui/pages/menu_screen.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MenuScreen()));
                  },
                  icon: const Icon(
                    Icons.social_distance,
                  ),
                ),
              ),
              const Text("Inicio"),
            ],
          ),
        ),
        Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
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
                        icon: const Icon(
                          Icons.add_box_outlined,
                        ),
                      ),
                    ),
                    Text("Crear post")
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ChatScreen()));
                        },
                        icon: const Icon(
                          Icons.send,
                        ),
                      ),
                    ),
                    Text("Chat")
                  ],
                )
              ],
            ))
      ]),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
