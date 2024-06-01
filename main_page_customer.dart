import 'package:flutter/material.dart';

class MainPageCustomer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('          WELCOME TO AGRI-TRADE'),
        automaticallyImplyLeading: false, //back button change to true to appear.
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
            child: Container(
              width: 398.0,
              height: 125.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/cover.png'), 
                  fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'About Us',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'We are a brand that is focused on providing quality & and innovative food solutions with a vision to do more and bring happiness to families through Life’s Bounty. We take pride in our culture of innovation and drive to make an impact, ultimately bringing value and happiness to our customers.',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Our Story',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Bounty’s story started during the 1980s when the Chen family put up one layer house in Sta. Maria, Bulacan, Philippines and loaded the first 5,000 heads of chicken. From a 5,000-head layer farm, the business grew to be one of the largest broiler integrators in the country. It is the only fully-integrated poultry company that has continuously invested in company-owned facilities – Grand Parent farm, Parent Stock farm, Hatcheries, Dressing Plants, Feed Mills, and Cool-cell Broiler Complexes in the Philippines.',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '\u00a9 Copyright Bounty Agro Ventures, Inc. 2024',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
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
            icon: ImageIcon(AssetImage('lib/assets/fees.png')),
            label: 'Transactions',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/main_page_customer');
              break;
            case 1:
              Navigator.pushNamed(context, '/market_page_customer');
              break;
            case 2:
              Navigator.pushNamed(context, '/profile');
              break;
            case 3:
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
