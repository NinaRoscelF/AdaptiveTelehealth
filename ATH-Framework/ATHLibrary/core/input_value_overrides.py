'''overrides is a dictionary specifying all of the text overrides
that testers can pass in for set and check values.  We define them
all here so that they are standardized across the framework
DO NOT DEFINE overrides anywhere else than in this dictionary
'''
from ATHLibrary.core.ath_time import ATHTime
from robot.api import logger
from selenium.common.exceptions import StaleElementReferenceException
from decorator import decorator
from datetime import datetime, timedelta
import re
import random


class Overrides(object):
    '''This class manages all input override handlers.  Input override handlers
    can be found by using the following function:
    `Overrides.get_handler(val)`
    This function will return the appropriate handler based upon the text in
    val. i.e. if val = <<TODAY>> it will return the 'TODAY' override handler.
    then you can call
    `handler.validate(expected_val, actual_val)` which will return True if they
    match and False otherwise.

    To implement a new Handler create a class inside Overrides.
    each override handler should provide 2 functions.
    the class should look like
    `class override_handler(object):

        def validate(expected_val, actual_val):
            #returns true if handler matches val
            pass

        def get_val():
            #returns the value to set for the handler
            pass
    `
    '''
    class _today_override_handler(object):

        def validate(self, expected_val, actual_val):
            '''return true if actual_val is todays date based upon server
            time currently date format is assumed to be dd.mm.yyyy'''
            return (self.get_val(expected_val).replace(".", "") == actual_val.replace(" ", "").replace(".", ""))
        def get_val(self,val,string_format):
            '''returns today server time'''
            logger.info("today : %s" % val)
            return ATHTime().get_date_string(None, string_format)

    class _datemath_override_handler(object):

        def validate(self, expected_val, actual_val):
            '''check if the expected val with date math matches the actual value
            '''
            return self.get_val(expected_val).replace(".", "") == actual_val.replace(" ", "").replace(".", "")


        def get_val(self,val,string_format):
            if not (isinstance(val,basestring) and val.startswith("<<")
                   and val.endswith(">>")):
                logger.info("dateIs : %s" % val)
                return val

            val = val[2:-2]
            if val.upper().startswith('DATEADD'):
                return self._dateadd(val,string_format)
            if val.upper().startswith('SPECDATE'):
                return self._special_date(val,string_format)
            raise ValueError('"%s" is not handled by datemath' % val)

        @staticmethod
        def _dateadd(val,string_format):
            '''return server time with date math for +/- Y M D'''
            datesplit = val.split()[1:]
            y, m, d = datesplit[:3]
            # the fourth elem after Y M D will be the 'start' date
            # to consider if testing. format: "%Y-%m-%d"
            start_at = datesplit[3] if len(datesplit) == 4 else None
            return ATHTime().get_date_string_from_delta(y, m, d, start_at,string_format)

        @staticmethod
        def _special_date(val,string_format):
            return ATHTime().get_date_from_phrase(val,None,string_format)


    class _default_override_handler(object):

        def validate(self, expected_val, actual_val):
            if isinstance(expected_val, basestring) and isinstance(actual_val,
                    basestring):
                #emptry string is always "in" another string
                if len(expected_val) > 0:
                    #return re.search(expected_val, actual_val)
                    return (expected_val in actual_val)
                else:
                    return (expected_val == actual_val)
            else:
                return (expected_val == actual_val)


        def get_val(self,val,string_format):
            return val
            return string_format(val,string_format)

    class _randomnum_override_handler(object):
        ''' Sample usage: <<RANDOMNUM 0 1000>>
        0 - starting #; 1000 - ending #
        '''

        def validate(self, expected_val, actual_val):
            pass

        def get_val(self, val, string_format):
            val = val[2:-2]
            randomsplit = val.split()[1:]
            start_at, end_at = randomsplit[:2]
            return random.randint(int(start_at), int(end_at))

    override_handlers = {"TODAY"     : _today_override_handler,
                         "DATEADD"   : _datemath_override_handler,
                         "SPECDATE"  : _datemath_override_handler,
                         "RANDOMNUM" : _randomnum_override_handler,
                        }


    @classmethod
    def get_handler(cls, val):
        '''This is the factory method / main entry into the Overrides class.
        It parsees the input values if value startswith << then will cut off
        leading and trailing << and >> and send the result to each validator in
        the overrid)validators list by calling .handles().  The first validator
        to return True will be return.  If val doesn't start with << or no
        validators handle the string then the default handler which is
        functionally equivalent to == will be returned
        '''
        #TODO: if/when we need time / date math do val.split[0] as key to dict

        if isinstance(val,basestring) and val.startswith("<<") and val.endswith(">>"):
            val = val[2:-2].upper() #chop of the <<>> and make it big
            return cls.override_handlers.get(val.split()[0], cls._default_override_handler)()
        #if we've gotten this far just return the default handler
        #TODO: when we implement translation framework default handler needs to
        # be the translation handler
        return cls._default_override_handler()

    @classmethod
    def validate(cls, expected_val, actual_val):
        '''This function will call get_handler(expected_val) to get the handler
        and then call handler.validate(expected_val, actual_val).
        '''
        handler = cls.get_handler(expected_val)
        return handler.validate(expected_val, actual_val)


    @classmethod
    def get_input_vals(cls, *args):
        '''calls get_input_val multiple times for each arg in *args'''
        return [cls.get_input_val(arg) for arg in args]

    @classmethod
    def get_input_val(cls, val, string_format):
        '''uses get_validator function to get the validator then calls
        validator.get_val and returns the result.
        '''

        return cls.get_handler(val).get_val(val,string_format)

#@decorator
def handle_input_overrides(method, *args, **kwargs):
    '''This is a decorator which means it is a function used
    to wrap other functions.  It will wrap a function and if that
    function throws a StaleElementReferenceException, which usually
    happens becaue an AJAX call has changed an element we are trying
    to operate on, it will retry the function one more time, the idea
    is the function would just try to find the element again and then
    performe an operation on the element.
    To use this decorator on a function declare the function like:
    @handle_stale_element
    def myfunction():
    '''
    #new_args = Overrides.get_input_vals(
    try:
        return method(*args, **kwargs)
    except StaleElementReferenceException:
        logger.info("Found a stale element in %s trying again" % (method.__name__))
        return method(*args, **kwargs)
