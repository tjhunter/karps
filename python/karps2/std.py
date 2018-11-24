"""
The standard library functions that extend the Pandas API.
"""
from typing import List
import pandas as pd

__all__ = ['reassign', 'truncate']


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
