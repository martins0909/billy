class Transaction {
  final String title;
  final String date;
  final String amount;
  final String type; // 'transfer', 'waec', etc.
  final Map<String, dynamic>? details; // Store pin, serial, etc.

  Transaction({
    required this.title,
    required this.date,
    required this.amount,
    required this.type,
    this.details,
  });
}

// Initial mock data
List<Transaction> recentTransactions = [
  Transaction(
    title: "Transfer to John Doe",
    date: "Today, 10:30 AM",
    amount: "- ₦ 5,000",
    type: 'transfer',
  ),
  Transaction(
    title: "Airtime Purchase",
    date: "Yesterday, 02:15 PM",
    amount: "- ₦ 1,000",
    type: 'airtime',
  ),
];
