import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_miarmapp/bloc/movies_bloc/post_bloc.dart';
import 'package:flutter_application_miarmapp/models/post/post_response.dart';
import 'package:flutter_application_miarmapp/repository/constants.dart';
import 'package:flutter_application_miarmapp/repository/post_repository/post_repository.dart';
import 'package:flutter_application_miarmapp/repository/post_repository/post_respository_impl.dart';
import 'package:flutter_application_miarmapp/ui/widgets/error_page.dart';
import 'package:flutter_application_miarmapp/ui/widgets/heart_animation_widget.dart';
import 'package:flutter_application_miarmapp/ui/widgets/home_appbar.dart';
import 'package:flutter_application_miarmapp/ui/widgets/post_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:insta_like_button/insta_like_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLiked = false;
  bool isHeartAnimating = false;
  late PostRepository publicacionRepository;

  @override
  void initState() {
    // TODO: implement initState
    publicacionRepository = PostRepositoryImpl();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return PostBloc(publicacionRepository)
          ..add(FetchPostWithType(Constant.nowPlaying));
      },
      child: Scaffold(
        appBar: const HomeAppBar(),
        body: _createPublics(context),
      ),
    );
  }

  Widget postMejorado(BuildContext context, PostResponse data) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            GestureDetector(
              child: Stack(alignment: Alignment.center, children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                      data.file.replaceFirst('localhost', '10.0.2.2')),
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
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 300),
                  child: Row(
                    children: [
                      HeartAnimationWidget(
                          alwaysAnimate: true,
                          child: IconButton(
                              onPressed: () =>
                                  setState(() => isLiked = !isLiked),
                              icon: Icon(
                                isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                color: isLiked ? Colors.red : Colors.grey,
                                size: 28,
                              )),
                          isAnimating: isLiked)
                    ],
                  ),
                )
              ]),
              onDoubleTap: () {
                setState(() {
                  isHeartAnimating = true;
                  isLiked = true;
                });
              },
            ),
          ],
        ));
  }

  Widget _createPublics(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PostFetchError) {
          return ErrorPage(
            message: state.message,
            retry: () {
              context
                  .watch<PostBloc>()
                  .add(FetchPostWithType(Constant.nowPlaying));
            },
          );
        } else if (state is PostFetched) {
          return _createPopularView(context, state.public);
        } else {
          return const Text('Not support');
        }
      },
    );
  }

  Widget _createPopularView(BuildContext context, List<PostResponse> post) {
    final contentHeight = 4.0 * (MediaQuery.of(context).size.width / 2.4) / 3;
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return _post(context, post[index]);
        },
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        scrollDirection: Axis.vertical,
        separatorBuilder: (context, index) => const VerticalDivider(
          color: Colors.transparent,
          width: 6.0,
        ),
        itemCount: post.length,
      ),
    );
  }

/*Widget _createPopularViewItem(BuildContext context, PublicacionData movie) {
    final width = MediaQuery.of(context).size.width / 2.6;
    return Container(
      width: width,
      height: double.infinity,
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Card(
        elevation: 10.0,
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: SizedBox(
          width: width,
          height: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              imageUrl: movie.file.toString().replaceFirst('localhost', '10.0.2.2'),
              width: width,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }*/

  Widget _post(BuildContext context, PostResponse data) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.withOpacity(.3)))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: CachedNetworkImage(
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    imageUrl:
                        data.user.avatar.replaceAll("localhost", "10.0.2.2"),
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    data.user.nombre + ' ' + data.user.apellidos,
                    style: TextStyle(
                        color: Colors.black.withOpacity(.8),
                        fontWeight: FontWeight.w400,
                        fontSize: 21),
                  ),
                ),
              ],
            ),
          ),
          InstaLikeButton(
            image: NetworkImage(
                data.file.toString().replaceFirst('localhost', '10.0.2.2')),
            onChanged: () {},
            icon: Icons.favorite,
            iconSize: 80,
            iconColor: Colors.red,
            curve: Curves.fastLinearToSlowEaseIn,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: const <Widget>[
                    Icon(
                      Icons.favorite_border,
                      size: 31,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Icon(Icons.comment_sharp, size: 31),
                    SizedBox(
                      width: 12,
                    ),
                    Icon(Icons.send, size: 31),
                  ],
                ),
                const Icon(Icons.bookmark_border, size: 31)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            child: Text(
              'liked by you and 299 others',
              style:
                  TextStyle(fontSize: 16, color: Colors.black.withOpacity(.8)),
            ),
          )
        ],
      ),
    );
  }
}
