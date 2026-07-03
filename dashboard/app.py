import streamlit as st
import pandas as pd
import plotly.express as px
from datetime import datetime
from cache import get_cache, set_cache
from db import get_connection

# ====================================================
# PAGE CONFIG
# ====================================================

st.set_page_config(
    page_title="HDRS Dashboard",
    page_icon="🏨",
    layout="wide"
)

# ====================================================
# SIDEBAR
# ====================================================

st.sidebar.title("🏨 HDRS")

st.sidebar.markdown("""
### Hotel Distributed Reservation System

Basis Data Terdistribusi

Node:
- Jakarta
- Surabaya
- Makassar
""")

refresh = st.sidebar.button("🔄 Refresh Data")

st.sidebar.divider()

st.sidebar.write("Last Update")

st.sidebar.success(
    datetime.now().strftime("%d-%m-%Y %H:%M:%S")
)

# ====================================================
# DATABASE
# ====================================================

conn = get_connection()

hotel, hotel_cache = get_cache("hotel_nasional")

if hotel is None:
    hotel = pd.read_sql(
        "SELECT * FROM hotel_nasional",
        conn
    )
    set_cache("hotel_nasional", hotel)

kamar, kamar_cache = get_cache("kamar_nasional")

if kamar is None:
    kamar = pd.read_sql(
        "SELECT * FROM kamar_nasional",
        conn
    )
    set_cache("kamar_nasional", kamar)

reservasi, reservasi_cache = get_cache("reservasi_nasional")

if reservasi is None:
    reservasi = pd.read_sql(
        "SELECT * FROM reservasi_nasional",
        conn
    )
    set_cache("reservasi_nasional", reservasi)

# ====================================================
# HEADER
# ====================================================

st.title("🏨 HDRS Dashboard")

st.caption("Hotel Distributed Reservation System")

st.divider()

# ====================================================
# METRICS
# ====================================================

col1, col2, col3, col4 = st.columns(4)

with col1:
    st.metric(
        "🏨 Hotel",
        len(hotel)
    )

with col2:
    st.metric(
        "🛏️ Kamar",
        len(kamar)
    )

with col3:
    st.metric(
        "📅 Reservasi",
        len(reservasi)
    )

with col4:
    st.metric(
        "🟢 Node Aktif",
        "3 / 3"
    )

st.divider()

# ====================================================
# CHARTS
# ====================================================

left, right = st.columns(2)

with left:

    reservasi_chart = pd.read_sql(
        """
        SELECT
            cabang,
            COUNT(*) AS jumlah
        FROM reservasi_nasional
        GROUP BY cabang
        ORDER BY cabang
        """,
        conn
    )

    fig = px.bar(
        reservasi_chart,
        x="cabang",
        y="jumlah",
        title="Reservasi per Cabang",
        text_auto=True
    )

    st.plotly_chart(
        fig,
        use_container_width=True
    )

with right:

    kamar_chart = pd.read_sql(
        """
        SELECT
            status,
            COUNT(*) AS jumlah
        FROM kamar_nasional
        GROUP BY status
        """,
        conn
    )

    fig2 = px.pie(
        kamar_chart,
        names="status",
        values="jumlah",
        title="Status Kamar"
    )

    st.plotly_chart(
        fig2,
        use_container_width=True
    )

st.divider()

# ====================================================
# HOTEL
# ====================================================

st.subheader("🏨 Hotel Nasional")

st.dataframe(
    hotel,
    use_container_width=True,
    hide_index=True
)

st.divider()

# ====================================================
# KAMAR
# ====================================================

st.subheader("🛏️ Kamar Nasional")

st.dataframe(
    kamar,
    use_container_width=True,
    hide_index=True
)

st.divider()

# ====================================================
# RESERVASI
# ====================================================

st.subheader("📅 Reservasi Nasional")

st.dataframe(
    reservasi,
    use_container_width=True,
    hide_index=True
)

st.divider()

# ====================================================
# FOOTER
# ====================================================

st.success("✅ Connected to PostgreSQL Distributed Database")

st.divider()

if hotel_cache and kamar_cache and reservasi_cache:
    st.success("🟢 Redis Cache : HIT")
else:
    st.warning("🟡 Redis Cache : MISS (Data diambil dari PostgreSQL)")