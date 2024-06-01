import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//UI done, Logics nalang for verification and API.
class VerifyOtpPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification'),
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
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 10.0),
                    const Text(
                      'OTP verification',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Enter OTP code here',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          //add logic here na mag mamatch dapat yung sinend na code sa email then saka mag verify.
                          Navigator.pushNamed(context, '/new_password');
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
