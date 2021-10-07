// type IFindOption = "findOne";
// type IinsertOption = "insertOne" | "insertMany";
// type IupdateOption = "updateOne" | "updateMany" | "replaceOne";
// type IdeleteOption = "deleteOne" | "deleteMany" | "findOneAndDelete"

class RequestBody {
  String collectionName;
  String amendType;
  dynamic payload;

  RequestBody({
    required this.amendType,
    required this.collectionName,
    required this.payload,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['collectionName'] = this.collectionName;
    data['amendType'] = this.amendType;
    data['payload'] = this.payload;
    print('----payload---------');
    print(data);
    return data;
  }
}
