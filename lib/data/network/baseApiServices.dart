abstract class BaseApiServices {

  Future<dynamic> getGetApiResponse(String url);

  Future<dynamic> getGetApiResponseWithHeader(String uri,dynamic header);

  Future<dynamic> getPostApiResponse(String url,dynamic data);

  Future<dynamic> postAPIWithHeader(String url, {dynamic data, dynamic header});

  Future<dynamic> getPatchApiResponseHeader(String url, dynamic data, dynamic header);

  Future<dynamic>getDeleteApiResponseHeader ( String url,dynamic header);



}