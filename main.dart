import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'sign_up.dart';
import 'forgot_password.dart';
import 'verify_otp.dart';
import 'new_password.dart';
import 'main_page_customer.dart';
import 'market_page_customer.dart';

import 'main_page_seller.dart';
import 'market_page_seller.dart';
import 'seller_livestock_management.dart';

import 'collections/user_customer.dart';
import 'collections/user_seller.dart';
import 'collections/livestock.dart';
//import 'profile_page.dart';
//import 'transaction_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  final isar  = await Isar.open(
    [UserCustomerSchema, UserSellerSchema, LivestockSchema],
    directory: dir.path,
  );

  runApp(MyApp(isar: isar));
}

//this is where all routes happen (adjust when needed).
class MyApp extends StatelessWidget {
  final Isar isar;

  const MyApp({required this.isar});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(isar: isar),
        '/sign_up': (context) => SignUpPage(isar: isar),
        '/forgot_password': (context) => ForgotPasswordPage(),
        '/verify_otp': (context) => VerifyOtpPage(),
        '/new_password': (context) => NewPasswordPage(),
        '/main_page_customer': (context) => MainPageCustomer(), 
        '/market_page_customer': (context) => MarketPageCustomer(isar: isar), 
        //'/account_page_customer': (context) => AccountPageCustomer(), 
        //'/manage_orders_customer': (context) => ManageOrdersCustomer(), 

        '/main_page_seller': (context) => MainPageSeller(), 
        '/market_page_seller': (context) => MarketPageSeller(isar: isar),
        '/seller_livestock_management': (context) => SellerLivestockManagementPage(isar: isar),
        //'/account_page_seller': (context) => AccountPageSeller(),
        //'/manage_orders_seller': (context) => ManageOrdersCustomer(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  final Isar isar;

  LoginPage({required this.isar});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String userType = 'Customer';

  void _login() async {
    final username = usernameController.text;
    final password = passwordController.text;

    if (username.isEmpty) {
      _showSnackbar('Please enter your username *Required!*');
      return;
    }

    if (password.isEmpty) {
      _showSnackbar('Please enter your password *Required!*');
      return;
    }
    
    bool isValidUser = false;

    if (userType == 'Customer') {
      final customer = await widget.isar.userCustomers
        .filter()
        .usernameEqualTo(username)
        .passwordEqualTo(password)
        .findFirst();

      if (customer != null) {
        isValidUser = true;
        }
      }
      else {
        final seller = await widget.isar.userSellers
          .filter()
          .usernameEqualTo(username)
          .passwordEqualTo(password)
          .findFirst();

        if (seller != null) {
          isValidUser = true;
        }
      }

      if (isValidUser) {
        if (userType == 'Customer') {
          Navigator.pushNamed(context, '/main_page_customer');
        } 
        else {
          Navigator.pushNamed(context, '/main_page_seller');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid user logging in')),
        );
      }
    }

    void _showSnackbar(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('                        AGRI-TRADE'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/logo_agri2.png', 
                width: 200.0,
                height: 200.0,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Username',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                    ),
                  ),
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Enter your username here',
                      prefixIcon: const Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Password',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Enter your password here',
                      prefixIcon: const Icon(Icons.lock),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'User type',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 57,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: InputDecorator(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.person), 
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: userType,
                        isExpanded: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            userType = newValue!;
                          });
                        },
                        items: <String>['Customer', 'Seller']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(int.parse('0xFF1976D2')), 
                  foregroundColor: Colors.white, 
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
                ),
                child: const Text('Login')
                ),
                const SizedBox(width: 20), 
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/sign_up');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(int.parse('0xFF4CAF50')),
                  foregroundColor: Colors.white, 
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
                ),
                child: const Text('Sign up'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/forgot_password');
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blueAccent,
                  ),
                    child: const Text('Forgot Password?'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

