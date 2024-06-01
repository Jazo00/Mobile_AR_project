import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'collections/livestock.dart';

class MarketPageCustomer extends StatefulWidget {
  final Isar isar;

  MarketPageCustomer({required this.isar});
  
  @override
  _MarketPageCustomerPageState createState() => _MarketPageCustomerPageState();
}

class _MarketPageCustomerPageState extends State<MarketPageCustomer> {
  List<Livestock> _livestockList = [];
  String _filterType = 'All';
  String _filterSex = 'All';
  int _filterAgeMin = 0;
  int _filterAgeMax = 240; ///240 months is equal to 20 years (life expectancy of cows and pigs)

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
        title: const Text('Welcome to Market'),
        automaticallyImplyLeading: false, //back button change to true to appear.
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
                  items: ['All', 'Male', 'Female'].map((String value) {
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
                      //when tap navigate to detail page or pop a dialog box (will add later)
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
            icon: ImageIcon(AssetImage('lib/assets/fees.png')),
            label: 'Transactions',
          ),
        ],
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/main_page_customer');
              break;
            case 1:
              Navigator.pushNamed(context, '/market_page_customer');
              break;
            case 2:
              Navigator.pushNamed(context, '/profile'); //no routes atm, this should be account_page_customer
              break;
            case 3:
              Navigator.pushNamed(context, '/transactions'); //no routes atm, this should be manage_orders_customer
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


