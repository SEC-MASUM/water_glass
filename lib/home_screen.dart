import 'package:flutter/material.dart';
import 'package:water_glass/water_glass.dart';

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

  Widget _buildWaterGlassListView() {
    return ListView.separated(
      itemCount: waterGlassList.length,
      itemBuilder: (context, index) {
        return _buildWaterGlassListTile(index);
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }

  Widget _buildWaterGlassListTile(int index) {
    final WaterGlass waterGlass = waterGlassList[index];
    return ListTile(
      title: Text("${waterGlass.dateTime.hour}:${waterGlass.dateTime.minute}"),
      subtitle: Text(
          "${waterGlass.dateTime.day}/${waterGlass.dateTime.month}/${waterGlass.dateTime.year}"),
      leading: CircleAvatar(
        child: Text(
          "${waterGlass.numberOfGlasses}",
        ),
      ),
      trailing: IconButton(
        onPressed: () => _onTapDeleteWaterGlass(index),
        icon: const Icon(Icons.delete),
      ),
    );
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
              onPressed: _onTapAddWaterGlass,
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

  void _onTapAddWaterGlass() {
    if (_glassNoTEController.text.isEmpty) {
      _glassNoTEController.text = "1";
    }
    final int numberOfGlasses = int.tryParse(_glassNoTEController.text) ?? 1;
    WaterGlass waterGlass =
        WaterGlass(numberOfGlasses: numberOfGlasses, dateTime: DateTime.now());
    waterGlassList.add(waterGlass);
    setState(() {});
  }

  void _onTapDeleteWaterGlass(int index) {
    setState(() {
      waterGlassList.removeAt(index);
    });
  }

  @override
  void dispose() {
    _glassNoTEController.dispose();
    super.dispose();
  }
}
