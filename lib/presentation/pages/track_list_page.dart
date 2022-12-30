import 'package:flutter/material.dart';
import 'package:mucic_store/presentation/my_colors/color.dart';
import 'package:mucic_store/presentation/widgets/custome_list_tile.dart';

class TrackListPage extends StatefulWidget {
  final String title;
  const TrackListPage({required this.title, super.key});

  @override
  State<TrackListPage> createState() => _TrackListPageState();
}

class _TrackListPageState extends State<TrackListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
      ),
      body: ListView(
        children: List.generate(
          20,
          (index) => customeListTile(
            title: "Song title",
            context: context,
            onTap: () {},
            color: MyColors.primaryColor,
            smallDetails: [
              'subtitle of song',
            ],
          ),
        ),
      ),
    );
  }
}
