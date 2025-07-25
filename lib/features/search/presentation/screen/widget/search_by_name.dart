import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:search_appp/features/search/presentation/cubit/search_cubit.dart';

class SearchByName extends StatefulWidget {
  final TextEditingController controller;
  final void Function( String text) callback;
  final String title;

  const SearchByName({
    Key? key,
    required this.callback,
    required this.controller,
    required this.title,
  }) : super(key: key);

  @override
  State<SearchByName> createState() => _SearchByNameState();
}

class _SearchByNameState extends State<SearchByName> {
  Timer? _debounce;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  void _listenControllers(){


    // Listen to _searchController
    WidgetsBinding.instance.addPostFrameCallback((_) {

     widget. controller.addListener(() {
        if ( widget. controller.text.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
            widget. controller.text,style: TextStyle(color: Colors.white),)));
          context.read<SearchCubit>().getSearch(search:  widget. controller.text);
        }
      });
    });

  }


  @override
  void dispose() {
    _debounce?.cancel(); // Cancel the timer if it's still active
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _buildSearchField(context, widget.controller),
    );
  }

  Widget _buildSearchField(BuildContext context, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      onTap: () {
        controller.clear();
        setState(() {});
      },
      onChanged: (text) {
        // Cancel any previous debounce timer
        if (_debounce?.isActive ?? false) _debounce!.cancel();

        // Start a new debounce timer
        _debounce = Timer(const Duration(milliseconds: 400), () {
       //  widget.callback( text);
                    context.read<SearchCubit>().getSearch(search: text);
        });

        setState(() {});
      },
      decoration: InputDecoration(
        hintText: widget.title.tr(), // If using EasyLocalization
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            controller.clear();
            setState(() {});
          },
        )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      ),
    );
  }
}
