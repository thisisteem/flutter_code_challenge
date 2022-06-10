import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '/constants/texts.dart';
import '/models/beer_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BeerList extends StatefulWidget {
  const BeerList({Key? key}) : super(key: key);

  @override
  _BeerListState createState() => _BeerListState();
}

class _BeerListState extends State<BeerList> {
  Future<List<BeerModel>> getBeers() async {
    const url = 'https://api.punkapi.com/v2/beers';
    final response = await http.get(Uri.parse(url));

    List<dynamic> data = jsonDecode(response.body);
    List<BeerModel> beers =
        data.map((data) => BeerModel.fromJson(data)).toList();
    return beers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      body: FutureBuilder(
        builder: (context, AsyncSnapshot<List<BeerModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('😔 ${snapshot.error}');
          } else if (snapshot.hasData) {
            final data = snapshot.data;
            return ListView.builder(
              itemCount: data!.length,
              itemBuilder: (context, index) {
                BeerModel beer = snapshot.data![index];
                return _buildBeer(beer);
              },
            );
          } else {
            return const Text('NONE');
          }
        },
        future: getBeers(),
      ),
    );
  }

  Widget _buildBeer(BeerModel beer) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 7, 16, 7),
      height: MediaQuery.of(context).size.height * 0.22,
      child: Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: InkWell(
          onTap: () => {},
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: Colors.green, width: 15),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: CachedNetworkImage(
                    height: 130,
                    imageUrl: beer.imageUrl,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                beer.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(color: Colors.black87),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                splashColor: Colors.transparent,
                                splashRadius: 1,
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.pinkAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          beer.tagline,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ABV: ${beer.abv}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(color: Colors.black87),
                            ),
                            Text(
                              'IBU: ${beer.ibu}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(color: Colors.black87),
                            ),
                            Text(
                              'pH: ${beer.ph}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(color: Colors.black87),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right_sharp,
                  color: Colors.grey,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
