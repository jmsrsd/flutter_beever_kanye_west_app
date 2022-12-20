/// ===============
/// Element Counter
/// ===============
///
/// [Instruction]
/// buat sebuah function untuk menghitung jumlah masing-masing elemen yang muncul dari array input yang diberikan
///
/// [Description]
/// 1. function menerima sebuah array sebagai input
/// 2. function Mengembalikan sebuah object sebagai output yang berisikan elemen yang muncul
///    dan jumlah kemunculannya dari input yang diberikan.
///
/// [Example]
/// @input = [1, 2, 3, 4, 5, 4, 3, 2, 4]
///
/// @process
/// angka 1 muncul 1 kali
/// angka 2 muncul 2 kali
/// angka 3 muncul 2 kali
/// angka 4 muncul 3 kali
/// angka 5 muncul 1 kali
///
/// @output
/// {
///    1: 1,
///    2: 2,
///    3: 2,
///    4: 3,
///    5: 1,
/// }
///
/// [Rules]
/// 1. `Wajib dikerjakan dengan pseudocode`.
class Counter {
  List case1 = [
    'Joyful',
    'Infinite',
    'Humble',
    'Joyful',
    'Glory',
    'King',
    'Humble',
    'Infinite'
  ];
  List case2 = [
    true,
    true,
    false,
    true,
    false,
    true,
    false,
    false,
    true,
    false
  ];
  List case3 = [
    1,
    2,
    3,
    4,
    5,
    6,
    4,
    3,
    2,
    5,
    6,
    8,
    7,
    6,
    9,
    8,
    7,
    0,
    8,
    7,
    6,
    5,
    4,
    3
  ];
  static count() {
    // write logic here
    print(
      '''

1. Deklarasikan sebuah fungsi bernama "jumlah" yang mengambil parameter "input" yang merupakan sebuah list dari elemen
2. Deklarasikan variabel "jumlahElemen" sebagai sebuah Map<K, V> kosong
3. Mulai sebuah loop yang mengiterasi setiap "elemen" di dalam "input"
4. Didalam loop, cek apakah "elemen" ada di dalam Map<K, V> "jumlahElemen"
    - Jika tidak ada, tambahkan ke Map<K, V> dengan nilai 1
    - Jika ada, tambahkan nilai di dalam Map<K, V> dengan 1
5. Akhiri loop
6. Kembalikan Map<K, V> "elementCount"

'''
          .trim(),
    );
  }
}

void main() {
  Counter.count();
}
