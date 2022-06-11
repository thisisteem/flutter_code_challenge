import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_code_challenge/components/skeleton_container.dart';
import 'package:flutter_code_challenge/constants/colors.dart';
import 'package:flutter_code_challenge/screens/beer_detail.dart';
import 'package:http/http.dart' as http;
import '../functions/ebc_to_color_code.dart';
import '../models/food_chip_model.dart';
import '../utils/favorite_beer_preferences.dart';
import '/constants/texts.dart';
import '/models/beer_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BeerList extends StatefulWidget {
  const BeerList({Key? key}) : super(key: key);

  @override
  _BeerListState createState() => _BeerListState();
}

class _BeerListState extends State<BeerList> with TickerProviderStateMixin {
  late final Future<List<BeerModel>> _getBeerFuture = getBeers();
  late List<BeerModel> _allBeers = [];
  late List<BeerModel> _foundBeers = [];
  bool _isSortAscending = true;
  String sortDropdownValue = 'Beer color';
  final List<FoodChipModel> _foodsSuggestion = [
    FoodChipModel(label: 'Salad', icon: Icons.dinner_dining),
    FoodChipModel(label: 'Beef', icon: Icons.emoji_food_beverage),
    FoodChipModel(label: 'Chicken', icon: Icons.local_pizza),
    FoodChipModel(label: 'Fish', icon: Icons.fastfood),
    FoodChipModel(label: 'Burger', icon: Icons.cake),
  ];
  final List<String> _sortList = [
    'Beer color',
    'Name',
    'ABV',
    'IBU',
    'pH',
    'My Favorite'
  ];

  late AnimationController _controller;
  final _searchController = TextEditingController();

  Future<List<BeerModel>> getBeers() async {
    const url = 'https://api.punkapi.com/v2/beers';
    final response = await http.get(Uri.parse(url));
    var favoriteBeerList = FavoriteBeerPreferences.getFavorite();

    List<dynamic> data = jsonDecode(response.body);
    _allBeers = data.map((data) => BeerModel.fromJson(data)).toList();

    for (var beer in _allBeers) {
      if (favoriteBeerList.contains(beer.id.toString())) {
        beer.isFavorite = true;
      }
    }

    _foundBeers = _allBeers;

    _sortFilter();

    return _allBeers;
  }

