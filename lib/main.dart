import 'package:blok/cubit/listview_cubit.dart';
import 'package:blok/cubit/listview_state.dart';
import 'package:blok/cubit/testik_cubit.dart';
import 'package:blok/cubit/theme_cubit.dart';
import 'package:blok/cubit/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cubit',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => TestikCubit()),
          BlocProvider(create: (context) => ThemeCubit()),
          BlocProvider(create: (context) => ListViewCubit())
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              theme: state.theme,
              home: const MyHomePage(),
            );
          },
        ),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Счет:',
            ),
            BlocConsumer<TestikCubit, TestikState>(
              listener: (context, state) {
                if (state is TestError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error.toString())));
                }
              },
              builder: (context, state) {
                if (state is TestClick) {
                  return Text(state.count.toString());
                }
                return Text("Нажмите кнопку");
              },
            ),
          Expanded(
          child: SizedBox(
            height: 500.0,
            child: 
            BlocBuilder<ListViewCubit, ListViewState>(
              builder: (context, state)
              {
                return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: context.read<ListViewCubit>().state.clicks.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(index.toString()),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                       child: Text('${context.read<ListViewCubit>().state.clicks[index]}'),
                    ),
                  ],
                );
              }
                );
              }
            ),
          ),
          ),

          ],

        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              if(context.read<ThemeCubit>().state.theme==ThemeData.light())
              {
              context.read<TestikCubit>().increment();
              context.read<ListViewCubit>().writeClicks("Светлая тема: увелечение  +1");
              }
              else
              {
                context.read<TestikCubit>().doubleIncDec(1);
                context.read<ListViewCubit>().writeClicks("Темная тема:  +2");
              }
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          SizedBox(width: 20),
          FloatingActionButton(
            onPressed: () {
               if(context.read<ThemeCubit>().state.theme==ThemeData.light())
               {
                  context.read<TestikCubit>().decriment();
                  context.read<ListViewCubit>().writeClicks("Светлая тема: -1");
               }
                else
                {
                  context.read<TestikCubit>().doubleIncDec(0); 
                  context.read<ListViewCubit>().writeClicks("Темная тема:  -2");
                }
              
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.minimize_rounded),
          ),
          SizedBox(width: 20),
           FloatingActionButton(
             onPressed: () => context.read<ThemeCubit>().changeTheme(),
             tooltip: 'Theme',
            child: const Icon(Icons.thermostat),
          ),
       
        ],
      ),
    );
  }
}
