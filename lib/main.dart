import 'package:daily_task_app/cubit/todo_cubit.dart';
import 'package:daily_task_app/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const Home());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: BlocProvider(
        create: (context) => TodoCubit(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daily Task')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
            ),
          ),
          SizedBox(
            width: 350,
            child: ElevatedButton(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    BlocProvider.of<TodoCubit>(context)
                        .addNewTodo(_controller.text);
                    _controller.clear();
                  }
                },
                child: const Text('Add')),
          ),
          Expanded(
            child: BlocBuilder<TodoCubit, TodoInitial>(
              builder: (context, state) {
                return ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: ((_, index) {
                      return Card(
                        elevation: 3,
                        child: ListTile(
                          title: Text(state.todos[index]),
                          trailing: IconButton(
                            onPressed: () {
                              BlocProvider.of<TodoCubit>(context)
                                  .deleteTodo(index);
                            },
                            icon: const Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      );
                    }));
              },
            ),
          ),
        ],
      ),
    );
  }
}
