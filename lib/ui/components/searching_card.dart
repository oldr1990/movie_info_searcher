import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:movie_info_searcher/data/models/search_data.dart';
import 'package:movie_info_searcher/ui/theme.dart';

class SearchingCard extends StatefulWidget {
  const SearchingCard({Key? key}) : super(key: key);

  @override
  State<SearchingCard> createState() => _SearchingCardState();
}

class _SearchingCardState extends State<SearchingCard> {
  final _searchController = TextEditingController();
  final _yearController = TextEditingController();
  bool _validateYear = false;
  bool _validateSearch = false;
  TypeOfMovie _type = TypeOfMovie.all;

  @override
  void initState() {
    super.initState();
    _yearController.addListener(() {
      if(_yearController.text.length == 4) {
        setState( () => _validateYear = isYearNotValidated(_yearController.text) );
      } else {
        setState( () => _validateYear = false );
      }
    });
    _searchController.addListener(() {
      setState(() {
        _validateSearch = _searchController.text.contains(" ");
      });

    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Card(
        elevation: 8,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              buildSearchEditText(),
              spacer(),
              buildTypeChips(),
              buildYearRow(),
            ],
          ),
        ),
      );
  }

  Widget spacer(){
    return const SizedBox(width: 16, height: 16,);
  }

  Widget buildYearRow(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
             Expanded(
               child: Padding(
                 padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                 child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                      maxLines: 1,
                      maxLength: 4,
                      controller: _yearController,
                      decoration:  InputDecoration(
                        errorText: _validateYear ? "invalid" : null,
                        labelText: 'Year',
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      )
          ),
               ),
             ),
           spacer(),
           Padding(
             padding: const EdgeInsets.only(bottom: 16),
             child: TextButton(
              style:  ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black12)
              ),
              child: Text("Search",
              style: MovieInfoSercherTheme.darkTextTheme.headline2,),
              onPressed: () async {
                setState( () => _validateYear = isYearNotValidated(_yearController.text) );
              },
          ),
           ),

      ]
    );
  }

  Widget buildSearchEditText(){
    return Row(children: [
      Expanded(
        child: TextField(
          maxLines: 1,
          maxLength: 20,
          controller: _searchController,
          decoration:  InputDecoration(
            errorText: _validateSearch ? "invalid input" : null,
            labelText: 'Searching movie',
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          textInputAction: TextInputAction.next,
        ),
      ),
    ]);
  }

  Widget buildTypeChips() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
      ChoiceChip(
        selectedColor: Colors.black,
        selected: _type == TypeOfMovie.all,
        label: const Text(
          'all types',
          style: TextStyle(color: Colors.white),
        ),
        onSelected: (selected) {
          setState(() => _type = TypeOfMovie.all);
        },
      ),
      ChoiceChip(
        selectedColor: Colors.black,
        selected: _type == TypeOfMovie.movies,
        label: const Text(
          'movies',
          style: TextStyle(color: Colors.white),
        ),
        onSelected: (selected) {
          setState(() => _type = TypeOfMovie.movies);
        },
      ),
      ChoiceChip(
        selectedColor: Colors.black,
        selected: _type == TypeOfMovie.series,
        label: const Text(
          'series',
          style: TextStyle(color: Colors.white),
        ),
        onSelected: (selected) {
          setState(() => _type = TypeOfMovie.series);
        },
      ),
      ChoiceChip(
        selectedColor: Colors.black,
        selected: _type == TypeOfMovie.episode,
        label: const Text(
          'episode',
          style: TextStyle(color: Colors.white),
        ),
        onSelected: (selected) {
          setState(() => _type = TypeOfMovie.episode);
        },
      ),
    ],);
  }

  bool isYearNotValidated(String year){
    if (year.isEmpty) return false;
    int yearInt = int.parse(year);
    if ( yearInt < 1900) return true;
    if ( yearInt > DateTime.now().year) return true;
    return false;
  }
}