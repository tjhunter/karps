"""
The basic objects of the Karps API: DataFrames, Columns, Observables.
"""

from .proto import graph_pb2 as gpb


class HasArithmeticOps(object):
    """ Dispatches arithmetic operations to the functions standard library.

    This class is inherited by Column, DataFrame and Observable.
    """
    pass


class AbstractColumn(object):
    """ A column of data.

    This is an abstraction for a potentially unbounded list of cells, all of the same types.

    The difference between columns and dataframes is that dataframes can exist on their own,
    while columns have a refering dataframe.

    Users should never have to create manually columns or dataframes, but rely on the framework
    for doing so.
    """
    pass


class AbstractNode(object):
    """ The base class for observables or dataframes.
    """

    @property
    def kp_path(self):
        return self._path

    @property
    def kp_op_name(self):
        return self._op_name

    @property
    def kp_type(self):
        """ The data type of this column """
        return DataType(self._type_p)

    @property
    def kp_is_distributed(self):
        return self._is_distributed

    @property
    def kp_is_local(self):
        return not self.is_distributed

    @property
    def kp_op_extra(self):
        """ Returns a proto """
        return self._op_extra_p

    @property
    def kp_parents(self):
        """ Returns the parents (other nodes). """
        return self._parents

    @property
    def kp_logical_dependencies(self):
        """ The logical dependencies """
        return self._logical_dependencies

    def __repr__(self):
        return "{p}{l}{o}:{dt}".format(
            p=str(self.kp_path),
            l="!" if self.kp_is_local else "@",
            o=self.kp_op_name,
            dt=str(self.kp_type))


class Column(AbstractColumn, HasArithmeticOps):
    """ A column of data isolated from a dataframe.
    """

    def __repr__(self):
        return "{}:{}<-{}".format(self._pretty_name(), self.type, self.reference)

    @property
    def kp_reference(self):
        """ The referring dataframe """
        return self._ref

    def kp_as_column(self):
        """ A column, seen as a column.
        """
        return self

    def kp_as_dataframe(self, name_hint=None):
        """ A column, seen as a dataframe (referring to itself).

        This causes all the columns to be resolved and coalesced. Intermediary dataframes may
        also be created if some broadcasts need to happen.
        """
        pass


class DataFrame(AbstractColumn, AbstractNode, HasArithmeticOps):
    """ A dataframe.
    """

    @property
    def kp_reference(self):  # type DataFrame
        """ The referring dataframe (itself). """
        return self

    def kp_as_column(self) -> Column:
        """ A dataframe, seen as a column.
        """
        pass
        # return build_col_extract(
        #     ref=self,
        #     type_p=self._type_p,
        #     path=[])

    def kp_as_dataframe(self):
        """ A dataframe, seen as a dataframe. """
        return self


class Observable(AbstractNode, HasArithmeticOps):
    """ An observable.

    Do not call the constructor, use build_observable() instead.
    """

