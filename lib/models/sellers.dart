


class Seller{
  String soldBy;
  int SellingPrice;
  String DueDate;
  String SoldTo;
  String Note;
  String id;

  Seller();

  Map<String,dynamic> toMap(){
    return {
      'soldBy' : soldBy,
      'SellingPrice' : SellingPrice,
      'DueDate' : DueDate,
      'SoldTo' : SoldTo,
      'Note' : Note,
      'id' : id,
    };
  }
}