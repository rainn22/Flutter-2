import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class App extends StatelessWidget {
  const App({super.key});

  void _onAddPressed(BuildContext context) {
    final pancakeProvider = context.read<Pancakeprovider>();
    pancakeProvider.addPancake("blue", 3.1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
              onPressed: () => _onAddPressed(context),
              icon: const Icon(Icons.add))
        ],
      ),
      body: const PancakeList(),
    );
  }
}

// PANCAKE LIST UI
class PancakeList extends StatelessWidget {
  const PancakeList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Pancakeprovider>(context);

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (provider.hasData) {
      final pancakes = provider.pancakesState!.data!;
      if (pancakes.isEmpty) {
        return const Center(child: Text("No pancakes yet"));
      }

      return ListView.builder(
        itemCount: pancakes.length,
        itemBuilder: (context, index) {
          final pancake = pancakes[index];
          return ListTile(
            title: Text(pancake.color),
            subtitle: Text("\$${pancake.price.toStringAsFixed(2)}"),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => provider.deletePancake(pancake.id),
            ),
          );
        },
      );
    } else {
      return const Center(child: Text("Failed to load data"));
    }
  }
}
