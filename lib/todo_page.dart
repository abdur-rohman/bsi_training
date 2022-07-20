import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  Database? _db;
  final _dbName = 'todo.db';
  final _nameController = TextEditingController();
  final _todos = <Todo>[];

  @override
  void initState() {
    super.initState();

    openDatabase(_dbName).then((db) async {
      _db = db;
      await db.execute(
        'CREATE TABLE IF NOT EXISTS todo (id INTEGER PRIMARY KEY, name VARCHAR(20));',
      );
      _getTodo();
    }).catchError((e) => print('Eror: $e'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 16),
              Expanded(
                child: TextField(
                  controller: _nameController,
                ),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  _addTodo(_nameController.text);
                },
                child: Text('Add todo'),
              ),
              SizedBox(width: 16),
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (_, index) {
                var todo = _todos[index];
                return ListTile(
                  title: Text(todo.name),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _getTodo() async {
    try {
      var sql = "SELECT * FROM todo ORDER BY ID DESC";
      var todos = await _db?.rawQuery(sql) ?? [];
      _todos.clear();
      _todos.addAll(todos.map((e) => Todo.fromMap(e)));
      setState(() {});
    } catch (e, stackTrace) {
      print('Error: $e');
      print('StackTrace: $stackTrace');
    }
  }

  void _addTodo(String name) async {
    var id = DateTime.now().millisecondsSinceEpoch;
    var sql = 'INSERT INTO todo(id, name) VALUES(?, ?)';
    try {
      await _db?.rawInsert(sql, [id, name]);

      _nameController.clear();

      _getTodo();
    } catch (e, stackTrace) {
      print('Error: $e');
      print('StackTrace: $stackTrace');
    }
  }
}

class Todo {
  final int id;
  final String name;

  Todo({required this.id, required this.name});

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }
}
