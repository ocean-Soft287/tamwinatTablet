import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_appp/features/search/presentation/screen/widget/text_field.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import '../cubit/search_cubit.dart';
import '../cubit/search_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  String? barcode;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: Padding(
                padding: const EdgeInsets.all(12.0),
                child:
                 TextFormField(
                  onTap: () async{
                        barcode = await SimpleBarcodeScanner.scanBarcode(
                          context,
                          barcodeAppBar: const BarcodeAppBar(
                            appBarTitle: 'Test',
                            centerTitle: false,
                            enableBackButton: true,
                            backButtonIcon: Icon(Icons.arrow_back_ios),
                          ),
                          isShowFlashIcon: true,
                          delayMillis: 500,
                          cameraFace: CameraFace.back,
                          scanFormat: ScanFormat.ONLY_BARCODE,
                        );
                        setState(() {
                          _searchController.text = barcode ?? "";
                        });

                        if (barcode != '-1' && barcode != null && mounted) {
                          setState(() {
                            _searchController.text = barcode!;
                          });
                          String trimmedBarcode = barcode!.trim();

                         context.read<SearchCubit>()                         .getSearch(search: trimmedBarcode);
                       
                        } else {
                          setState(() {
                            _searchController.text = "الباركود غير صحيح";
                          });
                        }
                     
                    
                  },
                  controller: _searchController,
                  onChanged: (text) {
                    Timer(const Duration (seconds: 1), (){
                        context.read<SearchCubit>() .getSearch(search: text);
                       
                    });
                  },
                
                  decoration: InputDecoration(
                  suffixIcon:_searchController.text.isNotEmpty?  IconButton(onPressed: (){
                    _searchController.clear();
                    setState(() {
                      _searchController.text = "";
                    });
                  }, icon: const Icon(Icons.close)):null,
                   
               
                    hintText: 'ابحث عن المنتج',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                  ),
                ),
           
              ),
              leading: InkWell(
                  onTap: () {
                
                  Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back_ios, color: Colors.black)),
          
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: (BlocProvider.of<SearchCubit>(context)
                            .searchDataList
                            .isEmpty)
                        ? Container()
                        : (state is SearchSuccessState)
                            ? Column(
                                children: [
                                  Container(
                                      color: Colors.white,
                                      height: 150.h,
                                      width: MediaQuery.of(context).size.width,
                                      child: Image.network(
                                          BlocProvider.of<SearchCubit>(context)
                                                  .searchDataList[0]
                                              ['ProductcImage'])),
                                  ItemCard(
                                    labelText: 'اسم الصنف/Item Name',
                                    text:
                                        '${BlocProvider.of<SearchCubit>(context).searchDataList[0]['ProductArName']}',
                                  ),
                                  ItemCard(
                                    text:
                                        '${BlocProvider.of<SearchCubit>(context).searchDataList[0]['ProductEnName']}',
                                  ),
                                  ItemCard(
                                    text:
                                        '${BlocProvider.of<SearchCubit>(context).searchDataList[0]['ProductCode']}',
                                    labelText: 'Item code ',
                                  ),
                                  ItemCard(
                                    text:
                                        '${BlocProvider.of<SearchCubit>(context).searchDataList[0]['BarCode']}',
                                    labelText: 'Item Barcode',
                                  ),
                                  ItemCard(
                                    text:
                                        '${BlocProvider.of<SearchCubit>(context).searchDataList[0]['StockQuantity']}',
                                    labelText: 'كميه الصنف/Item OTY',
                                  ),
                                  ItemCard(
                                    text:
                                        '${BlocProvider.of<SearchCubit>(context).searchDataList[0]['Price']}',
                                    labelText: 'Price/السعر',
                                  ),
                                ],
                              )
                            : Container(),
                  ),
                  // InkWell(
                  //   onTap: (){
                  //
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => SummiScan()),
                  //     );
                  //
                  //   },
                  //   child: Container(color: Colors.green,
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Text('test',style: TextStyle(
                  //         color: Colors.white
                  //       )),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
