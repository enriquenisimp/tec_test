class FamilyList{
  final List<Family> familys;
  FamilyList({this.familys});

  factory FamilyList.fromJson(List<dynamic> parsedJson){
    List<Family> familys = new List<Family>();
    familys= parsedJson.map((e) => Family.fromJson(e)).toList();

    return new FamilyList(familys: familys);
  }
}
class Family{
   int familyid;
   int groupsize;
   int caravan;

   Family({this.familyid, this.groupsize, this.caravan});

  factory Family.fromJson(Map<String, dynamic> json){
     return Family(
         familyid: json['familyid'],
         groupsize:json['groupsize'],
         caravan: json['caravan']
     );
   }
}