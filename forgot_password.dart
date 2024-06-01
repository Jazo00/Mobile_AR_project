import 'package:flutter/material.dart';

//create logic for sending code (OTP) to email.
//upon researching paid mostly ang APIs in terms of OTP for email and phone number.
class ForgotPasswordPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
       body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50.0),
              Image.asset(
                'lib/assets/logo_agri2.png', 
                width: 200.0,
                height: 200.0,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Enter email',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Send code to email',
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          //add code here related sa API para mag send ng code sa email. 
                          Navigator.pushNamed(context, '/verify_otp');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(int.parse('0xFF4CAF50')),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Verify'),
                      ),
                    )
                  ],
                ),
              ),
            ]
          )
        )
      )
    );
  }
}
//UI for this is done, applying logics nalang and (API?).
