<%@ page buffer="16kb"
		 contentType="application/x-javascript;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.util.*,
		 		 com.ibm.icu.util.*,
				 org.json.simple.*,
		 		 com.localeplanet.common.*,
		 		 com.localeplanet.i18n.*,
		 		 com.localeplanet.icu.*,
		 		 com.localeplanet.java.*,
		 		 com.localeplanet.util.*"
%>

	/*
	 * converts an iso8601 time string to (non-JavaScript) time object
	 * NOTE: this does not have any time zone information, so you can't convert it directly to a JavaScript date
	 */
    function isoToTime(timeStr)
    {

        if (timeStr == null)
        {
            return null;
        }
        var hour = 0;
        var minute = 0;
        var second = 0;

        if (timeStr.length == 8)
        {
            hour = parseInt(timeStr.substring(0, 2), 10);
            minute = parseInt(timeStr.substring(3, 5), 10);
            second = parseInt(timeStr.substring(6, 8), 10);
        }
        else if (timeStr.length == 6)
        {
            hour = parseInt(timeStr.substring(0, 2), 10);
            minute = parseInt(timeStr.substring(2, 4), 10);
            second = parseInt(timeStr.substring(4, 6), 10);
        }
        else if (timeStr.length == 5)
        {
            hour = parseInt(timeStr.substring(0, 2), 10);
            minute = parseInt(timeStr.substring(3, 5), 10);
        }
        else if (timeStr.length == 4)
        {
            hour = parseInt(timeStr.substring(0, 2), 10);
            minute = parseInt(timeStr.substring(2, 4), 10);
        }
        else if (timeStr.length == 2)
        {
            hour = parseInt(timeStr, 10);
        }
        else
        {
            alert("Invalid length");
        }
        
        return { 
        	getHours: function() { return hour; },
        	getMinutes: function() { return minute; },
        	getSeconds: function() { return second; },
        	getMilliseconds: function() { return 0; }
        	};
	}
        
        
	function isoToMillis(timeStr)
	{
		var time = isoToTime(timeStr)

        var result = (((time.getHours() * 60 + time.getMinutes()) * 60) + time.getSeconds()) * 1000;

        return result;
    }

    function millisToTime(ms)
    {
        var hour = Math.floor(ms / (60 * 60 * 1000)) % 24;
        var minute = Math.floor(ms / (60 * 1000)) % 60;
        var second = Math.floor(ms / 1000) % 60;
        
        return { 
        	getHours: function() { return hour; },
        	getMinutes: function() { return minute; },
        	getSeconds: function() { return second; },
        	getMilliseconds: function() { return 0; }
        	};
    }


