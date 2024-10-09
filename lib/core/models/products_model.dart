class Product {
  final String id;
  final String name;
  final String company;
  final String purchaseDate;
  final String warranty;
  final String creator;
  final String createdBy;
  final String assignedTo;
  final String status;
  final String department;
  final int quantity;
  final String qr;
  final String? productImg;

  Product({
    required this.id,
    required this.name,
    required this.company,
    required this.purchaseDate,
    required this.warranty,
    required this.creator,
    required this.createdBy,
    required this.assignedTo,
    required this.status,
    required this.department,
    required this.quantity,
    required this.qr,
    this.productImg
  });

  // Factory method to create Product from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['_id'],
        name: json['name'],
        company: json['company'],
        purchaseDate: json['purchaseDate'],
        warranty: json['warranty'],
        creator: json['creator'],
        createdBy: json['createdBy'],
        assignedTo: json['assignedTo'],
        status: json['status'],
        department: json['department'],
        quantity: json['quantity'],
        qr: json['qr'],
        productImg:json['productImg']
    );
  }
}

