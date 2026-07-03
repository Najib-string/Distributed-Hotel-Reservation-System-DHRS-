/*
=================================================
HDRS
Distributed Hotel Reservation System

File : 03_constraints.sql

Description:
Constraint dan fitur PostgreSQL
=================================================
*/

-- ============================================
-- Extension
-- ============================================

CREATE EXTENSION IF NOT EXISTS btree_gist;

-- ============================================
-- Mencegah Double Booking
-- ============================================

ALTER TABLE reservasi
ADD CONSTRAINT no_double_booking
EXCLUDE USING gist (

    id_kamar WITH =,

    daterange(
        tgl_checkin,
        tgl_checkout,
        '[)'
    ) WITH &&

)

WHERE (
    status_reservasi = 'Booked'
);
