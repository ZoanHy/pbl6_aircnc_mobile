import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pbl6_aircnc/blocs/wishlist_bloc/wishlist_bloc.dart';
import 'package:pbl6_aircnc/models/property.dart';
import 'package:pbl6_aircnc/screens/property_detail_screen.dart';

// ignore: must_be_immutable
class PropertyCard extends StatefulWidget {
  Property property;

  PropertyCard({super.key, required this.property});

  @override
  State<PropertyCard> createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {
  final controller = PageController();
  var currentPage = 0;
  bool isFavorite = true;
  bool isHover = false;

  final WishlistBloc wishlistBloc = WishlistBloc();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isFavorite = widget.property.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 10,
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                width: size.width,
                height: size.width - 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                ),
                child: PageView(
                  controller: controller,
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  children: widget.property.propertyImages.map((items) {
                    var imageUrl = items.url;
                    return CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      errorWidget: (context, error, stackTrace) {
                        return Image(
                          image:
                              AssetImage("assets/images/image_not_found.jpg"),
                          fit: BoxFit.cover,
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              Positioned(
                bottom: 15.0,
                left: 0.0,
                right: 0.0,
                child: DotsIndicator(
                  dotsCount: widget.property.propertyImages.length,
                  position: currentPage,
                  onTap: (index) {
                    controller.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                  decorator: DotsDecorator(
                    color: colorScheme.onSecondary,
                    activeColor: colorScheme.secondary,
                    size: const Size.square(8.0),
                    activeSize: const Size(12.0, 8.0),
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 20,
                  right: 20,
                  child: BlocBuilder<WishlistBloc, WishlistState>(
                    builder: (context, state) {
                      return IconButton(
                          onPressed: () {
                            if (!isFavorite) {
                              Fluttertoast.showToast(
                                  msg: 'Add to Wishlist',
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.green);
                            } else {
                              Fluttertoast.showToast(
                                  gravity: ToastGravity.BOTTOM,
                                  msg: 'Remove to Wishlist',
                                  backgroundColor: Colors.red);
                            }

                            wishlistBloc.add(ClickToLikeOrDislikeEvent(
                                property: widget.property));
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                          },
                          icon: isFavorite
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 30,
                                )
                              : Icon(
                                  Icons.favorite_border_outlined,
                                  color: Colors.red,
                                  size: 30,
                                ));
                    },
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Expanded(
                        child: InkWell(
                          onHover: (value) {
                            print(value);
                            setState(() {
                              isHover = value;
                            });
                          },
                          onTap: () {
                            Navigator.of(context, rootNavigator: true)
                                .push(MaterialPageRoute(
                              builder: (context) => PropertyDetailScreen(
                                propertyId: widget.property.id,
                              ),
                            ));
                          },
                          child: Text(
                            '${widget.property.title}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: isHover ? Colors.blue : Colors.black),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Color.fromRGBO(254, 178, 7, 5),
                            size: 20,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${(widget.property.rating).toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(widget.property.city,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey)),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      '${NumberFormat.currency(locale: 'vi_VN').format(widget.property.pricePerNight)} / ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'night',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
