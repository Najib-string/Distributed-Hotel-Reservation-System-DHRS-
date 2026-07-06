import streamlit as st
import pandas as pd
import psycopg2
import redis
import pickle

# ==========================================
# KONFIGURASI
# ==========================================

DB_CONFIG = {
    "host": "localhost",
    "database": "db_jakarta",
    "user": "admin",
    "password": "secret",
    "port": 5432
}

redis_client = redis.Redis(
    host="localhost",
    port=6379,
    decode_responses=False
)

# ==========================================
# CACHE REDIS
# ==========================================

def load_query(sql, cache_key):

    data = redis_client.get(cache_key)

    if data:
        return pickle.loads(data)

    conn = psycopg2.connect(**DB_CONFIG)

    df = pd.read_sql(sql, conn)

    conn.close()

    redis_client.setex(
        cache_key,
        5,
        pickle.dumps(df)
    )

    return df


# ==========================================
# STREAMLIT
# ==========================================

st.set_page_config(
    page_title="HDRS Dashboard",
    layout="wide"
)

st.title("HDRS")
st.subheader("Distributed Hotel Reservation System")

st.divider()

# ==========================================
# LOAD DATA
# ==========================================

hotel = load_query(
    "SELECT * FROM hotel_nasional;",
    "hotel"
)

kamar = load_query(
    "SELECT * FROM kamar_nasional;",
    "kamar"
)

reservasi = load_query(
    "SELECT * FROM reservasi_nasional;",
    "reservasi"
)

# ==========================================
# SUMMARY
# ==========================================

c1, c2, c3 = st.columns(3)

c1.metric(
    "Total Hotel",
    len(hotel)
)

c2.metric(
    "Total Kamar",
    len(kamar)
)

c3.metric(
    "Total Reservasi",
    len(reservasi)
)

st.divider()

# ==========================================
# HOTEL
# ==========================================

st.subheader("Hotel Nasional")

st.dataframe(
    hotel,
    use_container_width=True,
    hide_index=True
)

# ==========================================
# KAMAR
# ==========================================

st.subheader("Kamar Nasional")

st.dataframe(
    kamar,
    use_container_width=True,
    hide_index=True
)

# ==========================================
# RESERVASI
# ==========================================

st.subheader("Reservasi Nasional")

st.dataframe(
    reservasi,
    use_container_width=True,
    hide_index=True
)