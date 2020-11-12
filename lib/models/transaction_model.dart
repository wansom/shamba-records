class TransactionModel {
  String name;
  String photo;
  String date;
  String amount;

  TransactionModel(this.name, this.photo, this.date, this.amount);
}

List<TransactionModel> transactions = transactionData
    .map((item) => TransactionModel(
        item['name'], item['photo'], item['date'], item['amount']))
    .toList();

var transactionData = [
  {
    "name": "Contribution",
    "photo": "assets/images/logo.jpg",
    "date": "1st Apr 2020",
    "amount": "Ksh35.214"
  },
  {
    "name": "Installment",
    "photo": "assets/images/logo.jpg",
    "date": "30th Mar 2020",
    "amount": "-ksh100.00"
  },
  {
    "name": "Payment",
    "photo": "assets/images/logo.jpg",
    "date": "15th Mar 2020",
    "amount": "+ksh250.00"
  }
];

class PaymentService {
  void makePayment() {
    transactionData.add({
      'name': 'warren',
      'photo': 'assets/images/logo.jpg',
      'date': DateTime.now().toString(),
      'amount': 'Ksh 3200',
    });
  }
}
