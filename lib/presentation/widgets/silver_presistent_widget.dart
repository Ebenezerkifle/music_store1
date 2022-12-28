import 'package:flutter/material.dart';

class PersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget widget;
  final BuildContext context;
  final double height;
  Color? color;
  double? minHeight;

  PersistentHeader({
    required this.widget,
    required this.context,
    required this.height,
    this.minHeight,
    this.color,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: color ?? Colors.white,
      width: double.infinity,
      height: height,
      child: Card(
        margin: const EdgeInsets.all(0),
        color: Colors.white,
        //elevation: 5.0,
        child: Center(child: widget),
      ),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => minHeight ?? height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
