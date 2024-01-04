// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';

import 'package:pbl6_aircnc/models/host.dart';

import './constants.dart';
import 'book_flip.dart';
import 'host_card_page_description.dart';

class HostCardBook extends StatefulWidget {
  final Host hostInfoDetail;

  const HostCardBook({
    Key? key,
    required this.hostInfoDetail,
  }) : super(key: key);

  @override
  State<HostCardBook> createState() => _HostCardBookState();
}

class _HostCardBookState extends State<HostCardBook>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _curvedAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 1),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 150,
                  child: GestureDetector(
                    onTapDown: (_) {
                      _animationController.animateTo(0.33);
                    },
                    onTapUp: (_) {
                      _animationController.animateTo(0).then((value) {
                        _openListingPage(context);
                      });
                    },
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 25,
                          left: 25,
                          right: 0,
                          child: Hero(
                            tag: 'listing_hero_${widget.hostInfoDetail.id}',
                            flightShuttleBuilder: (
                              BuildContext flightContext,
                              Animation<double> animation,
                              HeroFlightDirection flightDirection,
                              BuildContext fromHeroContext,
                              BuildContext toHeroContext,
                            ) {
                              final curvedAnimation = CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeInOut,
                              );
                              final scaleAnimation = Tween<double>(
                                begin: Constants.bookInitialScale,
                                end: 1,
                              ).animate(curvedAnimation);

                              return ScaleTransition(
                                scale: scaleAnimation,
                                alignment: Alignment.bottomLeft,
                                child: BookFlip(
                                  widget.hostInfoDetail,
                                  animationController: curvedAnimation,
                                ),
                              );
                            },
                            child: Transform.scale(
                              scale: Constants.bookInitialScale,
                              alignment: Alignment.bottomLeft,
                              child: BookFlip(
                                widget.hostInfoDetail,
                                animationController: _curvedAnimation,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          child: ListTile(
                            leading: Icon(
                              FontAwesome.note_sticky,
                              color: Colors.purple,
                            ),
                            title: Text(
                                'Reviews: ${widget.hostInfoDetail.numberOfReviews}',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500)),
                          ),
                          right: 0,
                          top: 10,
                          left: 150,
                        ),
                        Positioned(
                          child: ListTile(
                            leading: Icon(
                              Icons.star,
                              size: 20,
                              color: Color.fromRGBO(254, 178, 7, 5),
                            ),
                            title: Text(
                                'Rating: ${(widget.hostInfoDetail.rating).toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500)),
                          ),
                          right: 0,
                          top: 50,
                          left: 150,
                        ),
                        Positioned(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Joining date at:',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  '${DateFormat('dd/MM/yyyy').format(widget.hostInfoDetail.joinedAt)}',
                                  style: TextStyle(fontSize: 18),
                                ),
                              )
                            ],
                          ),
                          right: 0,
                          top: 100,
                          left: 170,
                        )
                      ],
                    ),
                  ),
                ),
                Text(
                  '${widget.hostInfoDetail.name}',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                  softWrap: true,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openListingPage(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Constants.animationDuration,
        reverseTransitionDuration: Constants.animationDuration,
        pageBuilder: (BuildContext context, Animation<double> animation, _) {
          return ListingPage(widget.hostInfoDetail);
        },
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            _, Widget child) {
          final offsetAnimation = Tween<Offset>(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
          );

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        opaque: false,
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
      ),
    );
  }
}
