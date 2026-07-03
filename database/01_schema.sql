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
    id_wilayah INT REFERENCES wilayah(id_wilayah),
    nama_hotel VARCHAR(100) NOT NULL,
    alamat TEXT NOT NULL,
    kota VARCHAR(50) NOT NULL,
    bintang INT CHECK (bintang BETWEEN 1 AND 5),
    kontak_hotel VARCHAR(20),
    status_operasional VARCHAR(20)
        CHECK (status_operasional IN ('Aktif','Maintenance'))
        DEFAULT 'Aktif'
);

CREATE TABLE kamar (
    id_kamar SERIAL PRIMARY KEY,
    id_hotel INT REFERENCES hotel(id_hotel) ON DELETE CASCADE,
    nomor_kamar VARCHAR(10) NOT NULL,
    tipe_kamar VARCHAR(20)
        CHECK (tipe_kamar IN ('Standard','Deluxe','Suite','Family')),
    harga_per_malam DECIMAL(12,2) NOT NULL,
    status VARCHAR(20)
        CHECK (status IN ('Available','Occupied','Maintenance'))
        DEFAULT 'Available'
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