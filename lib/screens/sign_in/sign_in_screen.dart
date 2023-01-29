import 'package:daily_task_app/screens/sign_in/bloc/sign_in_bloc.dart';
import 'package:daily_task_app/screens/sign_in/bloc/sign_in_event.dart';
import 'package:daily_task_app/screens/sign_in/bloc/sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            'Login to your account',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          BlocBuilder<SignInBloc, SignInState>(
            builder: (context, state) {
              if (state is SignInErrorState) {
                return Text(
                  state.errorMessage,
                  style: const TextStyle(fontSize: 13, color: Colors.red),
                );
              } else {
                return Container();
              }
            },
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            controller: emailController,
            onChanged: (value) {
              BlocProvider.of<SignInBloc>(context).add(SignInTextChangedEvent(
                  emailController.text, passwordController.text));
            },
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                filled: true,
                hintText: 'Email',
                fillColor: Colors.blue.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: passwordController,
            onChanged: (value) {
              BlocProvider.of<SignInBloc>(context).add(SignInTextChangedEvent(
                  emailController.text, passwordController.text));
            },
            obscureText: true,
            decoration: InputDecoration(
                filled: true,
                hintText: 'Password',
                fillColor: Colors.blue.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<SignInBloc, SignInState>(
            builder: (context, state) {
              if (state is SignInLoadingState) {
                return Center(child: CircularProgressIndicator());
              }
              return ElevatedButton(
                onPressed: () {
                  BlocProvider.of<SignInBloc>(context).add(SignInSubmittedEvent(
                      emailController.text, passwordController.text));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      (state is SignInValidState) ? Colors.black : Colors.grey,
                  minimumSize: const Size.fromHeight(50), // NEW
                ),
                child: const Text('Login'),
              );
            },
          ),
        ]),
      ),
    );
  }
}
