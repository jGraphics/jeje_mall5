class CurrentPrice {
  List<dynamic> ngn;

  CurrentPrice({
    required this.ngn,
  });

  factory CurrentPrice.fromJson(Map<String, dynamic> json) => CurrentPrice(
        ngn: List<dynamic>.from(json["NGN"].map((x) => x)),
      );

  get price => null;

  Map<String, dynamic> toJson() => {
        "NGN": List<dynamic>.from(ngn.map((x) => x)),
      };
}
