
class ShippingAddress {

  final String  id;
  final String  name;
  final String  addressString; 

  ShippingAddress({
    required this.id,
    required this.name,
    required this.addressString
  });

  Map toJson() => {
    'id': id,
  };

}

ShippingAddress mapShippingAddress(dynamic payload){
  return ShippingAddress(
      id :payload["id"]??"",
      name :payload["name"]??"",
      addressString :payload["addressString"]??""
  );
}


List<ShippingAddress> getSampleShippingAddresss(){
  return [

    ShippingAddress(
        id:"shipping_addr_1",
        addressString: "1234 Elm Street, Springfield, Anytown, State of Confusion, Country of Imagination, Postal Code: 98765-4321",
        name: "My Home"
    ),
    ShippingAddress(
        id:"shipping_addr_2",
        addressString: "1234 Elm Street, Springfield, Anytown, State of Confusion, Country of Imagination, Postal Code: 98765-4321",
        name: "My Office"
    ),

  ];
}