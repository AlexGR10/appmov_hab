import 'package:flutter/material.dart';

class SkillsUserCuadro extends StatefulWidget {
  final String nombre;
  final String descripcion;
  final VoidCallback onDelete;

  const SkillsUserCuadro({
    Key? key,
    required this.nombre,
    required this.descripcion,
    required this.onDelete,
  }) : super(key: key);

  @override
  _SkillsUserCuadroState createState() => _SkillsUserCuadroState();
}

class _SkillsUserCuadroState extends State<SkillsUserCuadro> {
  late TextEditingController _nombreController;
  late TextEditingController _descripcionController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.nombre);
    _descripcionController = TextEditingController(text: widget.descripcion);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _isEditing
                    ? TextField(
                        controller: _nombreController,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Text(
                        widget.nombre,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: widget.onDelete,
              ),
              if (_isEditing)
                IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: () {
                    setState(() {
                      _isEditing = false;
                    });
                  },
                ),
            ],
          ),
          const SizedBox(height: 8.0),
          _isEditing
              ? TextField(
                  controller: _descripcionController,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                )
              : Text(
                  widget.descripcion,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
          if (!_isEditing)
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: _isEditing
                    ? const Icon(Icons.save)
                    : const Icon(Icons.edit),
                onPressed: () {
                  setState(() {
                    _isEditing = !_isEditing;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }
}
