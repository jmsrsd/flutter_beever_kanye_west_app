/*
Membeli makan siang dan menabung
Rusli adalah seorang anak sekolah di SD Beever
Setiap harinya, Rusli diberikan uang jajan oleh orang tuanya 
sebesar Rp. 10.000,- rupiah.
Rusli bisa menabung atau membeli makanan di sekolahnya untuk
makan siang. Kita telah diberikan catatan keuangan Rusli
dalam bentuk text biasa, dan kita diminta menghitung
jumlah uang tabungan Rusli per harinya dan total tabungannya.
Result OUTPUT:
{
    Senin: 2000,
    Selasa: 5500,
    Rabu: 3500,
    Kamis: 7000,
    Jumat: 5500,
    TotalTabungan: 23500
}
*/

class Item {
  String? name;
  int? price;
  Item({required this.name, required this.price});
}

class Result {
  // write logic here
  late Map<String, num> dailySavings;

  late num totalSavings;

  Result() {
    dailySavings = {"Senin": 0, "Selasa": 0, "Rabu": 0, "Kamis": 0, "Jumat": 0};
    totalSavings = 0;
  }

  void addSavings(String day, num amount) {
    dailySavings[day] = dailySavings[day]! + amount;
    totalSavings += amount;
  }

  Map<String, num> toJson() {
    Map<String, num> result = {};
    result["Senin"] = dailySavings["Senin"]!;
    result["Selasa"] = dailySavings["Selasa"]!;
    result["Rabu"] = dailySavings["Rabu"]!;
    result["Kamis"] = dailySavings["Kamis"]!;
    result["Jumat"] = dailySavings["Jumat"]!;
    result["TotalTabungan"] = totalSavings;
    return result;
  }
}

class Savings {
  List<Item> menu = [
    Item(name: "ayam", price: 5000),
    Item(name: "nasi", price: 2000),
    Item(name: "cola", price: 1000),
    Item(name: "chiki", price: 1500),
    Item(name: "hotdog", price: 3000),
    Item(name: "aqua", price: 2000)
  ];

  String purchaseHistory =
      "Senin-ayam,nasi,cola.Selasa-chiki,hotdog.Rabu-ayam,chiki.Kamis-hotdog.Jumat-chiki,cola,nasi";

  static calculate() {
    Result result = Result();
    //
    // write logic here
    final aSavings = Savings();
    final purchases = aSavings.purchaseHistory.split(".");
    for (String purchase in purchases) {
      final parts = purchase.split("-");
      String day = parts[0];
      final items = parts[1].split(",");
      num total = 0;
      for (String item in items) {
        Item menuItem = aSavings.menu.firstWhere((i) => i.name == item,
            orElse: () => Item(name: "", price: 0));
        total += menuItem.price!;
      }
      num savings = 10000 - total;
      result.addSavings(day, savings);
    }
    //
    print(result.toJson());
  }
}

void main() {
  Savings.calculate();
}
