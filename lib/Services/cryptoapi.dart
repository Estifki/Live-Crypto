import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  double currentconversionRate = 0.0;
  dynamic currencyName;
  Future fetchFromCryptoApi(var uri) async {
    var url = Uri.parse(uri);
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      try {
        currentconversionRate = jsonDecode(response.body)['rate'];
        currencyName = jsonDecode(response.body)["asset_id_quote"];
      } catch (e) {
        print(e);
      }
    }
  }
}
