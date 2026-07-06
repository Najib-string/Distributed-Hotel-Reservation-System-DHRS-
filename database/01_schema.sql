-- =====================================
-- HDRS
-- Distributed Hotel Reservation System
-- Schema Database
-- =====================================

CREATE TABLE wilayah (
    id_wilayah INT PRIMARY KEY,
    nama_wilayah VARCHAR(50) NOT NULL,
    kode_area VARCHAR(10) UNIQUE,
    ip_node_server VARCHAR(15) NOT NULL
);

CREATE TABLE pelanggan (
    id_pelanggan SERIAL PRIMARY KEY,
    nama_lengkap VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    no_telp VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE hotel (
    id_hotel SERIAL PRIMARY KEY,
    kode_hotel VARCHAR(10) UNIQUE NOT NULL,
    id_wilayah INTEGER REFERENCES wilayah(id_wilayah),
    nama_hotel VARCHAR(100),
    alamat TEXT,
    kota VARCHAR(50),
    bintang INTEGER,
    kontak_hotel VARCHAR(30),
    status_operasional VARCHAR(20)
);

CREATE TABLE kamar (
    id_kamar SERIAL PRIMARY KEY,
    kode_kamar VARCHAR(10) UNIQUE NOT NULL,
    id_hotel INTEGER REFERENCES hotel(id_hotel),
    nomor_kamar VARCHAR(10),
    tipe_kamar VARCHAR(30),
    harga_per_malam NUMERIC(12,2),
    status VARCHAR(20)
);

CREATE TABLE reservasi (
    id_reservasi SERIAL PRIMARY KEY,
    id_pelanggan INT REFERENCES pelanggan(id_pelanggan),
    id_kamar INT REFERENCES kamar(id_kamar),
    tgl_checkin DATE NOT NULL,
    tgl_checkout DATE NOT NULL,
    total_bayar DECIMAL(12,2),
    status_reservasi VARCHAR(20)
        CHECK (status_reservasi IN
        ('Booked','Checked-In','Checked-Out','Cancelled'))
        DEFAULT 'Booked',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT check_tanggal
    CHECK (tgl_checkout > tgl_checkin)
);