# thelook-ecommerce-sql-analysis
Exploratory SQL Data Analysis on TheLook E-Commerce dataset using Google BigQuery.

# 📊 TheLook E-Commerce: SQL Data Analysis

Proyek analisis data eksploratif menggunakan SQL pada Google BigQuery untuk mengevaluasi katalog produk, perilaku pemesanan pelanggan, serta performa penjualan berdasarkan kategori produk.

---

## 🎯 Tujuan Project
1. Mengidentifikasi karakteristik katalog produk serta segmen produk premium (`retail_price > 100`).
2. Mengevaluasi distribusi variasi produk (*SKU*) pada setiap kategori untuk mendukung pengambilan keputusan Tim Product.
3. Menghubungkan data pelanggan dan transaksi pemesanan guna memantau status pesanan untuk Tim CRM.
4. Menganalisis kategori produk dengan nilai penjualan (*revenue*) tertinggi serta membandingkannya dengan komposisi jumlah produk di katalog.

---

## 🗄️ Dataset
Analisis ini menggunakan dataset publik **TheLook E-Commerce** yang tersedia di Google BigQuery (`bigquery-public-data.thelook_ecommerce`), dengan tabel utama yang digunakan:
* **`products`**: Informasi detail produk (nama produk, kategori, departemen, merek, dan harga retail).
* **`orders`**: Data transaksi pesanan pelanggan (ID pesanan, ID pengguna, status pesanan, dan waktu pembuatan pesanan).
* **`users`**: Data profil pelanggan (ID pelanggan, nama depan, dan nama belakang).
* **`order_items`**: Rincian item pada setiap transaksi beserta harga jual aktual (`sale_price`).

---

## ❓ Pertanyaan Bisnis & Struktur Query
Seluruh skrip SQL tersimpan rapi di dalam folder [`queries/ecommerce_analysis.sql`](queries/ecommerce_analysis.sql), yang mencakup 5 pertanyaan bisnis utama:

1. **Analisis Produk (Tim Product):** Menampilkan 20 data produk pertama beserta nama, kategori, departemen, merek, dan harga retail.
2. **Identifikasi Produk Premium (Tim Marketing):** Menyaring produk dengan harga retail di atas `100` dan mengurutkannya dari harga tertinggi ke terendah.
3. **Evaluasi Kategori Produk (Tim Product):** Menghitung total jumlah produk (*SKU*) pada setiap kategori dan mengurutkannya dari yang terbanyak.
4. **Mengenal Pelanggan dan Pesanan (Tim CRM):** Menggabungkan tabel `orders` dan `users` untuk melihat ID pesanan, status, tanggal pesanan, serta nama lengkap pelanggan.
5. **Analisis Penjualan per Kategori (Manajer Bisnis):** Menggabungkan tabel `order_items` dan `products` untuk menghitung total nilai penjualan (`SUM(sale_price)`) berdasarkan kategori.

---

## 💡 Business Insights & Rekomendasi (Berdasarkan Hasil Analisis Soal 3 & 5)

### 1. Perbedaan antara Variasi Katalog (SKU) dan Kontribusi Pendapatan (*Revenue*)
* **Insight:** Kategori dengan jumlah variasi produk (*SKU*) terbanyak di katalog (seperti *Intimates* atau *Tops & Tees*) tidak otomatis menjadi penyumbang nilai penjualan terbesar. Kategori seperti *Outerwear & Coats* dan *Jeans* mampu mendominasi total penjualan meskipun jumlah varian produknya lebih sedikit, karena memiliki harga jual per unit (*average selling price*) yang jauh lebih tinggi.
* **Rekomendasi:** Tim Product dan Marketing sebaiknya memprioritaskan promosi dan alokasi anggaran stok pada kategori bernilai transaksi tinggi (*high-ticket items*) karena terbukti menjadi penggerak utama pendapatan perusahaan.

### 2. Risiko *Over-Assortment* pada Kategori dengan Penjualan Rendah
* **Insight:** Terdapat beberapa kategori yang memiliki banyak variasi produk di katalog, tetapi kontribusi nilai penjualannya relatif kecil. Hal ini menandakan adanya ketidakefisienan inventaris akibat variasi produk yang kurang diminati pasar (*slow-moving items*).
* **Rekomendasi:** Lakukan audit katalog (*SKU rationalization*) untuk memangkas varian produk yang tidak produktif, serta terapkan strategi *bundling* atau promosi khusus untuk mempercepat perputaran stok.

### 3. Konsentrasi Pendapatan pada Kategori Utama (*Pareto Principle*)
* **Insight:** Sebagian besar pendapatan perusahaan bertumpu pada beberapa kategori utama di peringkat teratas, sementara kategori di peringkat terbawah hanya menyumbang porsi penjualan yang sangat kecil.
* **Rekomendasi:** Jaga stabilitas ketersediaan stok (*stock availability*) pada kategori penyumbang pendapatan terbesar untuk mencegah kehilangan potensi penjualan (*lost sales*).

---

## 📁 Struktur Repository
```text
thelook-ecommerce-sql-analysis/
├── README.md                        # Dokumentasi utama proyek, dataset, pertanyaan bisnis, & insight
└── queries/
    └── ecommerce_analysis.sql       # Kumpulan query SQL untuk menjawab 5 pertanyaan bisnis
