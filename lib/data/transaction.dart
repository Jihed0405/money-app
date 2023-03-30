  
enum TransactionType{
  outflow,inflow
}
enum ItemCategoryType{
  fashion,grocery,payments,transport,entertainment,travel,homeRent,pet,extra
}
class Transaction{
  final String categoryType;
  final TransactionType transactionType;
  final String itemCategoryName;
  final String itemName;
  final String amount;
  final String date;
  const Transaction(
    this.categoryType,
    this.transactionType,
    this.itemCategoryName,
    this.itemName,
    this.amount,
    this.date,
  );

}
   const List<Transaction> transaction1=[
    Transaction("Fashion", TransactionType.outflow, "Shoes", "Sneakers Nike", " 40.00", "Oct, 23"),
    Transaction("Fashion", TransactionType.outflow, "Bag", "Gucci Flax", " 40.00", "Sep, 15")    ,
    Transaction("Payments", TransactionType.inflow, "Payments", "Transfer from audrew", "190.00", "Aug, 24"),
    Transaction("Grocery", TransactionType.outflow, "Food", "Chicken wing", "35.00", "Oct, 18"),
    Transaction("Transport", TransactionType.outflow, "Transport", "Topup Uber", "20.00", "Aug, 26"),
    Transaction("Fashion", TransactionType.outflow, "Tshirt", "Tshirt 2 pcs", "15.00", "Aug, 23")    ,
    Transaction("Fashion", TransactionType.outflow, "Pants", "Pants 1 pcs  ", " 10.00", "Aug, 23")    ,    
  
  ];

   const List<Transaction> transaction2=[
    
    Transaction("Payments", TransactionType.inflow, "Payments", "Transfer from my company", "2,200.00", "Mar, 19"),
    Transaction("Entertainment", TransactionType.outflow, "Barcelone's game", "Camp Nou game vs RealMadrid ", "35.00", "Mar, 19"),
    Transaction("Travel", TransactionType.outflow, "thailand travel", "visit Kata Beach", "580.00", "Mar, 19" ),
    Transaction("Home Rent", TransactionType.outflow, "Home Rent", "monthly rent", "600.00", "Mar, 19")    ,
    Transaction("Pet", TransactionType.outflow, "Pet food", "Pet food", " 10.00", "Mar, 19")    ,    
    Transaction("extra", TransactionType.outflow, "Café", "hanging out café", "4.00", "Mar, 19"),
  ];