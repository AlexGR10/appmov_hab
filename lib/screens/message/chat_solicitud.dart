import 'package:flutter/material.dart';

class ChatSolicitud extends StatefulWidget {
  final String userName;
  final String currentUser = 'Marco';

  const ChatSolicitud({super.key, required this.userName});

  @override
  State<ChatSolicitud> createState() => _ChatSolicitudState();
}

class _ChatSolicitudState extends State<ChatSolicitud> {

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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              // Acción cuando se presiona el botón de aceptar
            },
            child: const Text('Aceptar'),
          ),
          ElevatedButton(
            onPressed: () {
              // Acción cuando se presiona el botón de rechazar
            },
            child: const Text('Rechazar'),
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
