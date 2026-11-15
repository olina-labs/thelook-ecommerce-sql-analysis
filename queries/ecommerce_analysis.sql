/*
================================================================================
PROYEK ANALISIS DATA: THELOOK E-COMMERCE
Dataset : bigquery-public-data.thelook_ecommerce
Author  : Olina Febrianty
================================================================================
*/

-- 1. Analisis Produk
-- Tim Product ingin mengetahui karakteristik produk yang dijual. Tampilkan nama produk,kategori, department, merek, dan harga retail dari tabel products. Batasi hasil menjadi 20produk pertama.
-- Materi: SELECT, FROM, LIMIT

SELECT
  name,
  category,
  department,
  brand,
  retail_price,

FROM 
  bigquery-public-data.thelook_ecommerce.products
  
LIMIT 20;

-- 2. Identifikasi Produk Premium
-- Tim Marketing ingin menyiapkan kampanye untuk produk premium. Cari produk dengan retail_price di atas 100. Tampilkan nama produk, kategori, merek, dan harga retail, lalu urutkan dari harga tertinggi ke terendah.
-- Materi: WHERE, ORDER BY, DESC

SELECT
  name AS product_name,
  category,
   brand,
  retail_price,
FROM 
  bigquery-public-data.thelook_ecommerce.products
WHERE 
  retail_price >100
ORDER BY 
  retail_price DESC;


-- 3. Evaluasi Kategori Produk
-- Tim Product ingin mengetahui kategori dengan jumlah produk terbanyak. Hitung jumlah produk pada setiap kategori dari tabel products, lalu urutkan hasil dari jumlah produk terbesar.
-- Materi: COUNT, GROUP BY, ORDER BY

SELECT 
    category, 
    COUNT(*) AS total_products
FROM 
    bigquery-public-data.thelook_ecommerce.products
GROUP BY category
ORDER BY total_products DESC;

-- 4. Mengenal Pelanggan dan Pesanan
-- Tim CRM ingin melihat pelanggan yang melakukan pemesanan. Gabungkan tabel users dan orders untuk menampilkan ID pesanan, status pesanan, tanggal pesanan dibuat, serta nama depan dan nama belakang pelanggan.
-- Materi: INNER JOIN, ON, alias tabel

SELECT 
    o.order_id,
    o.status,
    o.created_at,
    u.first_name,
    u.last_name
FROM bigquery-public-data.thelook_ecommerce.orders AS o
INNER JOIN bigquery-public-data.thelook_ecommerce.users AS u
    ON o.user_id = u.id;

-- 5. Analisis Penjualan per Kategori
-- Manajer bisnis ingin mengetahui kategori produk dengan nilai penjualan terbesar. Gabungkan tabel order_items dan products, lalu hitung total nilai penjualan berdasarkan kategori. Tampilkan kategori dan total penjualan, kemudian urutkan dari nilai terbesar. Gunakan order_items.sale_price sebagai nilai transaksi per item.
-- Materi: JOIN, SUM, GROUP BY, ORDER BY
SELECT 
    p.category,
    ROUND(SUM(oi.sale_price), 2) AS total_sales
FROM `bigquery-public-data.thelook_ecommerce.order_items` AS oi
INNER JOIN `bigquery-public-data.thelook_ecommerce.products` AS p
    ON oi.product_id = p.id
GROUP BY p.category
ORDER BY total_sales DESC;

/*
================================================================================
BUSINESS INSIGHTS (GABUNGAN ANALISIS SOAL 3 & SOAL 5)
================================================================================
1. Variasi Katalog vs. Nilai Penjualan:
   - Kategori dengan jumlah produk terbanyak (Soal 3) tidak otomatis menghasilkan 
     total penjualan tertinggi (Soal 5). Kategori seperti Outerwear & Coats dan 
     Jeans mendominasi total revenue karena harga jual per unit yang lebih tinggi.
   - Rekomendasi: Prioritaskan promosi dan ketersediaan stok pada kategori 
     bernilai transaksi tinggi (high-value categories).

2. Efisiensi Katalog & Risiko Over-Assortment:
   - Kategori yang memiliki banyak variasi produk namun total penjualannya rendah 
     menunjukkan adanya produk yang kurang diminati pasar (slow-moving SKU).
   - Rekomendasi: Lakukan evaluasi katalog untuk memangkas SKU yang tidak 
     produktif serta terapkan promo bundling untuk menghabiskan stok lama.

3. Konsentrasi Pendapatan pada Kategori Inti:
   - Sebagian besar pendapatan perusahaan bertumpu pada beberapa kategori utama 
     di peringkat teratas.
   - Rekomendasi: Jaga stabilitas rantai pasok (supply chain) pada kategori 
     utama untuk mencegah kehabisan stok pada produk terlaris.
*/
