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
  Map<String, num> toJson() {
    return {};
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

    //
    print(result.toJson());
  }
}
