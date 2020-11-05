var NS = (window.Event) ? 1 : 0

function checkKey(e) {
    var code = (NS) ? e.which : event.keyCode;
    var key = String.fromCharCode(code);
    for (var i = 0; i < ar.length; i++) {
        if (key == ar[i].key) location.href = ar[i].url;
    }
}

function hotKey(key, url) {
    this.key = key;
    this.url = url;
}

if (NS) document.captureEvents(Event.KEYPRESS)
    document.onkeypress = checkKey;

var ar = new Array();
ar[ar.length] = new hotKey("m", "user.UserPageServ");
ar[ar.length] = new hotKey("e", "webmail.WebMailServ?cmd=mlist");
ar[ar.length] = new hotKey("c", "webmail.WebMailServ?cmd=send_form");
