import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyect_example/screens/message/chat_solicitud.dart';
import 'package:proyect_example/widgets/Message/chat_list.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagesPage> {
  List<ChatModel> _items = [];
  int _selectedItemIndex = -1;

  @override
  void initState() {
    super.initState();
    readJson();
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/messages.json');
    final List<dynamic> data = json.decode(response)["items"];

    setState(() {
      _items = data
          .map((item) => ChatModel(
                user: item["user"],
                image: item["image"],
                message: item["message"],
                time: item["time"],
                isMessageRead: true,
              ))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      "Mensajes",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 2, bottom: 2),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.pink[50],
                      ),
                      child: const Row(
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            color: Colors.pink,
                            size: 20,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "Nuevo",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SafeArea(
                child: Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Solicitudes",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ]))),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 15),
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (_selectedItemIndex == index) {
                                _selectedItemIndex =
                                    -1; // Deseleccionar el elemento si ya está seleccionado
                              } else {
                                _selectedItemIndex = index;
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatSolicitud(
                                      userName: _items[index].user),
                                ),
                              );
                            });
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: _selectedItemIndex == index
                                          ? Colors.grey
                                          : Colors.orange,
                                      width: 3,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 45,
                                    backgroundImage:
                                        NetworkImage(_items[index].image),
                                  ),
                                ),
                                Text(
                                  _items[index].user,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                ),
              ),
            ),
            ListView.builder(
              itemCount: _items.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 16),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ChatList(
                  user: _items[index].user,
                  message: _items[index].message,
                  image: _items[index].image,
                  time: _items[index].time,
                  isMessageRead: (index == 0 || index == 3) ? true : false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ChatModel {
  final String user;
  final String image;
  final String message;
  final String time;
  final bool isMessageRead;

  ChatModel({
    required this.user,
    required this.image,
    required this.message,
    required this.time,
    required this.isMessageRead,
  });
}
