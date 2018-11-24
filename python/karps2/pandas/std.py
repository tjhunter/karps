"""
Pandas-only functions that are more suitable to Karps and at the same time
try to stay pandorable.
"""
import pandas as pd
import os

__all__ = ['load']


def load(obj, path):
    """
    Takes an object (that is supposed to be lazy in nature), assumed to be or to produce
     a dataframe, and memoizes it to a specific location.
    :param obj: a function or a pandas dataframe
    :param path: a path in the local file system
    :return: a pandas dataframe
    """
    df = None  # type: pd.DataFrame
    if os.path.exists(path):
        return pd.read_parquet(path)
    if callable(obj):
        df = obj()
    if isinstance(obj, pd.DataFrame):
        df = obj
    if not isinstance(df, pd.DataFrame):
        raise ValueError("Given object is of type {}. Only functions"
                         " or pandas dataframes are accepted".format(type(obj)))
    d = os.path.dirname(path)
    os.makedirs(d, exist_ok=True)
    df.to_parquet(path)
    return df
