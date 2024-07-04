enum UserRole {manager,driver}

class User {
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final List<String>? vehicleIds; // لصاحب المركبة (المدير)
  final List<String>? driverIds; // لصاحب المركبة (المدير)
  final String? vehicleId; // للسائق
  final String? managerId;
  final bool? isSubscribed;
  final DateTime? subscriptionEndDate;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.vehicleIds, // لصاحب المركبة (المدير)
    this.vehicleId, // للسائق
    this.managerId, // للسائق
    this.driverIds,
    this.isSubscribed,
    this.subscriptionEndDate,
  });



  factory User.fromMap(Map<String, dynamic> data) {
      return User(
        id: data['id'],
      name: data['name'],
      email: data['email'],
      role: data['role'] == "manager" ? UserRole.manager : UserRole.driver,
      vehicleIds:data['vehicleIds'] == null ? null :List<String>.from(data['vehicleIds']),
      driverIds:data['driverIds'] == null ? null :List<String>.from(data['driverIds']),
      vehicleId: data['vehicleId'], // استخراج vehicleId للسائق
      managerId: data['managerId'],
      isSubscribed: data['isSubscribed'],
      subscriptionEndDate:data['subscriptionEndDate']?.toDate(),
      );

  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role':role == UserRole.manager ? "manager" : "driver",
      'vehicleIds': vehicleIds,
      'vehicleId': vehicleId, // إضافة vehicleId للسائق
      'managerId':managerId,
      'driverIds':driverIds,
      'isSubscribed':isSubscribed,
      'subscriptionEndDate':subscriptionEndDate,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    UserRole? role,
    List<String>? vehicleIds,
    List<String>? driverIds,
    String? vehicleId, // تحديث vehicleId للسائق
    String? managerId,
    final bool? isSubscribed,
    final DateTime? subscriptionEndDate,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      vehicleIds: vehicleIds ?? this.vehicleIds,
      vehicleId: vehicleId ?? this.vehicleId, // تحديث vehicleId للسائق
      managerId: managerId ?? this.managerId,
      driverIds: driverIds ?? this.driverIds,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      subscriptionEndDate: subscriptionEndDate ?? this.subscriptionEndDate,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          role == other.role &&
          vehicleIds == other.vehicleIds &&
          vehicleId == other.vehicleId &&
          managerId == other.managerId &&
          driverIds == other.driverIds &&
          isSubscribed == other.isSubscribed &&
            subscriptionEndDate == other.subscriptionEndDate;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      role.hashCode ^
      vehicleIds.hashCode ^
      vehicleId.hashCode ^
      managerId.hashCode ^
      driverIds.hashCode ^
      isSubscribed.hashCode ^
      subscriptionEndDate.hashCode;

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, role: $role, vehicleIds: $vehicleIds, vehicleId: $vehicleId, managerId: $managerId ,driverIds: $driverIds ,isSubscribed: $isSubscribed,subscriptionEndDate: $subscriptionEndDate}';
  }

}