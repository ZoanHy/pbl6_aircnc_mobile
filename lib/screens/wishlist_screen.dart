import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Wishlist')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 35.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Wishlists",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28.0,
                    color: Colors.black87,
                    letterSpacing: 1.2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Container(
                    height: 1.5,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                ),
                const Text(
                  "Log in to view your wishlists",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24.0,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                const Text(
                  "You can create, view, or edit wishlists once you're logged in",
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black87,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print('hello');
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.0),
                    child: SizedBox(
                      height: 55,
                      width: 125,
                      child: Card(
                        margin: EdgeInsets.all(0),
                        color: Colors.blue,
                        child: Center(
                          child: Text(
                            'Log in',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
