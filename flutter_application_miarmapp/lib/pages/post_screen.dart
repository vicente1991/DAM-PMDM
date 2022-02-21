import 'package:flutter/material.dart';
import 'package:flutter_application_miarmapp/widgets/heart_animation_widget.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  bool isLiked = false;
  bool isHeartAnimating= false;


  @override
  Widget build(BuildContext context) => buildImage();

  Widget buildImage() => GestureDetector(
    child: Stack(
          alignment: Alignment.center,
          children: [
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
                duration: Duration(milliseconds: 700),
               child: Icon(Icons.favorite,color: Colors.white,size: 100,),
               onEnd: ()=> setState(() =>
                isHeartAnimating= false,
               )
              ),
            ),
          ],
        ),
        onDoubleTap: (){
          setState(() {
            isHeartAnimating= true;
            isLiked= true;
          });
        },
  );


  Widget buildActions(){
    final icon = isLiked ? Icons.favorite : Icons.favorite_outline;
    final color= isLiked? Colors.red : Colors.white;

    return Container(
      padding: EdgeInsets.all(4),
      child: Row(children: [
        HeartAnimationWidget(
          alwaysAnimate: true,
          child: IconButton(
          onPressed:()=> setState(()=> isLiked = !isLiked),
          icon: Icon(icon,color: color,size: 28,)), 
          isAnimating: isLiked)      
      ],)
    );
  }

}



