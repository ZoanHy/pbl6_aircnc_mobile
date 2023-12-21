import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pbl6_aircnc/models/property.dart';

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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
              //  padding: const EdgeInsets.all(15.0),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  width: size.width,
                  height: size.width - 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
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
                            fit: BoxFit.scaleDown,
                          );
                        },
                      );
                    }).toList(),
                  ),
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
                        child: Text(
                          '${widget.property.title}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          Text(
                              '${(widget.property.rating as double).toStringAsFixed(2)}')
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '${NumberFormat.currency(locale: 'vi_VN', symbol: 'vnd').format(widget.property.pricePerNight)}/night',
                      style: TextStyle(fontSize: 14),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: widget.property.isFavorite
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : Icon(
                                Icons.favorite_border_outlined,
                                color: Colors.red,
                              ))
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
