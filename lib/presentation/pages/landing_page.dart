import 'package:flutter/material.dart';
import 'package:mucic_store/presentation/my_colors/color.dart';
import 'package:mucic_store/presentation/widgets/custome_list_tile.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      appBar: AppBar(
        backgroundColor: darkColor,
        leading: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        title: const Center(
          child: Text(
            "Music Store",
            style: TextStyle(color: Colors.white),
          ),
        ),
        //  backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
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
