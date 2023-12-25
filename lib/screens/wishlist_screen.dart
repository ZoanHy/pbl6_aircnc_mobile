import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:pbl6_aircnc/blocs/auth_bloc/auth_bloc.dart';
import 'package:pbl6_aircnc/blocs/property_bloc/property_bloc.dart';
import 'package:pbl6_aircnc/blocs/wishlist_bloc/wishlist_bloc.dart';
import 'package:pbl6_aircnc/models/property.dart';
import 'package:pbl6_aircnc/widgets/property_card.dart';

class WishlistScreen extends StatefulWidget {
  WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final WishlistBloc wishlistBloc = WishlistBloc();
  int numberOfPages = 0;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    wishlistBloc.add(LoadAllWishlistEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistBloc, WishlistState>(
      bloc: wishlistBloc,
      builder: (context, state) {
        if (state is LoadAllWishlistState) {
          numberOfPages = state.wishlistPropertiesPage.length;
          var pages;
          if (numberOfPages != 0) {
            pages = List.generate(
                numberOfPages,
                (idxPage) => Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView.builder(
                        itemCount: state.wishlistPropertiesPage[idxPage].length,
                        itemBuilder: (context, idxItem) {
                          List<Property> properties =
                              state.wishlistPropertiesPage[idxPage];
                          final property = properties[idxItem];
                          return PropertyCard(property: property);
                        },
                      ),
                    ));
          }

          return Scaffold(
            appBar: AppBar(title: Text('Wishlist')),
            body: numberOfPages != 0
                ? RefreshIndicator(
                    onRefresh: () {
                      return Future.delayed(
                        Duration(seconds: 1),
                        () {
                          wishlistBloc.add(LoadAllWishlistEvent());
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: Column(
                        children: [
                          Expanded(
                              child: Container(
                            child: pages[currentPage],
                          )),
                          NumberPaginator(
                            numberPages: numberOfPages,
                            onPageChange: (index) {
                              setState(() {
                                currentPage = index;
                              });
                            },
                          )
                        ],
                      ),
                    ))
                : Center(),
          );
        }
        return Container();
      },
    );
  }
}
