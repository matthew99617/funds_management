import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funds_management/presentation/router/router.gr.dart';
import 'bloc/cubit/theme/theme_change_cubit.dart';
import 'config/config_reader.dart';
import 'config/environment.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigReader.initializeApp(Environment.dev);
  final _appRouter = AppRouter();
  runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ThemeChangeCubit(),
          ),
        ],
        child: MyApp(
          appRouter: _appRouter,
        ),
      )
  );
}

class MyApp extends StatelessWidget {

  final AppRouter _appRouter;

  const MyApp({
    Key? key,
    required AppRouter appRouter,
  }) : _appRouter = appRouter,
        super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeChangeCubit, ThemeChangeState>(
      builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: ConfigReader.config().DEBUG,
          theme: state.themeData,
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
          builder: (context, router) => router!,
        );
      },
    );
  }
}
