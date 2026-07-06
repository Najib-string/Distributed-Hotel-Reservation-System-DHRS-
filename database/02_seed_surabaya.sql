/*
===========================================
HDRS
Seed Data Surabaya
===========================================
*/

-- Wilayah
INSERT INTO wilayah
VALUES
(
2,
'Surabaya',
'SBY',
'172.20.0.20'
);

INSERT INTO hotel
(
kode_hotel,
id_wilayah,
nama_hotel,
alamat,
kota,
bintang,
kontak_hotel,
status_operasional
)
VALUES
(
'SBY',
2,
'HDRS Hotel Surabaya',
'Jl. Basuki Rahmat No.20',
'Surabaya',
4,
'031222222',
'Aktif'
);

INSERT INTO kamar
(
kode_kamar,
id_hotel,
nomor_kamar,
tipe_kamar,
harga_per_malam,
status
)
VALUES
(
'SBY01',
1,
'201',
'Standard',
550000,
'Available'
);

INSERT INTO kamar
(
kode_kamar,
id_hotel,
nomor_kamar,
tipe_kamar,
harga_per_malam,
status
)
VALUES
(
'SBY02',
1,
'202',
'Suite',
1200000,
'Available'
);

-- Pelanggan
INSERT INTO pelanggan
(nama_lengkap,email,no_telp)
VALUES
('Muhamad Najib Ramdan','najib@mail.com','08123456789'),
('Andi Saputra','andi@mail.com','08234567890'),
('Jamaludin','jamal@mail.com','08345678901');