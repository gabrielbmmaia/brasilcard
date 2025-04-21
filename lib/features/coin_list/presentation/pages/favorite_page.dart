import 'package:brasilcard/core/widgets/ds_app_bar.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DsAppBar(title: 'Favoritos'),
      body: Container(color: Colors.blue),
    );
  }
}
