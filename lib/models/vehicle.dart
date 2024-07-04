class Vehicle {
  final String id;
  final String ownerId;
  final String plateNumber;
  final String model;
  final String manufacturer;

  Vehicle({
    required this.id,
    required this.ownerId,
    required this.plateNumber,
    required this.model,
    required this.manufacturer,
  });

  factory Vehicle.fromMap(Map<String, dynamic> data) {
    return Vehicle(
      id: data['id'],
      ownerId: data['ownerId'],
      plateNumber: data['plateNumber'],
      model: data['model'],
      manufacturer: data['manufacturer'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ownerId': ownerId,
      'plateNumber': plateNumber,
      'model': model,
      'manufacturer': manufacturer,
    };
  }

  Vehicle copyWith({
    String? id,
    String? ownerId,
    String? plateNumber,
    String? model,
    String? manufacturer,
  }) {
    return Vehicle(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      plateNumber: plateNumber ?? this.plateNumber,
      model: model ?? this.model,
      manufacturer: manufacturer ?? this.manufacturer,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Vehicle &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          ownerId == other.ownerId &&
          plateNumber == other.plateNumber &&
          model == other.model &&
          manufacturer == other.manufacturer;

  @override
  int get hashCode =>
      id.hashCode ^
      ownerId.hashCode ^
      plateNumber.hashCode ^
      model.hashCode ^
      manufacturer.hashCode;

  @override
  String toString() {
    return 'Vehicle{id: $id, ownerId: $ownerId, plateNumber: $plateNumber, model: $model, manufacturer: $manufacturer}';
  }

}