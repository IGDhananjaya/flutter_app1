class Posting {
  final String name;
  // final String price;
  // final String quantity;
  final String image;
  final String description;

  Posting(
    this.name,
    // this.price,
    // this.quantity,
    this.image,
    this.description,
  );
}

final List<Posting> allData = [
  Posting(
    'Todo',
    // '2.000',
    // '1ikat',
    'images/rumah kartun.jpeg',
    'Testing aja ini mah',
  ),
  Posting(
    'Jojo',
    // '4.000',
    // '1kg',
    'images/rumah kartun.jpeg',
    'Kamu testing? sama aku juga',
  ),
  Posting(
    '4theeenth',
  //   '9.500',
  //   '1bungkus',
    'images/day 1 cxamp-43.jpg',
    'Sampai dirumahh~',
  ),
  // Product(
  //   'Kiwi',
  //   '4.500',
  //   '1kg',
  //   'assets/img4.png',
  //   'Secara umum sayuran dan buah-buahan merupakan sumber berbagai vitamin, mineral, dan serat pangan. Sebagian vitamin dan mineral yang terkandung dalam sayuran dan buah-buahan berperan untuk membantu proses-proses metabolisme di dalam tubuh, sedangkan antioksidan mampu menangkal senyawa-senyawa hasil oksidasi, radikal bebas, yang mampu menurunkan kondisi kesehatan tubuh',
  // ),
  // Product(
  //   'Jeruk',
  //   '3.500',
  //   '1kg',
  //   'assets/img5.png',
  //   'Secara umum sayuran dan buah-buahan merupakan sumber berbagai vitamin, mineral, dan serat pangan. Sebagian vitamin dan mineral yang terkandung dalam sayuran dan buah-buahan berperan untuk membantu proses-proses metabolisme di dalam tubuh, sedangkan antioksidan mampu menangkal senyawa-senyawa hasil oksidasi, radikal bebas, yang mampu menurunkan kondisi kesehatan tubuh',
  // ),
  // Product(
  //   'Apel',
  //   '4.500',
  //   '1kg',
  //   'assets/img6.png',
  //   'Secara umum sayuran dan buah-buahan merupakan sumber berbagai vitamin, mineral, dan serat pangan. Sebagian vitamin dan mineral yang terkandung dalam sayuran dan buah-buahan berperan untuk membantu proses-proses metabolisme di dalam tubuh, sedangkan antioksidan mampu menangkal senyawa-senyawa hasil oksidasi, radikal bebas, yang mampu menurunkan kondisi kesehatan tubuh',
  // ),
];