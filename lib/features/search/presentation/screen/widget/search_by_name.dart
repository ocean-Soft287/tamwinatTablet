import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_appp/features/search/presentation/cubit/search_cubit.dart';

class SearchByName extends StatefulWidget {
 final  TextEditingController controller;
 final String title;
  const SearchByName({super.key,required this.controller,required this.title});

  @override
  State<SearchByName> createState() => _SearchByNameState();
}

class _SearchByNameState extends State<SearchByName> {
  @override
  Widget build(BuildContext context) {
    return searchByName(context,widget. controller);
  }

  TextFormField searchByName(BuildContext context,TextEditingController controller) {
    return TextFormField(
                                                      
                             controller: controller,
                             onChanged: (text) {
                               Timer(const Duration (seconds: 1), (){
                                   context.read<SearchCubit>() .getSearch(search: text);
                                  
                               });
                             },
                                            
                             decoration: InputDecoration(
                             suffixIcon:controller.text.isNotEmpty?  IconButton(onPressed: (){
                               controller.clear();
                               setState(() {
                                 controller.text = "";
                               });
                             }, icon: const Icon(Icons.close)):null,
                              
                                           
                               hintText:widget. title,
                               border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(5.0),
                               ),
                               contentPadding:
                                   const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                             ),
                                            );
  }
}