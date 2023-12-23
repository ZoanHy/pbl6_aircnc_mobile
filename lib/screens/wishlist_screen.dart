import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_aircnc/blocs/auth_bloc/auth_bloc.dart';
import 'package:pbl6_aircnc/blocs/property_bloc/property_bloc.dart';
import 'package:pbl6_aircnc/blocs/wishlist_bloc/wishlist_bloc.dart';
import 'package:pbl6_aircnc/widgets/property_card.dart';

class WishlistScreen extends StatefulWidget {
  WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final WishlistBloc wishlistBloc = WishlistBloc();

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
          return Scaffold(
            appBar: AppBar(title: Text('Wishlist')),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: RefreshIndicator(
                onRefresh: () {
                  return Future.delayed(
                    Duration(seconds: 1),
                    () {
                      wishlistBloc.add(LoadAllWishlistEvent());
                    },
                  );
                },
                child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: state.wishlistProperty.length,
                  itemBuilder: (context, index) {
                    final property = state.wishlistProperty[index];
                    return PropertyCard(property: property);
                  },
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
