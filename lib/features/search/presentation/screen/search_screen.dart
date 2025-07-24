import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_appp/features/search/presentation/screen/widget/search_by_barcode.dart';
import 'package:search_appp/features/search/presentation/screen/widget/search_by_name.dart';
import 'package:search_appp/features/search/presentation/screen/widget/search_item_card.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sunmi_scanner/sunmi_scanner.dart';
import '../cubit/search_cubit.dart';
import '../cubit/search_state.dart';

class SearchScreen extends StatefulWidget {
    final String keyword;
  const SearchScreen({super.key,required this.keyword});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchbarcodeSacannerController = TextEditingController();

  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _searchbyTextController = TextEditingController();

  String? barcode;
  @override
  void initState() {
    _listenControllers();
    super.initState();
  }

  void _listenControllers(){


    // Listen to _searchController
    WidgetsBinding.instance.addPostFrameCallback((_) {

      _searchController.addListener(() {
      if (_searchController.text.isNotEmpty) {
        Fluttertoast.showToast(
          msg: _searchbyTextController.text,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.yellow,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        context.read<SearchCubit>().getSearch(search: _searchController.text);
      }
    });
    });

  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit()..getSearch(search: widget.keyword),
      child:

           Scaffold(
            backgroundColor: Colors.white,
appBar: AppBar(
  elevation: 0,
  backgroundColor: Colors.white,
  leading: InkWell(
                  onTap: () {
                    SunmiScanner.onBarcodeScanned().listen((scannedValue) {
                      BlocProvider.of<SearchCubit>(context)
                          .getSearch(search: scannedValue);
                    });
                  },
                  child: const Icon(Icons.camera, color: Colors.black)),
  title:    SearchByName(controller: _searchController, title: 'search_by_name'.tr(), callback: (String text) {
                  context.read<SearchCubit>().getSearch(search: _searchController.text);
                },)
             ,

            ),


            body:Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
        
                        BlocBuilder<SearchCubit, SearchState>(
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
            )));




  }


}

// import 'dart:async';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:search_appp/features/search/presentation/screen/widget/text_field.dart';
// import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
// import 'package:sunmi_scanner/sunmi_scanner.dart';
// import '../cubit/search_cubit.dart';
// import '../cubit/search_state.dart';

// class SearchScreen extends StatefulWidget {
//   SearchScreen({super.key});

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController _searchController = TextEditingController();

//   String? barcode;

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => SearchCubit(),
//       child: BlocConsumer<SearchCubit, SearchState>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           return Scaffold(
//             backgroundColor: Colors.white,
//             appBar: AppBar(
//               backgroundColor: Colors.white,
//               elevation: 0.0,
//               title: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   onTap: () async{
                        


//                         barcode = await SimpleBarcodeScanner.scanBarcode(
//                           context,
//                           barcodeAppBar: const BarcodeAppBar(
//                             appBarTitle: 'Test',
//                             centerTitle: false,
//                             enableBackButton: true,
//                             backButtonIcon: Icon(Icons.arrow_back_ios),
//                           ),
//                           isShowFlashIcon: true,
//                           delayMillis: 500,
//                           cameraFace: CameraFace.back,
//                           scanFormat: ScanFormat.ONLY_BARCODE,
//                         );
//                         setState(() {
//                           _searchController.text = barcode ?? "";
//                         });

//                         if (barcode != '-1' && barcode != null && mounted) {
//                           setState(() {
//                             _searchController.text = barcode!;
//                           });
//                           String trimmedBarcode = barcode!.trim();

//                          context.read<SearchCubit>()                         .getSearch(search: trimmedBarcode);
                       
//                         }
                     
                    
//                   },
//                   controller: _searchController,
//                   onChanged: (text) {
//                     Timer(const Duration (seconds: 1), (){
//                         context.read<SearchCubit>() .getSearch(search: text);
                       
//                     });
//                   },
//                   decoration: InputDecoration(
//                     suffixIcon: IconButton(
//                       onPressed:
//                        () async
//                         {


