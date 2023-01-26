import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'todo_state.dart';

class Todo {
  static List<String> data = [
    'Making cofee in the morning',
    'Prepare homework for DaF A2',
    'Go to the university',
    'Prepare work for office',
    'Do workout in the evening',
  ];
}


class TodoCubit extends Cubit<TodoInitial> {
  TodoCubit() : super(TodoInitial(todos: Todo.data));

  addNewTodo(String todo) {
    final todoList = state.todos;
    todoList.add(todo);
    emit(TodoInitial(todos: todoList));
  }

  deleteTodo(int index) {
    final todoList = state.todos;
    todoList.removeAt(index);
    emit(TodoInitial(todos: todoList));
  }
}
