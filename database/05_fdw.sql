/*
=================================================
HDRS
Distributed Hotel Reservation System

File : 05_fdw.sql

Description:
Konfigurasi PostgreSQL FDW
=================================================
*/

--------------------------------------------------
-- EXTENSION
--------------------------------------------------

CREATE EXTENSION IF NOT EXISTS postgres_fdw;

--------------------------------------------------
-- SERVER SURABAYA
--------------------------------------------------

CREATE SERVER IF NOT EXISTS surabaya_server
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (
    host 'pg-surabaya',
    dbname 'db_surabaya',
    port '5432'
);

--------------------------------------------------
-- SERVER MAKASSAR
--------------------------------------------------

CREATE SERVER IF NOT EXISTS makassar_server
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (
    host 'pg-makassar',
    dbname 'db_makassar',
    port '5432'
);

--------------------------------------------------
-- USER MAPPING
--------------------------------------------------

CREATE USER MAPPING IF NOT EXISTS FOR admin
SERVER surabaya_server
OPTIONS (
    user 'admin',
    password 'secret'
);

CREATE USER MAPPING IF NOT EXISTS FOR admin
SERVER makassar_server
OPTIONS (
    user 'admin',
    password 'secret'
);

--------------------------------------------------
-- FOREIGN TABLE HOTEL SURABAYA
--------------------------------------------------

CREATE FOREIGN TABLE IF NOT EXISTS hotel_surabaya (
    id_hotel INT,
    kode_hotel VARCHAR(10),
    id_wilayah INT,
    nama_hotel VARCHAR(100),
    alamat TEXT,
    kota VARCHAR(50),
    bintang INT,
    kontak_hotel VARCHAR(20),
    status_operasional VARCHAR(20)
)
SERVER surabaya_server
OPTIONS (
    schema_name 'public',
    table_name 'hotel'
);

--------------------------------------------------
-- FOREIGN TABLE KAMAR SURABAYA
--------------------------------------------------

CREATE FOREIGN TABLE IF NOT EXISTS kamar_surabaya (
    id_kamar INT,
    kode_kamar VARCHAR(10),
    id_hotel INT,
    nomor_kamar VARCHAR(10),
    tipe_kamar VARCHAR(20),
    harga_per_malam NUMERIC(12,2),
    status VARCHAR(20)
)
SERVER surabaya_server
OPTIONS (
    schema_name 'public',
    table_name 'kamar'
);

--------------------------------------------------
-- FOREIGN TABLE RESERVASI SURABAYA
--------------------------------------------------

CREATE FOREIGN TABLE IF NOT EXISTS reservasi_surabaya (
    id_reservasi INT,
    id_pelanggan INT,
    id_kamar INT,
    tgl_checkin DATE,
    tgl_checkout DATE,
    total_bayar NUMERIC(12,2),
    status_reservasi VARCHAR(20)
)
SERVER surabaya_server
OPTIONS (
    schema_name 'public',
    table_name 'reservasi'
);

--------------------------------------------------
-- FOREIGN TABLE HOTEL MAKASSAR
--------------------------------------------------

CREATE FOREIGN TABLE IF NOT EXISTS hotel_makassar (
    id_hotel INT,
    kode_hotel VARCHAR(10),
    id_wilayah INT,
    nama_hotel VARCHAR(100),
    alamat TEXT,
    kota VARCHAR(50),
    bintang INT,
    kontak_hotel VARCHAR(20),
    status_operasional VARCHAR(20)
)
SERVER makassar_server
OPTIONS (
    schema_name 'public',
    table_name 'hotel'
);

--------------------------------------------------
-- FOREIGN TABLE KAMAR MAKASSAR
--------------------------------------------------

CREATE FOREIGN TABLE IF NOT EXISTS kamar_makassar (
    id_kamar INT,
    kode_kamar VARCHAR(10),
    id_hotel INT,
    nomor_kamar VARCHAR(10),
    tipe_kamar VARCHAR(20),
    harga_per_malam NUMERIC(12,2),
    status VARCHAR(20)
)
SERVER makassar_server
OPTIONS (
    schema_name 'public',
    table_name 'kamar'
);

--------------------------------------------------
-- FOREIGN TABLE RESERVASI MAKASSAR
--------------------------------------------------

CREATE FOREIGN TABLE IF NOT EXISTS reservasi_makassar (
    id_reservasi INT,
    id_pelanggan INT,
    id_kamar INT,
    tgl_checkin DATE,
    tgl_checkout DATE,
    total_bayar NUMERIC(12,2),
    status_reservasi VARCHAR(20)
)
SERVER makassar_server
OPTIONS (
    schema_name 'public',
    table_name 'reservasi'
);