import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_appp/features/search/presentation/screen/widget/search_by_name.dart';
import 'package:search_appp/features/search/presentation/screen/widget/search_item_card.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import '../cubit/search_cubit.dart';
import '../cubit/search_state.dart';

class SearchScreen extends StatefulWidget {
    final String keyword;
  const SearchScreen({super.key,required this.keyword});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _searchbyTextController = TextEditingController();

  String? barcode;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit()..getSearch(search: widget.keyword),
      child:
 
           Scaffold(
            backgroundColor: Colors.white,

            body:SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(children: [
                      InkWell(
                          onTap: (){

                            Navigator.pop(context);

                          },
                          child:Icon(Icons.arrow_back_ios,size: 20.sp,)
                      )

                    ],)
                    ,   SizedBox(height: 25.h,)
                    ,
                    //     TextFormField(
                    // onTap: () async{
                    //       barcode = await SimpleBarcodeScanner.scanBarcode(
                    //         context,
                    //         barcodeAppBar: const BarcodeAppBar(
                    //           appBarTitle: 'Test',
                    //           centerTitle: false,
                    //           enableBackButton: true,
                    //           backButtonIcon: Icon(Icons.arrow_back_ios),
                    //         ),
                    //         isShowFlashIcon: true,
                    //         delayMillis: 500,
                    //         cameraFace: CameraFace.back,
                    //         scanFormat: ScanFormat.ONLY_BARCODE,
                    //       );
                    //       setState(() {
                    //         _searchController.text = barcode ?? "";
                    //       });
                    //
                    //       if (barcode != '-1' && barcode != null && mounted) {
                    //         setState(() {
                    //           _searchController.text = barcode!;
                    //         });
                    //         String trimmedBarcode = barcode!.trim();
                    //
                    //        context.read<SearchCubit>()                         .getSearch(search: trimmedBarcode);
                    //
                    //       } else {
                    //                                  context.read<SearchCubit>()                         .getSearch(search: 'trimmedBarcode');
                    //
                    //         setState(() {
                    //           _searchController.text = 'invalidBarcode'.tr();
                    //         });
                    //       }
                    //
                    //
                    // },
                    // controller: _searchController,
                    //
                    // decoration: InputDecoration(
                    // suffixIcon:_searchController.text.isNotEmpty?  IconButton(onPressed: (){
                    //   _searchController.clear();
                    //   setState(() {
                    //     _searchController.text = "";
                    //   });
                    // }, icon: const Icon(Icons.close)):null,
                    //
                    //
                    //   hintText:'searchByBarcode'.tr(),
                    //   border: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(5.0),
                    //   ),
                    //   contentPadding:
                    //       const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                    // ),
                    //                ),
                    //                          SizedBox(height: 25.h,),
                  //  SearchByName(controller: _searchbyTextController,title: 'search_by_name'.tr(),),
                  SearchByName(controller: _searchbyTextController, title: 'search_by_name'.tr()), BlocBuilder<SearchCubit, SearchState>(
                      builder: (context, state) {
                      if  (state is SearchLoadingState) {
                        return   Padding(
                          padding:  EdgeInsets.only(top:  MediaQuery.of(context).size.height/3),
                          child: const Center(child: CircularProgressIndicator(),),
                        );
                      }

                        return  (BlocProvider.of<SearchCubit>(context)
                            .searchDataList
                            .isEmpty)
                            ?  Padding(
                          padding: const EdgeInsets.only(top:  50),
                          child: Text('noResultsFound'.tr()),
                        ):


                        Expanded(
                          child: ListView.builder(
                            //  shrinkWrap: true,
                            itemCount: BlocProvider.of<SearchCubit>(context)
                                .searchDataList.length,
                            itemBuilder: (context, index) {
                              final product = BlocProvider.of<SearchCubit>(context)
                                  .searchDataList[index];

                              return
                                SearchItemCard(product: product);

                            },
                          ),
                        );





                      },
                    ),



                  ],
                ),
              ),
            )));




  }


}

