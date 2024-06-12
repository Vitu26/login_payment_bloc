// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:pagameto_credit_pix/blocs/auth/auth_bloc.dart';
// import 'package:pagameto_credit_pix/blocs/auth/auth_state.dart';
// import 'package:path_provider/path_provider.dart';
// import 'repositories/auth_repository.dart';
// import 'ui/login_screen.dart';
// import 'ui/home_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   final storage = await HydratedStorage.build(
//     storageDirectory: await getApplicationDocumentsDirectory(),
//   );

//   HydratedBloc.storage = storage;

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   final AuthRepository authRepository = AuthRepository();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: BlocProvider(
//         create: (context) => AuthBloc(authRepository),
//         child: BlocBuilder<AuthBloc, AuthState>(
//           builder: (context, state) {
//             if (state is Authenticated) {
//               return HomeScreen();
//             } else {
//               return LoginScreen();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'ui/payment_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pagamentos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PaymentScreen(),
    );
  }
}
