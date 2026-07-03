/*
===========================================
HDRS
Seed Data Jakarta
===========================================
*/

-- Wilayah
INSERT INTO wilayah VALUES
(1,'Jakarta','JKT','172.20.0.10');

-- Hotel
INSERT INTO hotel
(id_wilayah,nama_hotel,alamat,kota,bintang,kontak_hotel)
VALUES
(
1,
'HDRS Hotel Jakarta',
'Jl. Sudirman No.10',
'Jakarta',
5,
'021111111'
);

-- Kamar
INSERT INTO kamar
(id_hotel,nomor_kamar,tipe_kamar,harga_per_malam)
VALUES
(1,'101','Standard',500000),
(1,'102','Deluxe',800000);

-- Pelanggan
INSERT INTO pelanggan
(nama_lengkap,email,no_telp)
VALUES
('Muhamad Najib Ramdan','najib@mail.com','08123456789'),
('Andi Saputra','andi@mail.com','08234567890'),
('Jamaludin','jamal@mail.com','08345678901');