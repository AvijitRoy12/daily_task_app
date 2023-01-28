import 'package:daily_task_app/bloc/internet_bloc.dart';
import 'package:daily_task_app/bloc/internet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InternetBloc(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connection Test')),
      body: Center(
          child: BlocConsumer<InternetBloc, InternetState>(
        listener: (context, state) {
          if (state is InternetGainedState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Connected!'),
              backgroundColor: Colors.green,
            ));
          } else if (state is InternetLostState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('No internet connection!'),
              backgroundColor: Colors.red,
            ));
          }
        },
        builder: (context, state) {
          if (state is InternetGainedState) {
            return const Text('Connected!');
          } else if (state is InternetLostState) {
            return const Text('No internet connection!');
          } else {
            return const Text('Loading..');
          }
        },
      )),
    );
  }
}
