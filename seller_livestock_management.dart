import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'collections/livestock.dart';

class SellerLivestockManagementPage extends StatefulWidget {
  final Isar isar;

  SellerLivestockManagementPage({required this.isar});

  @override
  _SellerLivestockManagementPageState createState() => _SellerLivestockManagementPageState();
}

class _SellerLivestockManagementPageState extends State<SellerLivestockManagementPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController sexController = TextEditingController();
  final TextEditingController breedController = TextEditingController();
  final TextEditingController farmerNameController = TextEditingController();

  void _addLivestock() async {
    if (_formKey.currentState!.validate()) {
      final livestock = Livestock()
        ..type = typeController.text
        ..age = int.parse(ageController.text)
        ..sex = sexController.text
        ..breed = breedController.text
        ..farmerName = farmerNameController.text
        ..dateListed = DateTime.now();

      await widget.isar.writeTxn(() async {
        await widget.isar.livestocks.put(livestock);
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Livestock added')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Livestock Management'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Type'),
                TextFormField(
                  controller: typeController,
                  decoration: InputDecoration(hintText: 'e.g., chicken, cow, pig'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter type';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15.0),
                const Text('Age (months)'),
                TextFormField(
                  controller: ageController,
                  decoration: InputDecoration(hintText: 'e.g., 12'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter age';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15.0),
                const Text('Sex'),
                TextFormField(
                  controller: sexController,
                  decoration: InputDecoration(hintText: 'e.g., male, female'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter sex';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15.0),
                const Text('Breed'),
                TextFormField(
                  controller: breedController,
                  decoration: InputDecoration(hintText: 'e.g., ph breeds'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter breed';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15.0),
                const Text('Farmer Name'),
                TextFormField(
                  controller: farmerNameController,
                  decoration: InputDecoration(hintText: 'enter your name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter farmer name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15.0),
                ElevatedButton(
                  onPressed: _addLivestock,
                  child: const Text('Add to listing'),
                ),
              ],
            ),
          ),
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


