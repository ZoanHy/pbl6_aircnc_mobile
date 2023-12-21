import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_aircnc/blocs/auth_bloc/auth_bloc.dart';
import 'package:pbl6_aircnc/blocs/property_bloc/property_bloc.dart';
import 'package:pbl6_aircnc/widgets/property_card.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PropertyBloc propertyBloc = PropertyBloc();

  @override
  void initState() {
    super.initState();
    propertyBloc.add(LoadAllPropertyEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PropertyBloc, PropertyState>(
      bloc: propertyBloc,
      builder: (context, state) {
        if (state is LoadAllPropertyState) {
          return Scaffold(
            appBar: AppBar(title: Text('Home')),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: state.properties.length,
                itemBuilder: (context, index) {
                  final property = state.properties[index];
                  return PropertyCard(property: property);
                },
              ),
            ),
          );
        } 
        return Container();
      },
    );
  }
}
