import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: const Icon(Icons.menu),
            actions: const [
              Icon(Icons.search),
            ],
            elevation: 3,
            pinned: true,
            snap: false,
            floating: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.2,
            flexibleSpace: const FlexibleSpaceBar(
              centerTitle: true,
              title: Text('SliverAppBar'),
              collapseMode: CollapseMode.pin,
              background: FlutterLogo(),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 30,
              child: Center(
                child: Text('Scroll to see the SliverAppBar in effect.'),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Card(
                  elevation: 1,
                  child: Container(
                    color: Colors.black12,
                    height: 100.0,
                    child: Center(
                      child: Text('$index', textScaleFactor: 1),
                    ),
                  ),
                );
              },
              childCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
