
Number.prototype.to2 = function() { return (this > 9 ? "" : "0")+this; };
Date.MONTHS = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
Date.DAYS   = ["Sun", "Mon", "Tue", "Wed", "Tur", "Fri", "Sat"];

Date.prototype.getDateString = function(dateFormat) {
  var result = "";
  
  dateFormat = dateFormat == 8 && "YYYY.MM.DD" ||
               dateFormat == 6 && "hh:mm:ss" ||
               dateFormat ||
               "YYYY.MM.DD hh:mm:ss";
               
  for (var i = 0; i < dateFormat.length; i++) {
    
    result += dateFormat.indexOf("YYYY", i) == i ? (i+=3, this.getFullYear()                     ) :
              dateFormat.indexOf("YY",   i) == i ? (i+=1, String(this.getFullYear()).substring(2)) :
              dateFormat.indexOf("MMM",  i) == i ? (i+=2, Date.MONTHS[this.getMonth()]           ) :
              dateFormat.indexOf("MM",   i) == i ? (i+=1, (this.getMonth()+1).to2()              ) :
              dateFormat.indexOf("M",    i) == i ? (      this.getMonth()+1                      ) :
              dateFormat.indexOf("DDD",  i) == i ? (i+=2, Date.DAYS[this.getDay()]               ) :
              dateFormat.indexOf("DD",   i) == i ? (i+=1, this.getDate().to2()                   ) :
              dateFormat.indexOf("D"   , i) == i ? (      this.getDate()                         ) :
              dateFormat.indexOf("hh",   i) == i ? (i+=1, this.getHours().to2()                  ) :
              dateFormat.indexOf("h",    i) == i ? (      this.getHours()                        ) :
              dateFormat.indexOf("mm",   i) == i ? (i+=1, this.getMinutes().to2()                ) :
              dateFormat.indexOf("m",    i) == i ? (      this.getMinutes()                      ) :
              dateFormat.indexOf("ss",   i) == i ? (i+=1, this.getSeconds().to2()                ) :
              dateFormat.indexOf("s",    i) == i ? (      this.getSeconds()                      ) :
                                                   (dateFormat.charAt(i)                         ) ;
                                                   
  }
  return result;
};

function fn_getDateFormatString( dateString , dateFormat )
{
    YYYY = '';
    MM = '';
    DD = '';
    hh = '';
    mm = '';
    ss = '';
    if( dateString.length == 8 )
    {
       YYYY = dateString.substring(0,4);
       MM = dateString.substring(4,6);    
       DD = dateString.substring(6,8);
    }else if( dateString.length == 14 ){
       YYYY = dateString.substring(0,4);
       MM = dateString.substring(4,6);    
       DD = dateString.substring(6,8);
       hh = dateString.substring(8,10);    
       mm = dateString.substring(10,12);
       ss = dateString.substring(12);
    }
    
  var result = "";
  
  for (var i = 0; i < dateFormat.length; i++) {
    result += dateFormat.indexOf("YYYY", i) == i ? (i+=3, YYYY                ) :
              dateFormat.indexOf("MM",   i) == i ? (i+=1, MM                  ) :
              dateFormat.indexOf("DD",   i) == i ? (i+=1, DD                  ) :
              dateFormat.indexOf("hh",   i) == i ? (i+=1, hh                  ) :
              dateFormat.indexOf("mm",   i) == i ? (i+=1, mm                  ) :
              dateFormat.indexOf("ss",   i) == i ? (i+=1, ss                  ) :
                                                   (dateFormat.charAt(i)      ) ;
  }
  return result;
    
};

function createNoteDiv(message){
        return ['<div style="margin:5pt 5pt 5pt 5px;">',
                message,
                '</div>'].join('');
    }