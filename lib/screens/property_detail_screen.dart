// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:pbl6_aircnc/blocs/host_bloc/host_bloc.dart';
import 'package:pbl6_aircnc/blocs/property_bloc/property_bloc.dart';
import 'package:pbl6_aircnc/blocs/wishlist_bloc/wishlist_bloc.dart';

import 'package:pbl6_aircnc/models/property.dart';
import 'package:pbl6_aircnc/screens/booking_detail_screen.dart';

class PropertyDetailScreen extends StatefulWidget {
  final int propertyId;

  PropertyDetailScreen({
    Key? key,
    required this.propertyId,
  }) : super(key: key);

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  final PropertyBloc propertyBloc = PropertyBloc();
  final WishlistBloc wishlistBloc = WishlistBloc();
  final HostBloc hostBloc = HostBloc();

  final controller = PageController();
  var currentPage = 0;
  bool isFavorite = true;
  late Property detailProperty;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    propertyBloc.add(LoadAllDetailPropertyEvent(propertyId: widget.propertyId));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<PropertyBloc, PropertyState>(
      bloc: propertyBloc,
      builder: (context, state) {
        if (state is LoadAllDetailPropertyState) {
          detailProperty = state.detailProperty;
          hostBloc.add(LoadDetailHostEvent(hostId: detailProperty.hostId));

          return Scaffold(
            bottomNavigationBar: SizedBox(
              height: 90,
              child: BottomAppBar(
                  child: Padding(
                padding: const EdgeInsets.only(top: 5, left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                  '${NumberFormat.currency(locale: 'vi_VN').format(detailProperty.pricePerNight)}',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                width: 5,
                              ),
                              Text('/night',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400))
                            ],
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              BookingDetailScreen(property: detailProperty),
                        ));
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 30),
                          decoration: BoxDecoration(
                              color: Colors.blue.shade500,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text(
                            'Reserve',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                    )
                  ],
                ),
              )),
            ),
            body: SingleChildScrollView(
                child: Column(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        width: size.width,
                        height: size.width - 50,
                        decoration: BoxDecoration(
                            // borderRadius: BorderRadius.only(
                            //     topLeft: Radius.circular(16),
                            //     topRight: Radius.circular(16)),
                            ),
                        child: PageView(
                          controller: controller,
                          onPageChanged: (value) {
                            setState(() {
                              currentPage = value;
                            });
                          },
                          children:
                              state.detailProperty.propertyImages.map((items) {
                            var imageUrl = items.url;
                            return CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.cover,
                              errorWidget: (context, error, stackTrace) {
                                return Image(
                                  image: AssetImage(
                                      "assets/images/image_not_found.jpg"),
                                  fit: BoxFit.cover,
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
                        dotsCount: state.detailProperty.propertyImages.length,
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
                        top: 40,
                        left: 20,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.blue.shade400,
                              borderRadius: BorderRadius.circular(20)),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset(
                              'assets/images/back-2.png',
                              height: 17,
                            ),
                          ),
                        )),
                    Positioned(
                        top: 40,
                        right: 20,
                        child: BlocBuilder<WishlistBloc, WishlistState>(
                          builder: (context, state) {
                            return IconButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('Success'),
                                    backgroundColor: Colors.green,
                                  ));
                                  wishlistBloc.add(ClickToLikeOrDislikeEvent(
                                      property: detailProperty));
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
                        )),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${detailProperty.title}',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Color.fromRGBO(254, 178, 7, 5),
                            size: 15,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${(detailProperty.rating).toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            '${detailProperty.numberOfReviews} reviews',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          ImageIcon(
                            AssetImage('assets/images/location-pin.png'),
                            size: 15,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                              '${detailProperty.address} - ${detailProperty.city}',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w400))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      BlocBuilder<HostBloc, HostState>(
                        bloc: hostBloc,
                        builder: (context, state) {
                          if (state is LoadDetailHostState) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ListTile(
                                            leading: Icon(
                                              FontAwesome.note_sticky,
                                              size: 20,
                                              color: Colors.purple,
                                            ),
                                            title: Text(
                                                'Reviews: ${state.host.numberOfReviews}',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                          ListTile(
                                            leading: Icon(
                                              Icons.star,
                                              size: 20,
                                              color: Color.fromRGBO(
                                                  254, 178, 7, 5),
                                            ),
                                            title: Text(
                                                'Rating: ${(state.host.rating).toStringAsFixed(2)}',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Joining date at:',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                '${DateFormat('dd/MM/yyyy').format(state.host.joinedAt)}',
                                                style: TextStyle(fontSize: 18),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          width: 80,
                                          height: 80,
                                          child: Expanded(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: state.host.avatarUrl !=
                                                      null
                                                  ? CachedNetworkImage(
                                                      imageUrl: state
                                                          .host.avatarUrl
                                                          .toString(),
                                                      fit: BoxFit.cover,
                                                      errorWidget: (context,
                                                          error, stackTrace) {
                                                        return Image(
                                                          image: AssetImage(
                                                              "assets/images/image_not_found.jpg"),
                                                          fit: BoxFit.scaleDown,
                                                        );
                                                      },
                                                    )
                                                  : Text(
                                                      '${state.host.name[0].toUpperCase()}',
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '${state.host.name}',
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.blue.shade700,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          softWrap: true,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Basic Offers',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade900,
                                    fontSize: 18)),
                            SizedBox(
                              height: 10,
                            ),
                            ListTileBasicOffer(
                              icon: FontAwesome.bath,
                              title: 'Number of bathrooms',
                              subCountInfo: '3 rooms',
                            ),
                            ListTileBasicOffer(
                              icon: FontAwesome.bed,
                              title: 'Number of bedrooms',
                              subCountInfo: '1 rooms',
                            ),
                            ListTileBasicOffer(
                              icon: FontAwesome.person,
                              title: 'Max persons',
                              subCountInfo: '3 persons',
                            ),
                            ListTileBasicOffer(
                              icon: FontAwesome.note_sticky,
                              title: 'Number of reviews',
                              subCountInfo: '4',
                              color: Colors.purple,
                            ),
                            ListTileBasicOffer(
                              icon: Icons.star,
                              title: 'Rating',
                              subCountInfo: '3',
                              color: Color.fromRGBO(254, 178, 7, 5),
                            ),
                            // description
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Description',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue.shade900,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${detailProperty.description}',
                                  textAlign: TextAlign.justify,
                                  softWrap: true,
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      fontSize: 16,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w300),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Some offers may be availabe for you",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue.shade900,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.wifi,
                                    size: 20,
                                    color: Colors.blue,
                                  ),
                                  title: Text('Wifi',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Reviews",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue.shade900,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
          );
        }
        return Center();
      },
    );
  }
}

class ListTileBasicOffer extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subCountInfo;
  Color? color;

  ListTileBasicOffer({
    Key? key,
    required this.icon,
    required this.title,
    required this.subCountInfo,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 20,
        color: color != null ? color : Colors.blue,
      ),
      title: Text(title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
      subtitle: Text(subCountInfo,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
    );
  }
}
