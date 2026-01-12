import 'dart:convert';
import 'dart:io';

import 'package:hostui/constants/app_strings.dart';
import 'package:http/http.dart' as http;

/// All API calls should be written here
/// Company-level clean structure
class ApiCalls {
  ApiCalls._(); // private constructor (no object creation)

  /// Base URL
  

  /// =========================
  /// SIGNUP API
  /// =========================
  static Future<Map<String, dynamic>> signupApi({
    required String username,
    required String useremail,
    required String phoneNumber,
    required String password,
    required String buildingStreet,
    required String area,
    required String city,
    required String state,
    required String country,
    required String pincode,
  }) async {
    try {
      final uri = Uri.parse('${AppStrings.baseUrl}/taskapi/signup');

      final payload = {
        "username": username,
        "useremail": useremail,
        "phoneNumber": phoneNumber,
        "address": {
          "userid": 0,
          "buildingNameandstreet": buildingStreet,
          "area": area,
          "city": city,
          "state": state,
          "country": country,
          "pincode": pincode,
        },
        "userpassword": password,
      };

      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(payload),
      );

      print('🟢 SIGNUP API URL: $uri');
      print('🟢 SIGNUP PAYLOAD: $payload');
      print('🟢 SIGNUP STATUS: ${response.statusCode}');
      print('🟢 SIGNUP RESPONSE: ${response.body}');

      return {
        "success": response.statusCode == 200,
        "statusCode": response.statusCode,
        "data": jsonDecode(response.body),
      };
    } on SocketException {
      return {
        "success": false,
        "statusCode": 0,
        "errorMessage": "No Internet Connection",
      };
    } catch (e) {
      return {
        "success": false,
        "statusCode": 0,
        "errorMessage": "Something went wrong",
      };
    }
  }

  /// =========================
  /// LOGIN API
  /// =========================
  static Future<Map<String, dynamic>> loginApi({
    required String useremail,
    required String userpassword,
  }) async {
    try {
      final uri = Uri.parse('${AppStrings.baseUrl}/taskapi/login');

      final payload = {"useremail": useremail, "userpassword": userpassword};

      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(payload),
      );

      print('🟢 LOGIN API URL: $uri');
      print('🟢 LOGIN PAYLOAD: $payload');
      print('🟢 LOGIN STATUS: ${response.statusCode}');
      print('🟢 LOGIN RESPONSE: ${response.body}');

      // Check if the response is successful
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return {
          "success": true,
          "statusCode": response.statusCode,
          "data": responseData,
        };
      } else {
        // Handle different error status codes
        final errorData = jsonDecode(response.body);
        return {
          "success": false,
          "statusCode": response.statusCode,
          "data": errorData,
        };
      }
    } on SocketException {
      return {
        "success": false,
        "statusCode": 0,
        "errorMessage": "No Internet Connection",
      };
    } catch (e) {
      print('🔴 LOGIN ERROR: $e');
      return {
        "success": false,
        "statusCode": 0,
        "errorMessage": "Something went wrong",
      };
    }
  }

  /// =========================
  /// ADMIN RESTAURANT DETAILS API
  /// =========================
  /// ✅ CHANGED: Newly added Admin Restaurant Details API
  static Future<Map<String, dynamic>> adminRestaurantDetailsApi({
    required int userid,
    required String restaurantName,
    required String restaurantType,
    required String restaurantContactNumber,
    required String ownerName,
    required String ownerMobileNumber,
    required String ownerEmail,
    required String buildingStreet,
    required String area,
    required String city,
    required String state,
    required String country,
    required String pincode,
    required String gstNumber,
    required String fssaiLicenseNumber,
    required String openingTime,
    required String closingTime,
    required bool isPureVeg,
    required bool supportsDineIn,
    required bool supportsDelivery,
  }) async {
    try {
      final uri = Uri.parse('${AppStrings.baseUrl}/taskapi/adminrestaurentdetails');

      final payload = {
        "userid": userid,
        "restaurantName": restaurantName,
        "restaurantType": restaurantType,
        "restaurantcontactNumber": restaurantContactNumber,
        "ownerName": ownerName,
        "ownerMobileNumber": ownerMobileNumber,
        "ownerEmail": ownerEmail,
        "address": {
          "userid": userid,
          "buildingNameandstreet": buildingStreet,
          "area": area,
          "city": city,
          "state": state,
          "country": country,
          "pincode": pincode,
        },
        "gstNumber": gstNumber,
        "fssaiLicenseNumber": fssaiLicenseNumber,
        "openingTime": openingTime,
        "closingTime": closingTime,
        "isPureVeg": isPureVeg,
        "supportsDineIn": supportsDineIn,
        "supportsDelivery": supportsDelivery,
      };

      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(payload),
      );

      print('🟢 ADMIN RESTAURANT API URL: $uri');
      print('🟢 ADMIN RESTAURANT PAYLOAD: $payload');
      print('🟢 ADMIN RESTAURANT STATUS: ${response.statusCode}');
      print('🟢 ADMIN RESTAURANT RESPONSE: ${response.body}');
      return {
        "success": response.statusCode == 200,
        "statusCode": response.statusCode,
        "data": jsonDecode(response.body),
      };
    } on SocketException {
      return {
        "success": false,
        "statusCode": 0,
        "errorMessage": "No Internet Connection",
      };
    } catch (e) {
      return {
        "success": false,
        "statusCode": 0,
        "errorMessage": "Something went wrong",
      };
    }
  }

  /// =========================
  /// ADD RECIPE API
  /// =========================
  static Future<Map<String, dynamic>> addRecipeApi({
    required String foodname,
    required int cost,
    required String foodimage,
    required String modeoffood,
    required String foodcategory,
    required String fooddescription,
    required int restaurantid,
    required bool available,
  }) async {
    try {
      final uri = Uri.parse('https://myfuture.fly.dev/taskapi/addreceipy');

      final payload = {
        "foodname": foodname,
        "cost": cost,
        "foodimage": foodimage,
        "modeoffood": modeoffood,
        "foodcategory": foodcategory,
        "fooddescription": fooddescription,
        "restaurantid": restaurantid,
        "available": available,
      };

      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(payload),
      );
      print('🟢 ADMIN RECIPE API URL: $uri');
      print('🟢 ADMIN RECIPE PAYLOAD: $payload');
      print('🟢 ADD RECIPE STATUS: ${response.statusCode}');
      print('🟢 ADD RECIPE RESPONSE: ${response.body}');

      return {
        "success": response.statusCode == 200,
        "statusCode": response.statusCode,
        "data": jsonDecode(response.body),
      };
    } on SocketException {
      return {
        "success": false,
        "statusCode": 0,
        "errorMessage": "No Internet Connection",
      };
    } catch (e) {
      return {
        "success": false,
        "statusCode": 0,
        "errorMessage": "Something went wrong",
      };
    }
  }

  /// =========================
  /// RESTAURANT FOOD DETAILS API
  /// =========================
  static Future<Map<String, dynamic>> restaurantFoodDetailsApi({
    required int restaurantid,
  }) async {
    try {
      final uri = Uri.parse(
        'https://myfuture.fly.dev/taskapi/restaurentfooddetails',
      );

      final payload = {"restaurantid": restaurantid};

      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(payload),
      );

      print('🟢 RESTAURANT FOOD API URL: $uri');
      print('🟢 RESTAURANT FOOD PAYLOAD: $payload');
      print('🟢 RESTAURANT FOOD STATUS: ${response.statusCode}');
      print('🟢 RESTAURANT FOOD RESPONSE: ${response.body}');

      return {
        "success": response.statusCode == 200,
        "statusCode": response.statusCode,
        "data": jsonDecode(response.body),
      };
    } on SocketException {
      return {
        "success": false,
        "statusCode": 0,
        "errorMessage": "No Internet Connection",
      };
    } catch (e) {
      return {
        "success": false,
        "statusCode": 0,
        "errorMessage": "Something went wrong",
      };
    }
  }

  /// =========================
  /// ORDER FOOD DETAILS API
  /// =========================
  static Future<Map<String, dynamic>> orderFoodDetailsApi({
    required int userId,
    required int restaurantId,
    required List<Map<String, dynamic>> items,
    required int totalAmount,
    required String buildingStreet,
    required String area,
    required String city,
    required String state,
    required String country,
    required String pincode,
    required String orderStatus,
  }) async {
    try {
      final uri = Uri.parse(
        'https://myfuture.fly.dev/taskapi/orderfooddetails',
      );

      final payload = {
        "userId": userId,
        "restaurantId": restaurantId,
        "items": items, // [{ foodId: 1, quantity: 2 }]
        "totalAmount": totalAmount,
        "deliveryAddress": {
          "userid": userId,
          "buildingNameandstreet": buildingStreet,
          "area": area,
          "city": city,
          "state": state,
          "country": country,
          "pincode": pincode,
        },
        "orderStatus": orderStatus,
      };

      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(payload),
      );

      print('🟢 ORDER FOOD API URL: $uri');
      print('🟢 ORDER FOOD PAYLOAD: $payload');
      print('🟢 ORDER FOOD STATUS: ${response.statusCode}');
      print('🟢 ORDER FOOD RESPONSE: ${response.body}');

      return {
        "success": response.statusCode == 200,
        "statusCode": response.statusCode,
        "data": jsonDecode(response.body),
      };
    } on SocketException {
      return {
        "success": false,
        "statusCode": 0,
        "errorMessage": "No Internet Connection",
      };
    } catch (e) {
      return {
        "success": false,
        "statusCode": 0,
        "errorMessage": "Something went wrong",
      };
    }
  }

  /// =========================
  /// UPDATE ADDRESS DETAILS API
  /// =========================
  static Future<Map<String, dynamic>> updateAddressDetailsApi({
    required int userid,
    required String buildingStreet,
    required String area,
    required String city,
    required String state,
    required String country,
    required String pincode,
  }) async {
    try {
      final uri = Uri.parse(
        'https://myfuture.fly.dev/taskapi/updateaddressdetails',
      );

      final payload = {
        "userid": userid,
        "buildingNameandstreet": buildingStreet,
        "area": area,
        "city": city,
        "state": state,
        "country": country,
        "pincode": pincode,
      };

      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(payload),
      );

      print('🟢 UPDATE ADDRESS API URL: $uri');
      print('🟢 UPDATE ADDRESS PAYLOAD: $payload');
      print('🟢 UPDATE ADDRESS STATUS: ${response.statusCode}');
      print('🟢 UPDATE ADDRESS RESPONSE: ${response.body}');

      return {
        "success": response.statusCode == 200,
        "statusCode": response.statusCode,
        "data": jsonDecode(response.body),
      };
    } on SocketException {
      return {
        "success": false,
        "statusCode": 0,
        "errorMessage": "No Internet Connection",
      };
    } catch (e) {
      return {
        "success": false,
        "statusCode": 0,
        "errorMessage": "Something went wrong",
      };
    }
  }
}
