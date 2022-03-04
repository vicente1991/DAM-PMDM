import 'package:flutter/material.dart';
import 'package:flutter_application_miarmapp/ui/widgets/heart_animation_widget.dart';

class PostWidget extends StatefulWidget {
  // final PostResponse post;
  // const PostWidget({Key? key, required this.post}) : super(key: key);

  const PostWidget({Key? key}) : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool isLiked = false;
  bool isHeartAnimating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: aaa()
    );
  }

Widget aaa(){
  return Column(
        children: [
          GestureDetector(
            child: Stack(alignment: Alignment.center, children: [
              AspectRatio(
                aspectRatio: 1,
                child: Image.asset(
                  'assets/images/avatar.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
              Opacity(
                opacity: isHeartAnimating ? 1 : 0,
                child: HeartAnimationWidget(
                    isAnimating: isHeartAnimating,
                    duration: const Duration(milliseconds: 700),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 100,
                    ),
                    onEnd: () {
                      setState(() {
                        isHeartAnimating = false;
                      });
                    }),
              )
            ]),
            onDoubleTap: () {
              setState(() {
                isHeartAnimating = true;
                isLiked = true;
              });
            },
          ),
          Row(
            children: [
              HeartAnimationWidget(
                  alwaysAnimate: true,
                  child: IconButton(
                      onPressed: () => setState(() => isLiked = !isLiked),
                      icon: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_outline,
                        color: isLiked ? Colors.red : Colors.grey,
                        size: 28,
                      )),
                  isAnimating: isLiked)
            ],
          )
        ],
      );
}

}
