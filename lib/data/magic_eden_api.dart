import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:nft_notify/main.dart';

Future<Map<String, dynamic>> getDataFromApi(String token) async {
  var url1 = Uri.https('api-mainnet.magiceden.dev', '/v2/tokens/$token');
  //var url1 = Uri.https('api-mainnet.magiceden.dev',
  //  '/v2/tokens/FGEtkLRmqrE4LNmWDcsUPvutAqjXQZ83VSGcAsPDnvvw');

  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(
    url1,
    // headers: {
    //   "Accept": "application/json",
    //   "Access-Control_Allow_Origin": "*"
    //}
  );
  print('response.statusCode');
  print(response.statusCode);
  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    var itemCount = jsonResponse['totalItems'];
    return jsonResponse;
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return {};
  }
}

Future<Map> getStatsPriceFromApi(String symbole) async {
  var url =
      Uri.https('api-mainnet.magiceden.dev', '/v2/collections/$symbole/stats');
  var response = await http.get(url);
   if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    var itemCount = jsonResponse['totalItems'];
    return jsonResponse;
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return {};
  }
}

Future<bool> isListedinApi(token) async {
  var url = Uri.https('/v2/collections/',
      '/v2/tokens/FGEtkLRmqrE4LNmWDcsUPvutAqjXQZ83VSGcAsPDnvvw/listings');
  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(
    url,
    // headers: {
    //   "Accept": "application/json",
    //   "Access-Control_Allow_Origin": "*"
    //}
  );
  print(response.statusCode);
  if (response.statusCode == 200 && response.body.isNotEmpty) {
    var jsonResponse =
        convert.jsonDecode(response.body)[0] as Map<String, dynamic>;
    var itemCount = jsonResponse['totalItems'];
    print('Correct100: $jsonResponse.');
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
  return true;
}
