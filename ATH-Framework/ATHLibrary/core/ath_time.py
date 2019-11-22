from datetime import datetime, timedelta, date
import calendar


class ATHTime(object):
    '''This will be the main class for handling anything to do with time and
    dates in Preceda.  Eventually it will get it's UTC_OFFSET it's date format and
    it's time format from settings.py but currently they are part of this
    class.  Further it should eventually inherit from Robot_time class in robot
    framework to get time math
    '''
    _date_format = "%d.%m.%Y"
    _time_format = "%H:%M"

    def get_server_time(self):
        #TODO: this offset needs to come from settings
        '''our server is in belgium so UTC_OFFSET = 1'''
        UTC_OFFSET = 1
        return datetime.utcnow() + timedelta(hours=UTC_OFFSET)

    def get_date_string(self, use_date=None, date_format=_date_format):
        '''returns date string based upon server time and using the appropriate
        date format.
        '''
        if use_date:
            return use_date.strftime(date_format)
        return self.get_server_time().strftime(date_format)

    def get_date_string_from_delta(self, y, m, d, start_at=None, date_format= _date_format):
        '''return the time string based on Y, M, D offsets
        y = year
        m = month
        d = day
        start = if None, current time; else datetime val (convenient for testing)
        '''
        #TODO: For fixed days, usage of brackets: "(1)"
        y, m, d = int(y), int(m), int(d)
        #TODO: pass 'start_at' from calling function
        if start_at is None:
            t0 = self.get_server_time()
        else:
            t0 = datetime.strptime(start_at, '%Y-%m-%d')
        t1 = t0 + timedelta(days=d)
        t2 = self._add_months(t1, m) if m != 0 else t1
        t3 = self._add_months(t2, y*12) if y != 0 else t2
        return t3.strftime(date_format)

    def _add_months(self, sourcedate, months):
        # from stackoverflow: http://stackoverflow.com/a/4131114/1431750
        month = sourcedate.month - 1 + months
        year = sourcedate.year + month / 12
        month = month % 12 + 1
        day = min(sourcedate.day, calendar.monthrange(year, month)[1])
        return datetime(year, month, day)

    def get_date_from_phrase(self, date_phrase_given, today=None, date_format=_date_format):
        date_phrase = ' '.join(word.lower() for word in date_phrase_given.split()[1:])
        spec_date = None
        if not today:
            today = self.get_server_time()

        if date_phrase == '1st of curr month':
            spec_date = date(today.year, today.month, 1)

        elif date_phrase == '1st of prev month':
            if today.month > 1:
                prev_month = today.month - 1
                prev_month_year = today.year
            else:
                prev_month = 12
                prev_month_year = today.year - 1
            spec_date = date(prev_month_year, prev_month, 1)

        elif date_phrase == '1st of next month':
            if today.month < 12:
                next_month = today.month + 1
                next_month_year = today.year
            else:
                next_month = 1
                next_month_year = today.year + 1
            spec_date = date(next_month_year, next_month, 1)

        elif date_phrase == 'jan 1st of curr yr':
            spec_date = date(today.year, 1, 1)

        elif date_phrase == 'dec 31st of curr yr':
            spec_date = date(today.year, 12, 31)

        elif date_phrase == '31.12.9999':
            return '31.12.9999'  # can't be passed to strftime
            
        elif date_phrase == 'end of curr month':
            end_date_curr_month = calendar.monthrange(today.year,today.month)[1]
            spec_date = date(today.year,today.month,end_date_curr_month)

        elif date_phrase == 'end of prev month':
            prev_month = today.month - 1
            end_date_prev_month = calendar.monthrange(today.year,prev_month)[1]
            spec_date = date(today.year,prev_month,end_date_prev_month)

        else:
            raise ValueError('"%s" is not handled by datemath Special Dates' % date_phrase_given)

        return self.get_date_string(spec_date, date_format)

