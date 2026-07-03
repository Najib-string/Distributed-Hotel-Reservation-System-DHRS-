/*
=================================================
HDRS
Distributed Hotel Reservation System

File : 07_index.sql

Description:
Optimasi Index
=================================================
*/

--------------------------------------------------
-- HOTEL
--------------------------------------------------

CREATE INDEX IF NOT EXISTS idx_hotel_nama
ON hotel(nama_hotel);

--------------------------------------------------
-- KAMAR
--------------------------------------------------

CREATE INDEX IF NOT EXISTS idx_kamar_hotel
ON kamar(id_hotel);

CREATE INDEX IF NOT EXISTS idx_kamar_status
ON kamar(status);

--------------------------------------------------
-- RESERVASI
--------------------------------------------------

CREATE INDEX IF NOT EXISTS idx_reservasi_pelanggan
ON reservasi(id_pelanggan);

CREATE INDEX IF NOT EXISTS idx_reservasi_kamar
ON reservasi(id_kamar);

CREATE INDEX IF NOT EXISTS idx_reservasi_checkin
ON reservasi(tgl_checkin);

CREATE INDEX IF NOT EXISTS idx_reservasi_status
ON reservasi(status_reservasi);