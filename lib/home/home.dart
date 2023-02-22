import 'package:bloc_app/home/bloc/home_bloc.dart';
import 'package:bloc_app/home/bloc/home_event.dart';
import 'package:bloc_app/home/bloc/home_state.dart';
import 'package:bloc_app/services/boredService.dart';
import 'package:bloc_app/services/connectivityService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = context.read<HomeBloc>();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Things for Dummies'),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is HomeLoadedState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.activityName),
                Text(state.activityType),
                Text(
                  state.participants.toString(),
                ),
                ElevatedButton(
                    onPressed: () =>
                        _bloc.add(LoadApiEvent()),
                    child: const Text('Load Next')),
              ],
            );
          }
          if (state is HomeNoInternetState) {
            return const Text('No Internet');
          }
          return Container();
        },
      ),
    );
  }
}

