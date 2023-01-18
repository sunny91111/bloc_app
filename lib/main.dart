import 'package:bloc_app/home/home.dart';
import 'package:bloc_app/services/boredService.dart';
import 'package:bloc_app/services/connectivityService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home/bloc/home_bloc.dart';
import 'home/bloc/home_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => BoredService(),
          ),
          RepositoryProvider(
            create: (context) => ConnectivityService(),
          ),
        ],
        child: BlocProvider(
          create: (context) => HomeBloc(
            RepositoryProvider.of<BoredService>(context),
            RepositoryProvider.of<ConnectivityService>(context),
          )..add(LoadApiEvent()),
          child: const HomeScreen(),
        ),
      ),
    );
  }
}
