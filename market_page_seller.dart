import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'collections/livestock.dart';

class MarketPageSeller extends StatefulWidget {
  final Isar isar;

  MarketPageSeller({required this.isar});

  @override
  _MarketPageSellerState createState() => _MarketPageSellerState();
}

class _MarketPageSellerState extends State<MarketPageSeller> {
  List<Livestock> _livestockList = [];
  String _filterType = 'All';
  String _filterSex = 'All';
  int _filterAgeMin = 0;
  int _filterAgeMax = 240; //240 months is equal to 20 years (life expectancy of cows and pigs)

  @override
  void initState() {
    super.initState();
    _loadLivestock();
  }

  void _loadLivestock() async {
    final livestocks = await widget.isar.livestocks.where().findAll();
    setState(() {
      _livestockList = livestocks;
    });
  }

  List<Livestock> _applyFilters() {
    return _livestockList.where((livestock) {
      final matchesType = _filterType == 'All' || livestock.type == _filterType;
      final matchesSex = _filterSex == 'All' || livestock.sex == _filterSex;
      final matchesAge = livestock.age >= _filterAgeMin && livestock.age <= _filterAgeMax;
      return matchesType && matchesSex && matchesAge;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredLivestock = _applyFilters();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Market'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton<String>(
                  value: _filterType,
                  items: ['All', 'chicken', 'cow', 'pig'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _filterType = newValue!;
                    });
                  },
                ),
                DropdownButton<String>(
                  value: _filterSex,
                  items: ['All', 'male', 'female'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _filterSex = newValue!;
                    });
                  },
                ),
                RangeSlider(
                  values: RangeValues(_filterAgeMin.toDouble(), _filterAgeMax.toDouble()),
                  min: 0,
                  max: 240,
                  divisions: 240,
                  labels: RangeLabels('$_filterAgeMin', '$_filterAgeMax'),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _filterAgeMin = values.start.toInt();
                      _filterAgeMax = values.end.toInt();
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredLivestock.length,
              itemBuilder: (context, index) {
                final livestock = filteredLivestock[index];
                return Card(
                  child: ListTile(
                    title: Text('${livestock.type} - ${livestock.age} months'),
                    subtitle: Text('Sex: ${livestock.sex}\nFarmer: ${livestock.farmerName}\nListed on: ${livestock.dateListed}'),
                    onTap: () {
                      // Handle card tap, e.g., navigate to detail page
                    },
                  ),
                );
              },
            ),
          ),
        ],
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
        currentIndex: 3,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/main_page_seller');
              break;
            case 1:
              Navigator.pushNamed(context, '/market_page_seller'); 
              break;
            case 2:
              Navigator.pushNamed(context, '/profile'); //no routes atm, this should be account_page_seller
              break;
            case 3:
              Navigator.pushNamed(context, '/seller_livestock_management');
              break;
            case 4:
              Navigator.pushNamed(context, '/transactions'); //no routes atm, this should be manage_orders_seller
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


