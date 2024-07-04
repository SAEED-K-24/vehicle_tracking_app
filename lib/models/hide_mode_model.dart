class HideModeModel {
  String? id;
  String? managerId;
  String? driverId;
  bool? isHide;

  HideModeModel({this.id, this.managerId, this.driverId, this.isHide});

  HideModeModel.fromMap(Map<String,dynamic> data){
    id=data["id"];
    managerId=data["managerId"];
    driverId=data["driverId"];
    isHide=data["isHide"];
  }

  toMap(){
    return{
      "id":id,
      "managerId":managerId,
      "driverId":driverId,
      "isHide":isHide
    };
  }

  HideModeModel copyWith({
    String? id,
    String? managerId,
  String? driverId,
  bool? isHide,}){
    return HideModeModel(
      id: id ?? this.id,
      managerId: managerId??this.managerId,
      driverId: driverId??this.driverId,
      isHide: isHide??this.isHide,
    );
  }
  
}