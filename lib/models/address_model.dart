class AddressModel {
  late int? _id;
  late String _address;
  late String _addressType;
  late String? _contactPersonName;
  late String? _contactPersonNumber;
  late String _latitude;
  late String _longitude;

  AddressModel({
    id,
    address,
    required addressType,
    contactPersonName,
    contactPersonNumber,
    latitude,
    longitude,
  }) {
    _id = id;
    _address = address;
    _addressType = addressType;
    _contactPersonName = contactPersonName;
    _contactPersonNumber = contactPersonNumber;
    _latitude = latitude;
    _longitude = longitude;
  }

  String get address => _address;
  String get addressType => _addressType;
  String? get contactPersonName => _contactPersonName;
  String? get contactPersonNumber => _contactPersonNumber;
  String get latitude => _latitude;
  String get longitude => _longitude;

  AddressModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _address = json['address'];
    _addressType = json['address_type'] ?? "";
    _contactPersonName = json['contact_person_name'] ?? "";
    _contactPersonNumber = json['contact_person_number'] ?? "";
    _latitude = json['latitude']?? "";
    _longitude = json['longitude']?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['id'] = this._id;
    data['address'] = this._address;
    data['address_type'] = this._addressType;
    data['contact_person_name'] = this._contactPersonName;
    data['contact_person_number'] = this._contactPersonNumber;
    data['latitude'] = this._latitude;
    data['longitude'] = this._longitude;

    return data;
  }
}
