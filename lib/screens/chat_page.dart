import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String userName;
  final String currentUser = 'Marco';

  const ChatPage({super.key, required this.userName});

  @override
  State<ChatPage>createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.userName}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ChatBubble(
                  message: 'Hola ${widget.currentUser}, ¿cómo estás?',
                  isSentByMe: false,
                ),
                const SizedBox(height: 8),
                ChatBubble(
                  message: '¡Hola ${widget.userName}! Estoy bien, ¿y tú?',
                  isSentByMe: true,
                ),
                const SizedBox(height: 8),
                const ChatBubble(
                  message: 'Estoy genial, gracias por preguntar.',
                  isSentByMe: false,
                ),
              ],
            ),
          ),
          _buildMessageComposer(),
        ],
      ),
    );
  }

  Widget _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      color: Colors.grey.shade200,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration:
                  const InputDecoration.collapsed(hintText: 'Type a message'),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSentByMe;

  const ChatBubble(
      {super.key, required this.message, required this.isSentByMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSentByMe ? Colors.blue : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isSentByMe ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
