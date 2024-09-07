import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _glassNoTEController =
      TextEditingController(text: "1");

  List<WaterGlass> waterGlassList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Water Glass"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildWaterGlassCounter(),
          const SizedBox(height: 24),
          Expanded(
            child: _buildWaterGlassListView(),
          )
        ],
      ),
    );
  }

  ListView _buildWaterGlassListView() {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: const Text("Time"),
            subtitle: const Text("Date"),
            leading: const Text("1"),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: 3);
  }

  Widget _buildWaterGlassCounter() {
    return Column(
      children: [
        Text(
          getTotalGlassCount().toString(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Text(
          "Glass/s",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 50,
              child: TextField(
                controller: _glassNoTEController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
              ),
            ),
            TextButton(
              onPressed: _addNewWaterGlass,
              child: const Text("Add"),
            ),
          ],
        ),
      ],
    );
  }

  int getTotalGlassCount() {
    int counter = 0;
    for (WaterGlass glass in waterGlassList) {
      counter += glass.numberOfGlasses;
    }
    return counter;
  }

  void _addNewWaterGlass() {
    if (_glassNoTEController.text.isEmpty) {
      _glassNoTEController.text = "1";
    }
    final int numberOfGlasses = int.tryParse(_glassNoTEController.text) ?? 1;
    WaterGlass waterGlass =
        WaterGlass(numberOfGlasses: numberOfGlasses, dateTime: DateTime.now());
    waterGlassList.add(waterGlass);
    setState(() {});
  }
}

class WaterGlass {
  final int numberOfGlasses;
  final DateTime dateTime;

  WaterGlass({required this.numberOfGlasses, required this.dateTime});
}
