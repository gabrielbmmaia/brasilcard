import 'package:brasilcard/core/di/core_di.dart';
import 'package:brasilcard/features/coin_list/presentation/viewmodel/coin_list/coin_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ICoinListViewModel viewmodel;

  @override
  void initState() {
    viewmodel = injection<ICoinListViewModel>();
    viewmodel.getCryptos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Observer(
        builder: (context) {
          return viewmodel.isLoading
              ? CircularProgressIndicator()
              : viewmodel.errorMessage != null
              ? Center(child: Text(viewmodel.errorMessage!))
              : ListView.separated(
                itemCount: viewmodel.cryptos.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  final model = viewmodel.cryptos[index];
                  return Text(
                    model.name,
                    style: TextStyle(color: Colors.black),
                  );
                },
              );
        },
      ),
    );
  }
}
