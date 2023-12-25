import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:pbl6_aircnc/models/property.dart';
import 'package:pbl6_aircnc/repositories/property_repo.dart';
import 'package:pbl6_aircnc/widgets/property_card.dart';

class DemoNumberPaginiation extends StatefulWidget {
  const DemoNumberPaginiation({super.key});

  @override
  State<DemoNumberPaginiation> createState() => _DemoNumberPaginiationState();
}

class _DemoNumberPaginiationState extends State<DemoNumberPaginiation> {
  int numberOfPages = 0;
  int currentPage = 0;
  List<List<Property>> totalPagesProperty = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNumberOfPages();
  }

  Future<void> getNumberOfPages() async {
    List<List<Property>> totalPagesPropertyApi =
        await PropertyRepo.getAllPagesProperty();

    setState(() {
      numberOfPages = totalPagesPropertyApi.length;
      totalPagesProperty = totalPagesPropertyApi;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(numberOfPages);
    var pages;
    if (numberOfPages != 0) {
      pages = List.generate(
          numberOfPages,
          (idxPage) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: totalPagesProperty[idxPage].length,
                  itemBuilder: (context, idxItem) {
                    List<Property> properties = totalPagesProperty[idxPage];
                    final property = properties[idxItem];
                    return PropertyCard(property: property);
                  },
                ),
              ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Demo Pagination'),
      ),
      body: numberOfPages != 0
          ? Padding(
              padding: const EdgeInsets.only(bottom: 10),
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
            )
          : Center(),
    );
  }
}
