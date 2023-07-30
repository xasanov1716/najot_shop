import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../data/models/categories_data_model.dart';
import '../data/models/data_check_error.dart';
import '../data/models/products_data_model.dart';
import '../data/models/universal_data.dart';

class ApiProvider {
  static Future<UniversalData> allCategories() async {
    Uri uri = Uri.parse("https://imtixon.free.mockoapp.net/categories");
    try {
      http.Response response = await http.get(uri);
      if (response.statusCode == HttpStatus.ok) {
        return UniversalData(statusCode: 200,
          data: (jsonDecode(response.body) as List?)
                  ?.map((e) => CategoriesDataModel.fromJson(e)).toList() ?? [],
        );
      }
      return checkErrors(response);
    } on SocketException {
      return UniversalData(error: "Internet yo'q");
    } on FormatException {
      return UniversalData(error: "Format Error!");
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  static Future<UniversalData> productById(int id) async {
    Uri uri = Uri.parse("https://imtixon.free.mockoapp.net/categories/$id");

    try {
      http.Response response = await http.get(uri);

      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> json = jsonDecode(response.body);
        List<ProductsDataModel> category = json.map((e) => ProductsDataModel.fromJson(e)).toList();

        return UniversalData(
            data: category);
      }
      return checkErrors(response);
    } on SocketException {
      return UniversalData(error: "Internet yo'q");
    } on FormatException {
      return UniversalData(error: "Format Error!");
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  static Future<UniversalData> allProduct() async {
    Uri uri = Uri.parse("https://imtixon.free.mockoapp.net/products");
    try {
      http.Response response = await http.get(uri);
      if (response.statusCode == HttpStatus.ok) {
        return UniversalData(statusCode: 200,
          data: (jsonDecode(response.body)["data"] as List?)
              ?.map((e) => ProductsDataModel.fromJson(e)).toList() ?? [],
        );
      }
      return checkErrors(response);
    } on SocketException {
      return UniversalData(error: "Internet yo'q");
    } on FormatException {
      return UniversalData(error: "Format xato!");
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }
}
