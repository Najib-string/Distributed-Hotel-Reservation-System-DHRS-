/*
=================================================
HDRS
Distributed Hotel Reservation System

File : 04_function_booking.sql

Description:
Stored Function untuk proses reservasi kamar
=================================================
*/

CREATE OR REPLACE FUNCTION booking_kamar
(
    p_id_pelanggan INT,
    p_kode_kamar VARCHAR,
    p_checkin DATE,
    p_checkout DATE
)
RETURNS TEXT
LANGUAGE plpgsql
AS
$$
DECLARE

    v_id_kamar INT;
    v_harga NUMERIC;
    v_total NUMERIC;
    v_lama INT;
    v_id_reservasi INT;

BEGIN

    v_lama := p_checkout - p_checkin;

    --------------------------------------------------
    -- JAKARTA
    --------------------------------------------------

    IF LEFT(p_kode_kamar,3)='JKT' THEN

        SELECT
            id_kamar,
            harga_per_malam
        INTO
            v_id_kamar,
            v_harga
        FROM kamar
        WHERE kode_kamar=p_kode_kamar;

        IF NOT FOUND THEN
            RETURN 'Kamar tidak ditemukan';
        END IF;

        v_total := v_harga * v_lama;

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
            v_id_kamar,
            p_checkin,
            p_checkout,
            v_total,
            'Booked'
        );

        UPDATE kamar
        SET status='Booked'
        WHERE id_kamar=v_id_kamar;

        RETURN 'Booking Jakarta berhasil';

    END IF;

    --------------------------------------------------
    -- SURABAYA
    --------------------------------------------------

    IF LEFT(p_kode_kamar,3)='SBY' THEN

        SELECT
            id_kamar,
            harga_per_malam
        INTO
            v_id_kamar,
            v_harga
        FROM kamar_surabaya
        WHERE kode_kamar=p_kode_kamar;

        IF NOT FOUND THEN
            RETURN 'Kamar tidak ditemukan';
        END IF;

        v_total := v_harga * v_lama;

        SELECT COALESCE(MAX(id_reservasi),0)+1
        INTO v_id_reservasi
        FROM reservasi_surabaya;

        INSERT INTO reservasi_surabaya
        (
            id_reservasi,
            id_pelanggan,
            id_kamar,
            tgl_checkin,
            tgl_checkout,
            total_bayar,
            status_reservasi
        )
        VALUES
        (
            v_id_reservasi,
            p_id_pelanggan,
            v_id_kamar,
            p_checkin,
            p_checkout,
            v_total,
            'Booked'
        );

        UPDATE kamar_surabaya
        SET status='Booked'
        WHERE id_kamar=v_id_kamar;

        RETURN 'Booking Surabaya berhasil';

    END IF;

    --------------------------------------------------
    -- MAKASSAR
    --------------------------------------------------

    IF LEFT(p_kode_kamar,3)='MKS' THEN

        SELECT
            id_kamar,
            harga_per_malam
        INTO
            v_id_kamar,
            v_harga
        FROM kamar_makassar
        WHERE kode_kamar=p_kode_kamar;

        IF NOT FOUND THEN
            RETURN 'Kamar tidak ditemukan';
        END IF;

        v_total := v_harga * v_lama;

        SELECT COALESCE(MAX(id_reservasi),0)+1
        INTO v_id_reservasi
        FROM reservasi_makassar;

        INSERT INTO reservasi_makassar
        (
            id_reservasi,
            id_pelanggan,
            id_kamar,
            tgl_checkin,
            tgl_checkout,
            total_bayar,
            status_reservasi
        )
        VALUES
        (
            v_id_reservasi,
            p_id_pelanggan,
            v_id_kamar,
            p_checkin,
            p_checkout,
            v_total,
            'Booked'
        );

        UPDATE kamar_makassar
        SET status='Booked'
        WHERE id_kamar=v_id_kamar;

        RETURN 'Booking Makassar berhasil';

    END IF;

    RETURN 'Kode kamar tidak valid';

END;
$$;