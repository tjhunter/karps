

import logging
import os

__all__ = ['Session', 'ProcessContext']

logger = logging.getLogger('karps')


class Session(object):
    """ A session in Karps.

    A session encapsulates all the state that is communicated between the frontend and the backend.
    """

    def __init__(self, work_dir, spark=None):
        self._work_dir = work_dir
        self._spark = spark
        if not os.path.exists(work_dir):
            logger.debug("Creating dir {}", work_dir)
            os.makedirs(work_dir)

    def dataframe(self, obj):
        """
        Creates a new dataframe from the given object
        :param obj:
        :return:
        """


def set_default_context(session: Session):
    _kp_context.default_session(session)


class ProcessContext(object):
    """
    A number of variables that form an implicit state in the process and that are managed from this unique place.
    """

    def __init__(self):
        self._default_session = None  # type: Session

    def default_session(self, session: Session):
        self._default_session = session


_kp_context = ProcessContext()