  void _searchFilter(String enteredKeyword) {
    List<BeerModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allBeers;
    } else {
      results = _allBeers.where(
        (beer) {
          if (beer.name
              .toLowerCase()
              .contains(enteredKeyword.trim().toLowerCase())) {
            return true;
          } else if (beer.tagline
              .toLowerCase()
              .contains(enteredKeyword.trim().toLowerCase())) {
            return true;
          } else {
            beer.foodPairing.where(
                (food) => food.contains(enteredKeyword.trim().toLowerCase()));
          }
          return false;
        },
      ).toList();

      for (BeerModel beer in _allBeers) {
        for (var food in beer.foodPairing) {
          if (food
              .toLowerCase()
              .contains(enteredKeyword.trim().toLowerCase())) {
            results.add(beer);
          }
        }
      }
    }
    setState(() {
      _foundBeers = results;
    });
  }

  void _sortFilter() {
    _foundBeers.sort(
      (a, b) {
        int result;
        switch (sortDropdownValue) {
          case 'Name':
            result = _isSortAscending
                ? a.name.compareTo(b.name)
                : b.name.compareTo(a.name);
            return result;
          case 'ABV':
            if (a.abv == null) {
              result = 1;
            } else if (b.abv == null) {
              result = 2;
            } else {
              result = _isSortAscending
                  ? a.abv!.compareTo(b.abv!)
                  : b.abv!.compareTo(a.abv!);
            }
            return result;
          case 'IBU':
            if (a.ibu == null) {
              result = 1;
            } else if (b.ibu == null) {
              result = 2;
            } else {
              result = _isSortAscending
                  ? a.ibu!.compareTo(b.ibu!)
                  : b.ibu!.compareTo(a.ibu!);
            }
            return result;
          case 'pH':
            if (a.ph == null) {
              result = 1;
            } else if (b.ph == null) {
              result = 2;
            } else {
              result = _isSortAscending
                  ? a.ph!.compareTo(b.ph!)
                  : b.ph!.compareTo(a.ph!);
            }
            return result;
          case 'My Favorite':
            if (_isSortAscending) {
              if (b.isFavorite) {
                return 1;
              }
              return -1;
            } else {
              if (a.isFavorite) {
                return 1;
              }
              return -1;
            }
          default:
            // Beer Color
            if (a.ebc == null) {
              result = 1;
            } else if (b.ebc == null) {
              result = 2;
            } else {
              result = _isSortAscending
                  ? a.ebc!.compareTo(b.ebc!)
                  : b.ebc!.compareTo(a.ebc!);
            }
            return result;
        }
      },
    );
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

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      upperBound: 0.5,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
        appBar: AppBar(
          title: const Text(appTitle),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: colorPrimaryDefault,
                ),
                child: DropdownButton<String>(
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: Colors.white),
                  value: sortDropdownValue,
                  icon: const Icon(
                    Icons.filter_list,
                    color: Colors.white,
                  ),
                  underline: const SizedBox(height: 0),
                  elevation: 16,
                  onChanged: (String? newValue) {
                    setState(() {
                      sortDropdownValue = newValue!;
                      _sortFilter();
                    });
                  },
                  items:
                      _sortList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: Colors.white),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
        body: FutureBuilder(
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
                  _buildSearch(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Scrollbar(
                            isAlwaysShown: true,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: _foodsSuggestion
                                    .map(
                                      (food) => _buildChip(
                                        food.label,
                                        food.icon,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                        _buildSortDirection(),
                      ],
                    ),
                  ),
                  _buildResult(),
                ],
              );
            } else {
              return const Text('NONE');
            }
          },
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
                                onPressed: () async {
                                  _dismissKeyboard();
                                  _onPressedFavorite(beer.isFavorite, beer.id);
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
                              .copyWith(
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic),
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

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
      child: TextField(
        style: Theme.of(context).textTheme.headlineSmall,
        cursorColor: Colors.black12,
        onChanged: (value) => _searchFilter(value),
        textInputAction: TextInputAction.done,
        controller: _searchController,
        decoration: InputDecoration(
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: const Icon(
                Icons.clear,
                color: colorPrimaryDefault,
              ),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                _searchController.text = '';
                _searchFilter('');
              },
            ),
          ),
          suffixIconConstraints:
              const BoxConstraints(minWidth: 10, minHeight: 10),
          prefixIcon: const Icon(
            Icons.search,
            color: colorPrimaryDefault,
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: 'Search by name, tagline, food...',
          hintStyle: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.grey),
          contentPadding: const EdgeInsets.only(left: 14.0, right: 14),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: colorPrimaryDefault),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black26),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.redAccent),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.redAccent),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildSortDirection() {
    return RotationTransition(
      turns: Tween(begin: 1.0, end: 0.0).animate(_controller),
      child: IconButton(
        icon: const Icon(Icons.arrow_upward),
        onPressed: () {
          setState(() {
            if (_isSortAscending) {
              _controller.forward(from: 0.0);
            } else {
              _controller.reverse(from: 0.5);
            }
            _isSortAscending = !_isSortAscending;
            _sortFilter();
          });
        },
      ),
    );
  }

  Widget _buildResult() {
    return Expanded(
      child: ListView.builder(
        itemCount: _foundBeers.length,
        itemBuilder: (context, index) {
          BeerModel beer = _foundBeers[index];
          return _buildBeer(beer);
        },
      ),
    );
  }

  Widget _buildChip(String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: FilterChip(
        selectedColor: Colors.green,
        avatar: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Icon(
            icon,
            color: Colors.black87,
          ),
        ),
        label: Text(
          label,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Colors.black87,
              ),
        ),
        backgroundColor: Colors.transparent,
        shape: const StadiumBorder(
          side: BorderSide(color: colorPrimaryDefault, width: 1),
        ),
        pressElevation: 0,
        onSelected: (bool value) {
          _dismissKeyboard();
          _searchController.text = label;
          _searchController.selection = TextSelection.fromPosition(
              TextPosition(offset: _searchController.text.length));
          _searchFilter(label);
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
