import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funds_management/presentation/router/router.gr.dart';
import 'bloc/cubit/theme/theme_change_cubit.dart';
import 'config/config_reader.dart';
import 'config/environment.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigReader.initializeApp(Environment.dev);
  runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ThemeChangeCubit(),
          ),
        ],
        child: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final _appRouter = AppRouter();
    return BlocBuilder<ThemeChangeCubit, ThemeChangeState>(
      builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: ConfigReader.config().DEBUG,
          theme: state.themeData,
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
        );
      },
    );
  }
}
