import redis
import json
import pandas as pd

r = redis.Redis(
    host="localhost",
    port=6379,
    decode_responses=True
)


def get_cache(key):
    data = r.get(key)

    if data:
        return pd.DataFrame(json.loads(data)), True

    return None, False


def set_cache(key, dataframe, ttl=60):
    r.setex(
        key,
        ttl,
        dataframe.to_json(orient="records")
    )