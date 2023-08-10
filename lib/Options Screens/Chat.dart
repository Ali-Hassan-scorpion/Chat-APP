import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safe_city_project/set_height_and_width.dart';

void main() {
  runApp(MaterialApp(home: ChatScreen()));
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isLoading = false;
  late Map<String, dynamic> userMap;
  final TextEditingController _search = TextEditingController();

  void onSearchh() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(120, 149, 203, 1),
                Color.fromRGBO(74, 85, 162, 1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
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
                PopupMenuItem(child: Text('Option 1')),
                PopupMenuItem(child: Text('Option 2')),
                // Add more options as needed
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
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      contact(
                        'assets/images/logo.png',
                        'Ayoub',
                        '19:30',
                        'online',
                        'Chokran bezaf khouya',
                        context,
                      ),
                      contact(
                        'assets/images/logo.png',
                        'Anas',
                        '10:05',
                        'online',
                        'Inchaalah nji andek...',
                        context,
                      ),
                      contact(
                        'assets/images/logo.png',
                        'Hamid',
                        '18:20',
                        'online',
                        'Merci beaucoup frero',
                        context,
                      ),
                      contact(
                        'assets/images/logo.png',
                        'yassine',
                        '12:10',
                        'online',
                        'Thank so much for your help',
                        context,
                      ),
                      contact(
                        'assets/images/logo.png',
                        'Ayman',
                        '16:45',
                        'online',
                        'Am in the way, just 5 min...',
                        context,
                      ),
                      contact(
                        'assets/images/logo.png',
                        'Achraf',
                        '19:30',
                        'online',
                        'Fin nta db, ana f casa...',
                        context,
                      ),
                      contact(
                        'assets/images/logo.png',
                        'Hamza',
                        'Yesterday',
                        'online',
                        'Can you explain to me ?',
                        context,
                      ),
                      contact(
                        'assets/images/logo.png',
                        'youssef',
                        'Yesterday',
                        'online',
                        'Salam alaykom...',
                        context,
                      ),
                      contact(
                        'assets/images/logo.png',
                        'Mohamed',
                        'Yesterday',
                        'online',
                        'Lktab lakhor zwin bezaf',
                        context,
                      ),
                      contact(
                        'assets/images/logo.png',
                        'tariq',
                        '4/23/22',
                        'online',
                        'Wach chritiha men tema',
                        context,
                      ),
                      contact(
                        'assets/images/logo.png',
                        'Adam',
                        '4/23/22',
                        'online',
                        'Kif halek bikhir, kolchi mzn',
                        context,
                      ),
                      contact(
                        'assets/images/logo.png',
                        'Islam',
                        '4/23/22',
                        'online',
                        'It\'s a great story',
                        context,
                      ),
                    ],
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color.fromRGBO(120, 149, 203, 1),
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
      return Center(
        child: Text('Please enter a search query'),
      );
    }

    return FutureBuilder(
      future: onSearch(query),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return Center(
            child: Text('No results found'),
          );
        }

        final userMap = snapshot.data!;

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Search result for: $query'),
              Text('User Data: ${userMap.toString()}'),
            ],
          ),
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
            return ListTile(
              title: Text(suggestions[index]),
              onTap: () {
                query = suggestions[index]; // Set query and show results
                showResults(context);
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


}

Widget contact(
    String urlImage, String title, var time, onOff, String msgs, context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
    child: ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => message(urlImage, title, onOff, context)),
        );
      },
      leading: Container(
        height: 50,
        width: 50,
        child: ClipOval(
          child: Image.asset(
            urlImage,
            fit: BoxFit.fill,
          ),
        ),
      ),
      title: Text(title),
      subtitle: Row(
        children: [
          const Icon(
            Icons.done_all,
            size: 20,
            color: Colors.blueAccent,
          ),
          const SizedBox(
            width: 4.0,
          ),
          Text(
            msgs,
          ),
        ],
      ),
      trailing: Text(time),
    ),
  );
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
