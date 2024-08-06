import 'package:flutter/material.dart';

class Address {
  final int id;
  final String nickname;
  final String avenue;
  final String apartment;
  final String additionalDirections;
  final String street;
  final String houseNumber;
  final String floorNumber;
  final int areaId;
  final String areaName;
  final String areaArabicName;
  final int zoneId;
  final String zoneName;
  final String zoneArabicName;
  final int blockId;
  final String blockName;
  final String blockArabicName;
  final double latitude;
  final double longitude;
  final int deliveryTimeId;
  final String deliveryTimeName;
  final String deliveryTimeArabicName;
  final bool isDefaultAddress;
  final bool leaveAtDoor;

  Address({
    required this.latitude,
    required this.longitude,
    required this.id,
    required this.nickname,
    required this.apartment,
    required this.additionalDirections,
    required this.avenue,
    required this.street,
    required this.houseNumber,
    required this.floorNumber,
    required this.areaId,
    required this.areaName,
    required this.areaArabicName,
    required this.zoneId,
    required this.zoneName,
    required this.zoneArabicName,
    required this.blockId,
    required this.blockName,
    required this.blockArabicName,
    required this.deliveryTimeId,
    required this.deliveryTimeName,
    required this.deliveryTimeArabicName,
    required this.isDefaultAddress,
    required this.leaveAtDoor,
  });

  Map toJson(String mobile) => {
     'mobile' :mobile,
     'latitude' :latitude,
     'longitude' :longitude,
     'address_id' :id,
     'nickname' :nickname,
     'apartment' :apartment,
     'additional_directions' :additionalDirections,
     'avenue' :avenue,
     'street' :street,
     'house_number' :houseNumber,
     'floor_number' :floorNumber,
     'area' :areaId,
     'zone' :zoneId,
     'block' :blockId,
     'delivery_time' :deliveryTimeId,
     'default_address' :isDefaultAddress,
     'leave_at_door' :leaveAtDoor,
      };

}

Address mapAddress(dynamic payload) {

  return Address(
    latitude: (payload["latitude"] != null && payload["latitude"] !="") ? payload["latitude"]: 0.0,
    longitude: (payload["longitude"] != null && payload["longitude"] !="") ? payload["longitude"]: 0.0,
    id: (payload["id"]!=null && payload["id"]!= false) ? payload["id"]: -1,
    nickname: payload["nickname"] ?? "",
    deliveryTimeId: (payload["delivery_time_id"]!=null && payload["delivery_time_id"]!= false) ? payload["delivery_time_id"]:-1,
    deliveryTimeName: payload["delivery_time_name"]!=null ? payload["delivery_time_name"].toString():"",
    deliveryTimeArabicName: payload["delivery_time_name_arabic"]!=null ? payload["delivery_time_name_arabic"].toString():"",
    avenue: payload["avenue"]!=null ? payload["avenue"].toString():"",
    apartment: payload["apartment"]!=null ? payload["apartment"].toString():"",
    additionalDirections: payload["additional_directions"]!=null ? payload["additional_directions"].toString():"",
    street: payload["street"]!=null ? payload["street"].toString():"",
    houseNumber: payload["house_number"]!=null ? payload["house_number"].toString():"",
    floorNumber: payload["floor_number"]!=null ? payload["floor_number"].toString():"",
    areaId: payload["area_id"] ?? -1,
    areaName: payload["area_name"]!=null ? payload["area_name"].toString():"",
    areaArabicName: payload["area_name_arabic"]!=null ? payload["area_name_arabic"].toString():"",
    zoneId: payload["zone_id"] ?? -1,
    zoneName: payload["zone_name"]!=null ? payload["zone_name"].toString():"",
    zoneArabicName: payload["zone_name_arabic"]!=null ? payload["zone_name_arabic"].toString():"",
    blockId: payload["block_id"] ?? -1,
    blockArabicName: payload["block_name_arabic"]!=null ? payload["block_name_arabic"].toString():"",
    blockName: payload["block_name"]!=null ? payload["block_name"].toString():"",
    isDefaultAddress: payload["default_address"] ?? false,
    leaveAtDoor: payload["leave_at_door"] ?? false,
  );

}