//                         barcode = await SimpleBarcodeScanner.scanBarcode(
//                           context,
//                           barcodeAppBar: const BarcodeAppBar(
//                             appBarTitle: 'Test',
//                             centerTitle: false,
//                             enableBackButton: true,
//                             backButtonIcon: Icon(Icons.arrow_back_ios),
//                           ),
//                           isShowFlashIcon: true,
//                           delayMillis: 500,
//                           cameraFace: CameraFace.back,
//                           scanFormat: ScanFormat.ONLY_BARCODE,
//                         );
//                         setState(() {
//                           _searchController.text = barcode ?? "";
//                         });

//                         if (barcode != '-1' && barcode != null && mounted) {
//                           setState(() {
//                             _searchController.text = barcode!;
//                           });
//                           String trimmedBarcode = barcode!.trim();

//                          context.read<SearchCubit>()                         .getSearch(search: trimmedBarcode);
                       
//                         }
//                       },
                    
//                       icon: const Icon(Icons.camera_alt),
//                     ),
//                     hintText: '',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5.0),
//                     ),
//                     contentPadding:
//                         const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
//                   ),
//                 ),
//               ),
//               leading: InkWell(
//                   onTap: () {
//                     SunmiScanner.onBarcodeScanned().listen((scannedValue) {
//                       BlocProvider.of<SearchCubit>(context)
//                           .getSearch(search: scannedValue);
//                     });
//                   },
//                   child: const Icon(Icons.camera, color: Colors.black)),
//             ),
//             body: SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: (BlocProvider.of<SearchCubit>(context)
//                             .searchDataList
//                             .isEmpty)
//                         ? Container()
//                         : (state is SearchSuccessState)
//                             ? Column(
//                                 children: [
//                                   Container(
//                                       color: Colors.white,
//                                       height: 150.h,
//                                       width: MediaQuery.of(context).size.width,
//                                       child: Image.network(
//                                           BlocProvider.of<SearchCubit>(context)
//                                                   .searchDataList[0]
//                                             .productImage ??""
//                                               )),
//                                   ItemCard(
//                                     labelText: 'اسم الصنف/Item Name',
//                                     text:
//                                         '${BlocProvider.of<SearchCubit>(context).searchDataList[0].productArName}',
//                                   ),
//                                   ItemCard(
//                                     text:
//                                         '${BlocProvider.of<SearchCubit>(context).searchDataList[0].productEnName}',
//                                   ),
//                                   ItemCard(
//                                     text:
//                                         BlocProvider.of<SearchCubit>(context).searchDataList[0].productCode,
//                                     labelText: 'Item code ',
//                                   ),
//                                   ItemCard(
//                                     text:
//                                         '${BlocProvider.of<SearchCubit>(context).searchDataList[0].barCode } ',
//                                     labelText: 'Item Barcode',
//                                   ),
//                                   ItemCard(
//                                     text:
//                                         '${BlocProvider.of<SearchCubit>(context).searchDataList[0].stockQuantity } ',
//                                     labelText: 'كميه الصنف/Item OTY',
//                                   ),
//                                   ItemCard(
//                                     text:
//                                         '${BlocProvider.of<SearchCubit>(context).searchDataList[0].price}',
//                                     labelText: 'Price/السعر',
//                                   ),
//                                 ],
//                               )
//                             : Container(),
//                   ),
//                   // InkWell(
//                   //   onTap: (){
//                   //
//                   //     Navigator.push(
//                   //       context,
//                   //       MaterialPageRoute(builder: (context) => SummiScan()),
//                   //     );
//                   //
//                   //   },
//                   //   child: Container(color: Colors.green,
//                   //     child: Padding(
//                   //       padding: const EdgeInsets.all(8.0),
//                   //       child: Text('test',style: TextStyle(
//                   //         color: Colors.white
//                   //       )),
//                   //     ),
//                   //   ),
//                   // )
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }