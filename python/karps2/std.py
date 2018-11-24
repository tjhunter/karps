"""
The standard library functions that extend the Pandas API.
"""
from typing import List
import pandas as pd

from .objects import AbstractColumn

__all__ = ['reassign', 'truncate', 'collect']


def reassign(df, col_names: List[str], converter):
    """
    Reassigns a number of columns in place.
    :param df: a dataframe
    :param col_names:
    :param converter:
    :return:
    """
    df = df.copy()
    for c in col_names:
        df[c] = converter(df[c])
    # df[col_names] = df[col_names].apply(converter)
    return df


def truncate(df, num_rows: int) -> pd.DataFrame:
    """
    Truncates a dataframe or series to the first n rows.
    """
    return df.iloc[:num_rows]


def collect(df) -> pd.DataFrame:
    """
    Collect a dataframe (no-op in pandas).
    """
    if isinstance(df, AbstractColumn):
        n = call_op(df, "org.karps.Collect", parents=[df])
        cwt = n._kp_eval()
        return _cwt_to_pandas(cwt)
    return df.copy()

def call_op(obj, op_name, extra=None, parents=None, deps=None):
    pass

def _cwt_to_pandas(cwt):
    pass
