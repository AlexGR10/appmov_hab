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
            color: Colors.grey[300]!, // Color del borde inferior
            width: 1.0, // Grosor del borde inferior
          ),
        ),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  '${widget.label}: ',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Letras negras
                  ),
                ),
              ),
              Text(
                _currentText,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black, // Letras negras
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
                        border: InputBorder.none, // Sin borde
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isEditing = false;
                              _currentText = _textEditingController.text;
                            });
                          },
                          icon: const Icon(
                            Icons.check,
                            color: Colors.black, // Icono de guardar negro
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
                      child: const Icon(
                        Icons.edit,
                        color: Colors.black, // Icono de lápiz negro
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
