function [ unix_time ] = datetime_to_unix(year,month,day,hour,minute,seconds)
%Converts datetime to unix time, which is number of seconds
% since January 1, 1970.
    days_since = daysact('1/1/1970',sprintf('%d/%d/%d',month,day,year));
    unix_time = days_since*60*60*24 + hour*60*60 + minute*60 + seconds;
end

