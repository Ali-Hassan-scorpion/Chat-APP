import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: ChatScreen()));
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.blueAccent,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Image.asset('assets/images/logo.png', width: 40, height: 40),
                ),
                Text(
                  'ICT Police TalkHub',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                contact(
                  'assets/10.jpg',
                  'Ayoub',
                  '19:30',
                  'online',
                  'Chokran bezaf khouya',
                  context,
                ),
                contact(
                  'assets/20.jpg',
                  'Anas',
                  '10:05',
                  'online',
                  'Inchaalah nji andek...',
                  context,
                ),
                contact(
                  'assets/30.jpg',
                  'Hamid',
                  '18:20',
                  'online',
                  'Merci beaucoup frero',
                  context,
                ),
                contact(
                  'assets/40.jpg',
                  'yassine',
                  '12:10',
                  'online',
                  'Thank so much for your help',
                  context,
                ),
                contact(
                  'assets/50.jpg',
                  'Ayman',
                  '16:45',
                  'online',
                  'Am in the way, just 5 min...',
                  context,
                ),
                contact(
                  'assets/60.jpg',
                  'Achraf',
                  '19:30',
                  'online',
                  'Fin nta db, ana f casa...',
                  context,
                ),
                contact(
                  'assets/70.jpg',
                  'Hamza',
                  'Yesterday',
                  'online',
                  'Can you explain to me ?',
                  context,
                ),
                contact(
                  'assets/80.jpg',
                  'youssef',
                  'Yesterday',
                  'online',
                  'Salam alaykom...',
                  context,
                ),
                contact(
                  'assets/90.jpg',
                  'Mohamed',
                  'Yesterday',
                  'online',
                  'Lktab lakhor zwin bezaf',
                  context,
                ),
                contact(
                  'assets/100.jpg',
                  'tariq',
                  '4/23/22',
                  'online',
                  'Wach chritiha men tema',
                  context,
                ),
                contact(
                  'assets/110.jpg',
                  'Adam',
                  '4/23/22',
                  'online',
                  'Kif halek bikhir, kolchi mzn',
                  context,
                ),
                contact(
                  'assets/120.jpg',
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
        child: const Icon(Icons.chat),
      ),
    );
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
    appBar: AppBar(
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
            color: const Color(0xffdcf8c6),
            borderRadius: BorderRadius.circular(4.0)),
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
                  backgroundColor: Colors.teal,
                  child: Icon(
                    Icons.mic,
                    color: Colors.white,
                  ))
                  : const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.teal,
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
              onPressed: () =>
                  _handleSubmitted(_textController.text),
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
              image: AssetImage("assets/chatBack.jpg"), fit: BoxFit.cover)),
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
