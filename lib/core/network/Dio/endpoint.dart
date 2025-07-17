class Endpoint {
  static String baseUrl ='http://37.34.242.173:9292/TheOneAPI/'; // TheOneAPITest //TheOneAPI // "http://51.91.6.70/TheOneApiElfarC/"; // "http://51.91.6.70/TheOneApiElfarM/";
    static String subBaseUrl = 'api/Order/';
  static String getAllNotPRintedOrders = '${subBaseUrl}GetAllNotPRintedOrders';
  static String getAllOrders = '${subBaseUrl}GetAllOrders';
  static String updateOrderStateByOrderNo({required String id}) =>
      '${subBaseUrl}UpdateOrderState?orderNo=$id';
  static String search({required String search}) => 'api/Product/SearchProductByBarcode?Barcode=$search';
  static String searchbykeyword ({required String searchKey})=>
      "${baseUrl}api/Product/SearchProducts?searchKey=$searchKey";

  static String addToken({required String id}) =>
      '${baseUrl}api/Tokens/AddToken?token=$id';
  static String upadteOrderState({required String orderNo, required String orderType }) =>
      '${baseUrl}api/Order/UpdateInvoiceState?orderNo=$orderNo&orderType=$orderType';


}

