import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safe_city_project/Options%20Screens/Profile.dart';
import 'package:safe_city_project/set_height_and_width.dart';

import '../For Testing Purpose/methods.dart';

void main() {
  runApp(MaterialApp(home: ChatScreen()));
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  bool isLoading = false;
  late Map<String, dynamic> userMap;
  final TextEditingController _search = TextEditingController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  void onSearchh() async {
    setState(() {
      isLoading = true;
    });
    await _firestore
        .collection('users')
        .where('email', isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
      print(userMap);
    });
  }

  void setStatus(String status) async {
    await _firestore.collection('users').doc(_auth.currentUser?.uid).update(
        {
          'status':status
        });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setStatus('Online');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setStatus('Online');
    } else if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
      setStatus('Offline');
    } else {
      setStatus('Offline');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(54, 94, 212, 1.0),
              Color.fromRGBO(78, 88, 155, 1.0),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
        ),
        title: Text('ICT Police TalkHub'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                    child: InkWell(
                      child: Text("Profile"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Profile()));
                      },
                    )),
              ];
            },
          ),
        ],
        elevation: 0, // Remove the elevation from the AppBar
      ),
      body: isLoading
          ? Center(
        child: Container(
          height: getheight(context) / 20,
          width: getwidth(context) / 20,
          child: CircularProgressIndicator(),
        ),
      )
          : Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color.fromRGBO(44, 97, 190, 0.9490196078431372),
        child: const Icon(
          Icons.chat,
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, query);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Container(); // Return an empty container when query is empty
    }

    return FutureBuilder(
      future: searchUsersByEmail(query),
      // Replace with your method to search users by email
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show a loading indicator while fetching results
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final searchResults = snapshot.data ?? [];

        return ListView.builder(
          itemCount: searchResults.length,
          itemBuilder: (BuildContext context, int index) {
            final result = searchResults[index];
            return contact(
              'assets/images/logo.png', // Replace with actual image path
              result['name'], // Assuming 'name' is the user's name
              result['status'], // Replace with the appropriate time
              result['status'], // Replace with the user's status
              result['email'], // Replace with the user's message
              context,
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container(); // Return an empty container when query is empty
    }
    return FutureBuilder(
      future: getSuggestions(query),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show a loading indicator while fetching suggestions
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final suggestions = snapshot.data ?? [];

        return ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (BuildContext context, int index) {
            final suggestion = suggestions[index];
            return FutureBuilder(
              future: getUserData(suggestion),
              // Replace with your method to fetch user data
              builder: (BuildContext context,
                  AsyncSnapshot<Map<String, dynamic>> userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(); // Return an empty widget while fetching user data
                }

                if (userSnapshot.hasError) {
                  return Text('Error: ${userSnapshot.error}');
                }

                final userMap = userSnapshot.data ?? {};
                return contact(
                  'assets/images/logo.png', // Replace with actual image path
                  userMap['name'] ?? suggestion,
                  // Use the display name from user data, or the suggestion itself
                  userMap['status'],
                  // Replace with the appropriate time
                  userMap['status'], // Replace with the user's status
                  userMap['email'], // Replace with the user's message
                  context,
                );
              },
            );
          },
        );
      },
    );
  }

  Future<Map<String, dynamic>> onSearch(String email) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs[0].data() as Map<String, dynamic>;
    }

    return {};
  }

  Future<List<String>> getSuggestions(String query) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .where('email', isGreaterThanOrEqualTo: query)
        .get();

    List<String> suggestions = [];
    for (var doc in snapshot.docs) {
      var email = doc['email'] as String;
      if (email.startsWith(query)) {
        suggestions.add(email);
      }
    }
    return suggestions;
  }

  Future<List<Map<String, dynamic>>> searchUsersByEmail(String query) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .where('email', isGreaterThanOrEqualTo: query)
        .get();

    List<Map<String, dynamic>> searchResults = [];
    for (var doc in snapshot.docs) {
      if (doc['email'].startsWith(query)) {
        var userMap = doc.data() as Map<String, dynamic>;
        searchResults.add(userMap);
      }
    }

    return searchResults;
  }

  Future<Map<String, dynamic>> getUserData(String suggestion) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: suggestion)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs[0].data() as Map<String, dynamic>;
    }

    return {};
  }
}

Widget message(String urlImage, String title, String onOff, context) {
  return Scaffold(
    extendBodyBehindAppBar: true,
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromRGBO(120, 149, 203, 1),
            Color.fromRGBO(74, 85, 162, 1),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
      ),
      titleSpacing: 0.0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_rounded),
      ),
      title: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            child: ClipOval(
              child: Image.asset(
                urlImage,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              const SizedBox(
                height: 2,
              ),
              Text(
                onOff,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
      actions: const [
        Icon(Icons.videocam),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Icon(Icons.call),
        ),
        Icon(Icons.more_vert),
      ],
    ),
    body: const ChatScr(),
  );
}

class ChatMess extends StatelessWidget {
  final String text;
  final AnimationController animationController;

  const ChatMess(
      {Key? key, required this.text, required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor:
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: const Color.fromRGBO(197, 223, 248, 0.8),
            borderRadius: BorderRadius.circular(5.0)),
        margin: const EdgeInsets.symmetric(vertical: 2.0),
        child: Text(text),
      ),
    );
  }
}

class ChatScr extends StatefulWidget {
  const ChatScr({Key? key}) : super(key: key);

  @override
  State<ChatScr> createState() => _ChatScrState();
}

class _ChatScrState extends State<ChatScr> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final List<ChatMess> _messages = [];
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    for (var message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }

  void _handleSubmitted(String text) {
    _textController.clear();

    var message = ChatMess(
      text: text,
      animationController: AnimationController(
        duration: const Duration(milliseconds: 700),
        vsync: this,
      ),
    );
    setState(() {
      _messages.insert(0, message);
    });
    _focusNode.requestFocus();
    message.animationController.forward();
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
            child: Container(
              height: 50,
              child: TextField(
                controller: _textController,
                onChanged: (text) {
                  setState(() {});
                },
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.7),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.emoji_emotions_outlined,
                    color: Colors.grey,
                  ),
                  hintText: 'Message',
                  hintStyle: const TextStyle(fontSize: 20, color: Colors.grey),
                  suffixIconConstraints:
                  const BoxConstraints(minWidth: 80, maxWidth: 100),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.attach_file_outlined,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Icon(
                        Icons.camera_alt,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                focusNode: _focusNode,
              ),
            ),
          ),
          Container(
            height: 65,
            width: 65,
            child: IconButton(
              icon: _textController.text == ''
                  ? const CircleAvatar(
                  radius: 30,
                  backgroundColor: Color.fromRGBO(120, 149, 203, 0.95),
                  child: Icon(
                    Icons.mic,
                    color: Colors.white,
                  ))
                  : const CircleAvatar(
                radius: 30,
                backgroundColor: Color.fromRGBO(120, 149, 203, 0.95),
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
              opacity: 0.1,
              scale: 0.5,
              image: AssetImage("assets/images/logo.png"),
              fit: BoxFit.contain)),
      child: Column(
        children: [
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          Container(
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }
}
