/*
=================================================
HDRS
Distributed Hotel Reservation System

File : 04_function_booking.sql

Description:
Stored Function untuk proses reservasi kamar
=================================================
*/

CREATE OR REPLACE FUNCTION booking_kamar(
    p_id_pelanggan INT,
    p_id_kamar INT,
    p_tgl_checkin DATE,
    p_tgl_checkout DATE
)
RETURNS TEXT
LANGUAGE plpgsql
AS
$$
DECLARE
    v_harga NUMERIC(12,2);
    v_lama_inap INT;
    v_total NUMERIC(12,2);
BEGIN

    -- Ambil harga kamar
    SELECT harga_per_malam
    INTO v_harga
    FROM kamar
    WHERE id_kamar = p_id_kamar;

    -- Jika kamar tidak ditemukan
    IF NOT FOUND THEN
        RETURN 'Kamar tidak ditemukan';
    END IF;

    -- Hitung lama menginap
    v_lama_inap := p_tgl_checkout - p_tgl_checkin;

    -- Hitung total bayar
    v_total := v_harga * v_lama_inap;

    -- Simpan reservasi
    INSERT INTO reservasi
    (
        id_pelanggan,
        id_kamar,
        tgl_checkin,
        tgl_checkout,
        total_bayar,
        status_reservasi
    )
    VALUES
    (
        p_id_pelanggan,
        p_id_kamar,
        p_tgl_checkin,
        p_tgl_checkout,
        v_total,
        'Booked'
    );

    RETURN 'Booking berhasil';

EXCEPTION

    WHEN exclusion_violation THEN
        RETURN 'Kamar sudah dibooking pada tanggal tersebut';

END;
$$;