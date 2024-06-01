import 'package:flutter/material.dart';

class MainPageSeller extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seller Main Page'),
      ),
      body: Center(
        child: Text(
          'Welcome, Seller!',
          style: TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/house.png')),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/market.png')),
            label: 'Market',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/edit-user.png')),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/livestock.png')),
            label: 'Livestock',
          ),
           BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/fees.png')),
            label: 'Transactions',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/main_page_seller');
              break;
            case 1:
              Navigator.pushNamed(context, '/market_page_customer');
              break;
            case 2:
              Navigator.pushNamed(context, '/profile');
              break;
            case 3:
              Navigator.pushNamed(context, '/seller_livestock_management');
              break;
            case 4:
              Navigator.pushNamed(context, '/transactions');
              break;
            default:
              Navigator.pushNamed(context, '/');
          }
        },
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}


