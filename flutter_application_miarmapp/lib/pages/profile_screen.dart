import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Miguel Campos",
          style: TextStyle(
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
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/avatar.jpeg')),
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: const [
                                TextButton(
                                  onPressed: null,
                                  child: Text(
                                    "3",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                                Text("posts"),
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
                                    "1.174",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                                Text(
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
                                      /*Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const FollowPage()));*/
                                    },
                                    child: const Text("832",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black))),
                                Text("following"),
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
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text("Miguel Campos"),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text("Profesor guason", style: TextStyle(color: Colors.grey),),
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
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.table_chart_outlined)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.person_search)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        width: 90,
                        height: 150,
                        child: const Image(
                          image: AssetImage("assets/images/avatar.jpeg"),
                          fit: BoxFit.contain,
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                        width: 100,
                        height: 150,
                        child: const Image(
                          image: AssetImage("assets/images/avatar.jpeg"),
                          fit: BoxFit.contain,
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                        width: 120,
                        height: 150,
                        child: const Image(
                          image: AssetImage("assets/images/avatar.jpeg"),
                          fit: BoxFit.contain,
                        ))
                  ],
                )
              ],
            )
          ],
        ),
      ),
      
    );
  }
}