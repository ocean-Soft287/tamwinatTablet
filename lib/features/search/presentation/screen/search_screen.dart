import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_appp/features/search/presentation/screen/widget/search_by_name.dart';
import 'package:search_appp/features/search/presentation/screen/widget/search_item_card.dart';
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
  final TextEditingController _searchbyTextController = TextEditingController();

  String? barcode;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child:
 
           Scaffold(
            backgroundColor: Colors.white,
          
        
            body:
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {

                return SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SingleChildScrollView(
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
                                                                context.read<SearchCubit>()                         .getSearch(search: 'trimmedBarcode');
                              
                                       setState(() {
                                         _searchController.text = "الباركود غير صحيح";
                                       });
                                     }
                                  
                                 
                               },
                               controller: _searchController,
                                              
                               decoration: InputDecoration(
                               suffixIcon:_searchController.text.isNotEmpty?  IconButton(onPressed: (){
                                 _searchController.clear();
                                 setState(() {
                                   _searchController.text = "";
                                 });
                               }, icon: const Icon(Icons.close)):null,
                                
                                             
                                 hintText: ' ابحث بالباركود ',
                                 border: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(5.0),
                                 ),
                                 contentPadding:
                                     const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                               ),
                                              ),
                                                        SizedBox(height: 25.h,),
                                    SearchByName(controller: _searchbyTextController,),
                                         
                                 (state is SearchLoadingState) ?
                              Padding(
                                padding:  EdgeInsets.only(top:  MediaQuery.of(context).size.height/3),
                                child: const Center(child: CircularProgressIndicator(),),
                              ):
                                     
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: (BlocProvider.of<SearchCubit>(context)
                                           .searchDataList
                                           .isEmpty)
                                       ? const Padding(
                                         padding: EdgeInsets.only(top:  50),
                                         child: Text('لا يوجد نتائج'),
                                       ):
                                     
                                                        
                                                         ListView.builder(
                              shrinkWrap: true,
                              itemCount: BlocProvider.of<SearchCubit>(context)
                                           .searchDataList.length,
                              itemBuilder: (context, index) {
                                final product = BlocProvider.of<SearchCubit>(context)
                                           .searchDataList[index];
                                                       
                                return 
                                 SearchItemCard(product: product);
                                                        
                              },
                                                       )
                                        
                                 ),
                                                         
                               ],
                                              ),
                            ),
                          ),
                        );
          
              },
            ),
          )
      
    );
  }


}

