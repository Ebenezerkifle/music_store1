import 'package:flutter/material.dart';
import 'package:mucic_store/presentation/widgets/custome_list_tile.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        title: const Center(
          child: Text(
            "Music Store",
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
            children: List.generate(
          10,
          (index) => customeListTile(
            context: context,
          ),
        )),
      ),
    );
  }
}
