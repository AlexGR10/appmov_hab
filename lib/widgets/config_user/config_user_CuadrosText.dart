import 'package:flutter/material.dart';

class UserAttributeEditField extends StatefulWidget {
  final String label;
  final String defaultText;
  final int id;

  const UserAttributeEditField({
    Key? key,
    required this.label,
    required this.defaultText,
    required this.id,
  }) : super(key: key);

  @override
  _UserAttributeEditFieldState createState() => _UserAttributeEditFieldState();
}

class _UserAttributeEditFieldState extends State<UserAttributeEditField> {
  late TextEditingController _textEditingController;
  String _currentText = '';
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _currentText = widget.defaultText;
    _textEditingController = TextEditingController(text: _currentText);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey, // Color del borde inferior
            width: 1.0, // Grosor del borde inferior
          ),
        ),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.label}: ',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5), // Espacio adicional
              Text(
                _currentText,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: _isEditing
                  ? TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isEditing = false;
                              _currentText = _textEditingController.text;
                            });
                          },
                          icon: const Icon(
                            Icons.check,
                            color: Color.fromARGB(255, 236, 135, 19),
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          _isEditing = true;
                        });
                      },
                      child: Row(
                        children: const [
                          Icon(
                            Icons.edit,
                            color: Color.fromARGB(255, 236, 135, 19),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
