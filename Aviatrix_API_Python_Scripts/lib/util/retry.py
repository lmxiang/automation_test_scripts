# Copyright (c) 2014-2018 Aviatrix, Inc.

'''
Retry mechanism for failure prone functions.
'''

import sys
import logging
import time
from functools import partial


PATH_TO_PROJECT_ROOT_DIR = "../"
sys.path.append((PATH_TO_PROJECT_ROOT_DIR))


class RetryError(Exception):
    '''
    Retry exception.
    '''

    def __init__(self, name, value, tries):
        self.name = name
        self.value = value
        self.tries = tries

    def __str__(self):
        return '<Type: {} Value: {}>'.format(self.name, self.value)


class RetValError(Exception):
    '''
    Function return value indicates failure.
    '''
    pass


def _execute(func, return_vals):
    '''
    Execute a function and raise an exception if return value is found in the
    tuple ret_vals.
    '''
    ret_val = func()
    if return_vals and ret_val in return_vals:
        raise RetValError('Function returned {}'.format(ret_val))
    return ret_val


def _retry_internal(
        f,
        retry_callback,
        exceptions,
        return_vals,
        tries=-1,
        delay=0,
        max_delay=None,
        backoff=2):
    logger = logging.getLogger('avx')
    _tries, _delay = tries, delay
    if exceptions:
        _exceptions = exceptions
    else:
        _exceptions = Exception

    max_tries = _tries
    while _tries:
        try:
            return _execute(f, return_vals)
        except _exceptions as e:
            exc_type, exc_value = sys.exc_info()[:2]
            exc_obj = RetryError(exc_type.__name__, exc_value.message, max_tries - _tries + 1)
            if retry_callback and not retry_callback(exc_obj):
                raise
            _tries -= 1
            if not _tries:
                raise
            logger.warning(
                '%s [%d/%d] failed: reason: %s, retrying in %s seconds...',
                f.func.__name__,
                _tries, max_tries,
                e,
                _delay)
            time.sleep(_delay)
            _delay *= backoff
            if max_delay is not None:
                _delay = min(_delay, max_delay)


def invoke(
        f,
        fargs=None,
        fkwargs=None,
        retry_callback=None,
        exceptions=None,
        return_vals=None,
        tries=-1,
        delay=0,
        max_delay=None,
        backoff=2):
    '''
    Invokes a function and re-executes it if it failed.

    : f: the function to execute.
    : fargs: the positional arguments of the function to execute.
    : fkwargs: the named arguments of the function to execute.
    : retry_callback: A function which will be invoked after every attempt.
      If this function returns false, retries will be aborted.
    : exceptions: A tuple of exceptions to catch to retry.
    : return_vals: A tuple of return values. Will retry if the function
      returns any of these values.
    : tries: the maximum number of attempts. default: -1 (infinite).
    : delay: initial delay between attempts. default: 0.
    : max_delay: the maximum value of delay. default: None (no limit).
    : param backoff: multiplier applied to delay between attempts.
      default: 1 (no backoff).
    :returns: the result of the f function.
    '''
    args = fargs if fargs else list()
    kwargs = fkwargs if fkwargs else dict()
    return _retry_internal(
        partial(f, *args, **kwargs),
        retry_callback,
        exceptions,
        return_vals,
        tries,
        delay,
        max_delay,
        backoff)
