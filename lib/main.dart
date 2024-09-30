import 'package:flutter/material.dart';

void main() => runApp(ToDoApp());

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      home: ToDoListScreen(),
    );
  }
}

class ToDoListScreen extends StatefulWidget {
  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  final List<String> _toDoItems = [];

  void _addToDoItem(String task) {
    setState(() {
      _toDoItems.add(task);
    });
  }

  void _removeToDoItem(int index) {
    setState(() {
      _toDoItems.removeAt(index);
    });
  }

  void _promptAddToDoItem() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddTaskDialog(onSubmit: _addToDoItem);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: ListView.builder(
        itemCount: _toDoItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_toDoItems[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _removeToDoItem(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _promptAddToDoItem,
        child: Icon(Icons.add),
        tooltip: 'Add Task',
      ),
    );
  }
}

class AddTaskDialog extends StatefulWidget {
  final Function(String) onSubmit;

  AddTaskDialog({required this.onSubmit});

  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add a new task'),
      content: TextField(
        controller: _textController,
        autofocus: true,
        decoration: InputDecoration(labelText: 'Enter task here'),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Add'),
          onPressed: () {
            widget.onSubmit(_textController.text);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
