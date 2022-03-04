import 'package:flutter/material.dart';
import 'package:flutter_application_miarmapp/bloc/user_bloc/user_bloc.dart';
import 'package:flutter_application_miarmapp/models/user/user_response.dart';
import 'package:flutter_application_miarmapp/repository/constants.dart';
import 'package:flutter_application_miarmapp/repository/user_repository/user_repository.dart';
import 'package:flutter_application_miarmapp/repository/user_repository/user_repository_impl.dart';
import 'package:flutter_application_miarmapp/ui/widgets/error_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserPostRepository userRepository;

  @override
  void initState() {
    // TODO: implement initState
    userRepository = UserPostRepositoryImpl();
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
          return UserWithPostBloc(userRepository)
            ..add(FetchUserWithType(Constant.nowPlaying));
        },
        child: _createPublics(context));
  }
}

Widget _createPublics(BuildContext context) {
  return BlocBuilder<UserWithPostBloc, UserState>(
    builder: (context, state) {
      if (state is UserInitial) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is UserFetchedError) {
        return ErrorPage(
          message: state.message,
          retry: () {
            context
                .watch<UserWithPostBloc>()
                .add(FetchUserWithType(Constant.nowPlaying));
          },
        );
      } else if (state is UsersFetched) {
        return _profile(context, state.users);
      } else {
        return const Text('Not support');
      }
    },
  );
}

Widget _profile(BuildContext context, UserData user) {
  return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          user.nombre + " " + user.apellidos,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
        actions: const [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.menu,
                  size: 30,
                  color: Colors.black,
                ),
              ))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(user.avatar
                                .toString()
                                .replaceFirst('localhost', '10.0.2.2'))),
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                TextButton(
                                  onPressed: null,
                                  child: Text(
                                    user.publicaciones.length.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                                const Text("posts"),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    /*Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const FollowPage()));*/
                                  },
                                  child: Text(
                                    user.followers.length.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                                const Text(
                                  "followers",
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      
                                    },
                                    child: const Text("832",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black))),
                                const Text("following"),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(user.nick.toString()),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        user.nombre + " " + user.apellidos,
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  ],
                ),
                Container(
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    width: 320,
                    child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Edit Profile",
                          style: TextStyle(color: Colors.black),
                        )))

              ],
            ),
            const Divider(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.table_chart_outlined)),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.person_search)),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Flexible(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: user.publicaciones.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        color: Colors.white,
                        child: Image(
                          image: NetworkImage(user.publicaciones
                              .elementAt(index)
                              .file
                              .toString()
                              .replaceFirst('localhost', '10.0.2.2')),
                          fit: BoxFit.cover,
                        ));
                  }),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ));
}
