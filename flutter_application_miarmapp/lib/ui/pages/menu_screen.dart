import 'package:flutter/material.dart';
import 'package:flutter_application_miarmapp/bloc/user_bloc/user_bloc.dart';
import 'package:flutter_application_miarmapp/models/user/user_response.dart';
import 'package:flutter_application_miarmapp/repository/constants.dart';
import 'package:flutter_application_miarmapp/repository/user_repository/user_repository.dart';
import 'package:flutter_application_miarmapp/repository/user_repository/user_repository_impl.dart';
import 'package:flutter_application_miarmapp/ui/pages/home_screen.dart';
import 'package:flutter_application_miarmapp/ui/pages/profile_screen.dart';
import 'package:flutter_application_miarmapp/ui/pages/search_screen.dart';
import 'package:flutter_application_miarmapp/ui/widgets/error_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
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

  int _currentIndex = 0;

  List<Widget> pages = [
    const HomeScreen(),
    const SearchScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return UserWithPostBloc(userRepository)
          ..add(FetchUserWithType(Constant.nowPlaying));
      },
      child: Scaffold(
          body: pages[_currentIndex],
          bottomNavigationBar: _createPublics(context)),
    );
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
          return _buildBottomBar(context, state.users);
        } else {
          return const Text('Not support');
        }
      },
    );
  }

  Widget _buildBottomBar(BuildContext context, UserData user) {
    return Container(
        decoration: const BoxDecoration(
            border: Border(
          top: BorderSide(
            color: Color(0xfff1f1f1),
            width: 1.0,
          ),
        )),
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: Icon(Icons.home,
                  color: _currentIndex == 0
                      ? Colors.black
                      : const Color(0xff999999)),
              onTap: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            GestureDetector(
              child: Icon(Icons.search,
                  color: _currentIndex == 1
                      ? Colors.black
                      : const Color(0xff999999)),
              onTap: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: _currentIndex == 2
                              ? Colors.black
                              : Colors.transparent,
                          width: 1),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(user.avatar
                              .toString()
                              .replaceFirst('localhost', '10.0.2.2')))),
                ))
          ],
        ));
  }
}
