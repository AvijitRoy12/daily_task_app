import 'package:daily_task_app/cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InternetCheckingScreen extends StatelessWidget {
  const InternetCheckingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InternetCubit(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: const InternetCheck(),
      ),
    );
  }
}

class InternetCheck extends StatelessWidget {
  const InternetCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connection Test')),
      body: Center(
          child: BlocConsumer<InternetCubit, InternetConnectionState>(
        listener: (context, state) {
          if (state == InternetConnectionState.Gained) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Connected!'),
              backgroundColor: Colors.green,
            ));
          } else if (state == InternetConnectionState.Lost) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('No internet connection!'),
              backgroundColor: Colors.red,
            ));
          }
        },
        builder: (context, state) {
          if (state == InternetConnectionState.Gained) {
            return const Text('Connected!');
          } else if (state == InternetConnectionState.Lost) {
            return const Text('No internet connection!');
          } else {
            return const Text('Loading..');
          }
        },
      )),
    );
  }
}
