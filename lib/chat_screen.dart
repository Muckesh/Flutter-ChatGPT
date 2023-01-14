import 'package:chatgpt/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'chat_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  final List<ChatMessage> _messages = [];
  var scrollController = ScrollController();
  scrollMethod() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  final spinkit = const SpinKitWave(
    color: Colors.white,
    size: 45.0,
  );

  bool _istyping = false;

  Widget _sendMessage() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
            onSubmitted: (value) => _send(),
            controller: _controller,
            decoration: const InputDecoration.collapsed(
              hintStyle:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              hintText: "Send a Message...",
            ),
          ),
        ),
        IconButton(
            onPressed: _send,
            icon: const Icon(
              Icons.send,
              color: Colors.white,
            ))
      ],
    );
  }

  void _send() async {
    _messages.insert(
        0, ChatMessage(text: _controller.text, type: ChatSender.user));
    setState(() {
      _istyping = true;
    });
    var msg = await ApiServices.sendMessage(_controller.text);
    setState(() {
      _messages.insert(0, ChatMessage(text: msg, type: ChatSender.bot));
      _istyping = false;
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff181E4E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "ChatGPT",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                reverse: true,
                controller: scrollController,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  var chat = _messages[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: chat.type == ChatSender.bot
                              ? const Color(0xff2653FC)
                              : const Color(0xff535259),
                          child: Text(
                            chat.type == ChatSender.bot ? "AI" : "You",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: chat.type == ChatSender.user
                              ? Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xff535259),
                                          Color(0xffB5B1B2),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0),
                                        topLeft: Radius.circular(10.0),
                                      )),
                                  child: Text(
                                    chat.text!,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xff2653FC),
                                          Color(0xff243DB1),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0),
                                        topLeft: Radius.circular(10.0),
                                      )),
                                  child: Text(
                                    chat.text!,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            if (_istyping == true) spinkit,
            const Divider(
              height: 1.0,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                color: Color(0xff243DB1),
              ),
              child: _sendMessage(),
            )
          ],
        ),
      ),
    );
  }
}
