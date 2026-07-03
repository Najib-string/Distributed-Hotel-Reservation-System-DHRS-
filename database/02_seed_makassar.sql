/*
===========================================
HDRS
Seed Data Makassar
===========================================
*/

-- Wilayah
INSERT INTO wilayah VALUES
(3,'Makassar','MKS','172.20.0.30');

-- Hotel
INSERT INTO hotel
(id_wilayah,nama_hotel,alamat,kota,bintang,kontak_hotel)
VALUES
(
3,
'HDRS Hotel Makassar',
'Jl. Penghibur No.30',
'Makassar',
4,
'041133333'
);

-- Kamar
INSERT INTO kamar
(id_hotel,nomor_kamar,tipe_kamar,harga_per_malam)
VALUES
(1,'301','Standard',600000),
(1,'302','Family',1500000);

-- Pelanggan
INSERT INTO pelanggan
(nama_lengkap,email,no_telp)
VALUES
('Muhamad Najib Ramdan','najib@mail.com','08123456789'),
('Andi Saputra','andi@mail.com','08234567890'),
('Jamaludin','jamal@mail.com','08345678901');