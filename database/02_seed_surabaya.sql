/*
===========================================
HDRS
Seed Data Surabaya
===========================================
*/

-- Wilayah
INSERT INTO wilayah VALUES
(2,'Surabaya','SBY','172.20.0.20');

-- Hotel
INSERT INTO hotel
(id_wilayah,nama_hotel,alamat,kota,bintang,kontak_hotel)
VALUES
(
2,
'HDRS Hotel Surabaya',
'Jl. Basuki Rahmat No.20',
'Surabaya',
4,
'031222222'
);

-- Kamar
INSERT INTO kamar
(id_hotel,nomor_kamar,tipe_kamar,harga_per_malam)
VALUES
(1,'201','Standard',550000),
(1,'202','Suite',1200000);

-- Pelanggan
INSERT INTO pelanggan
(nama_lengkap,email,no_telp)
VALUES
('Muhamad Najib Ramdan','najib@mail.com','08123456789'),
('Andi Saputra','andi@mail.com','08234567890'),
('Jamaludin','jamal@mail.com','08345678901');