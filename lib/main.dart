import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pagameto_credit_pix/blocs/auth/auth_bloc.dart';
import 'package:pagameto_credit_pix/blocs/auth/auth_event.dart';
import 'package:pagameto_credit_pix/blocs/auth/auth_state.dart';
import 'package:pagameto_credit_pix/blocs/cart/cart_bloc.dart';
import 'package:pagameto_credit_pix/blocs/product/product_bloc.dart';
import 'package:pagameto_credit_pix/repositories/auth_repository.dart';
import 'package:pagameto_credit_pix/repositories/product_repository.dart';
import 'package:pagameto_credit_pix/ui/delivery_tracking_screen.dart';
import 'package:pagameto_credit_pix/ui/home_screen.dart';
import 'package:pagameto_credit_pix/ui/login_screen.dart';
import 'package:pagameto_credit_pix/ui/register_screen.dart';
import 'package:pagameto_credit_pix/widgets/cart_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final AuthRepository authRepository = AuthRepository();
  final ProductRepository productRepository = ProductRepository(baseUrl: 'https://your-api-url.com');

  runApp(MyApp(authRepository: authRepository, productRepository: productRepository));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final ProductRepository productRepository;

  MyApp({required this.authRepository, required this.productRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..add(AuthCheckRequested()),
        ),
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(repository: productRepository),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              return HomeScreen();
            } else if (state is AuthUnauthenticated) {
              return LoginScreen();
            } else {
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            }
          },
        ),
        routes: {
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/home': (context) => HomeScreen(),
          '/cart': (context) => CartScreen(),
          '/delivery-tracking': (context) => DeliveryTrackingScreen(),
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'ui/payment_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Pagamentos',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: PaymentScreen(),
//     );
//   }
// }
