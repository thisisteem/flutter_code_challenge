import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_code_challenge/components/skeleton_container.dart';
import 'package:flutter_code_challenge/screens/beer_detail.dart';
import 'package:http/http.dart' as http;
import '../functions/ebc_to_color_code.dart';
import '../utils/favorite_beer_preferences.dart';
import '/models/beer_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyFavorite extends StatefulWidget {
  const MyFavorite({Key? key}) : super(key: key);

  @override
  _MyFavoriteState createState() => _MyFavoriteState();
}

class _MyFavoriteState extends State<MyFavorite> with TickerProviderStateMixin {
  late final Future<List<BeerModel>> _getBeerFuture = getBeers();
  late List<BeerModel> _allBeers = [];
  late List<BeerModel> _favoriteBeers = [];
  bool _showBackToTopButton = false;
  String sortDropdownValue = 'Beer color';

  late AnimationController _controller;
  late ScrollController _scrollController;

  Future<List<BeerModel>> getBeers() async {
    const url = 'https://api.punkapi.com/v2/beers';
    final response = await http.get(Uri.parse(url));
    var favoriteBeerList = FavoriteBeerPreferences.getFavorite();

    List<dynamic> data = jsonDecode(response.body);
    _allBeers = data.map((data) => BeerModel.fromJson(data)).toList();

    for (var beer in _allBeers) {
      if (favoriteBeerList.contains(beer.id.toString())) {
        beer.isFavorite = true;
        _favoriteBeers.add(beer);
      }
    }

    _sortFilter();

    return _favoriteBeers;
  }

  void _sortFilter() {
    _favoriteBeers.sort((a, b) {
      int result;
      if (a.ebc == null) {
        result = 1;
      } else if (b.ebc == null) {
        result = 2;
      } else {
        return a.ebc!.compareTo(b.ebc!);
      }
      return result;
    });
  }

  void _onPressedFavorite(bool isFavorite, int id) async {
    if (isFavorite) {
      await FavoriteBeerPreferences.removeFromFavorite(id.toString());
    } else {
      await FavoriteBeerPreferences.addToFavorite(id.toString());
    }
  }

  void _reloadPage() {
    setState(() {});
  }

  void _dismissKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 400), curve: Curves.linear);
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      upperBound: 0.5,
    );

    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 300) {
            _showBackToTopButton = true;
          } else {
            _showBackToTopButton = false;
          }
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanDown: (_) {
        _dismissKeyboard();
      },
      onTap: () {
        _dismissKeyboard();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: _showBackToTopButton == false
            ? null
            : FloatingActionButton(
                onPressed: _scrollToTop,
                child: const Icon(Icons.arrow_upward),
              ),
        body: SafeArea(
          child: FutureBuilder(
            future: _getBeerFuture,
            builder: (context, AsyncSnapshot<List<BeerModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _buildSkeleton();
              } else if (snapshot.hasError) {
                return Text('😔 ${snapshot.error}');
              } else if (snapshot.hasData) {
                final data = snapshot.data;
                _allBeers = data!;
                return Column(
                  children: [
                    _buildResult(),
                  ],
                );
              } else {
                return const Text('NONE');
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBeer(BeerModel beer) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      height: MediaQuery.of(context).size.height * 0.22,
      child: Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: InkWell(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BeerDetail(
                  beer: beer,
                  update: _reloadPage,
                  onPressedFavorite: _onPressedFavorite,
                ),
              ),
            ),
            _dismissKeyboard(),
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: ebcToColorCode(beer.ebc), width: 16),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: CachedNetworkImage(
                    height: 130,
                    imageUrl: beer.imageUrl!,
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    splashColor: Colors.transparent,
                                    splashRadius: 1,
                                    onPressed: () async {
                                      _dismissKeyboard();
                                      _onPressedFavorite(
                                          beer.isFavorite, beer.id);
                                      setState(() {
                                        beer.isFavorite = !beer.isFavorite;
                                      });
                                    },
                                    icon: Icon(
                                      beer.isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
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
                                  .labelMedium!
                                  .copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              beer.abv != null
                                  ? 'ABV: ${beer.abv} %'
                                  : 'ABV: -',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: sortDropdownValue == 'ABV'
                                  ? Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.black87)
                                  : Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(color: Colors.black87),
                            ),
                            Text(
                              beer.ibu != null ? 'IBU: ${beer.ibu}' : 'IBU: -',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: sortDropdownValue == 'IBU'
                                  ? Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.black87)
                                  : Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(color: Colors.black87),
                            ),
                            Text(
                              beer.ph != null ? 'pH: ${beer.ph}' : 'pH: -',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: sortDropdownValue == 'pH'
                                  ? Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.black87)
                                  : Theme.of(context)
                                      .textTheme
                                      .labelMedium!
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

  Widget _buildResult() {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _favoriteBeers.length,
        itemBuilder: (context, index) {
          BeerModel beer = _favoriteBeers[index];
          return _buildBeer(beer);
        },
      ),
    );
  }

  Widget _buildSkeleton() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
          // height: MediaQuery.of(context).size.height * 0.22,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SkeletonContainer.square(
                width: 100,
                height: 100,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SkeletonContainer.square(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 16,
                  ),
                  const SizedBox(height: 8),
                  SkeletonContainer.square(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 12,
                  ),
                  const SizedBox(height: 30),
                  SkeletonContainer.square(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: 6,
                  ),
                  const SizedBox(height: 8),
                  SkeletonContainer.square(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: 6,
                  ),
                  const SizedBox(height: 8),
                  SkeletonContainer.square(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: 6,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
