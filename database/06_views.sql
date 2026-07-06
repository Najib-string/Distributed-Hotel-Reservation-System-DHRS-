/*
=================================================
HDRS
Distributed Hotel Reservation System

File : 06_views.sql

Description:
Global Views
=================================================
*/

--------------------------------------------------
-- HOTEL NASIONAL
--------------------------------------------------

CREATE OR REPLACE VIEW hotel_nasional AS

SELECT
'Jakarta' AS cabang,
kode_hotel,
id_hotel,
nama_hotel,
kota,
bintang
FROM hotel

UNION ALL

SELECT
'Surabaya',
kode_hotel,
id_hotel,
nama_hotel,
kota,
bintang
FROM hotel_surabaya

UNION ALL

SELECT
'Makassar',
kode_hotel,
id_hotel,
nama_hotel,
kota,
bintang
FROM hotel_makassar;


--------------------------------------------------
-- KAMAR NASIONAL
--------------------------------------------------

CREATE OR REPLACE VIEW kamar_nasional AS

SELECT
'Jakarta' AS cabang,
kode_kamar,
nomor_kamar,
tipe_kamar,
harga_per_malam,
status
FROM kamar

UNION ALL

SELECT
'Surabaya',
kode_kamar,
nomor_kamar,
tipe_kamar,
harga_per_malam,
status
FROM kamar_surabaya

UNION ALL

SELECT
'Makassar',
kode_kamar,
nomor_kamar,
tipe_kamar,
harga_per_malam,
status
FROM kamar_makassar;


--------------------------------------------------
-- RESERVASI NASIONAL
--------------------------------------------------

CREATE OR REPLACE VIEW reservasi_nasional AS

SELECT
'Jakarta' AS cabang,
id_reservasi,
id_pelanggan,
id_kamar,
tgl_checkin,
tgl_checkout,
total_bayar,
status_reservasi
FROM reservasi

UNION ALL

SELECT
'Surabaya',
id_reservasi,
id_pelanggan,
id_kamar,
tgl_checkin,
tgl_checkout,
total_bayar,
status_reservasi
FROM reservasi_surabaya

UNION ALL

SELECT
'Makassar',
id_reservasi,
id_pelanggan,
id_kamar,
tgl_checkin,
tgl_checkout,
total_bayar,
status_reservasi
FROM reservasi_makassar;