var _calendar;
var _entries = new Array();
var scheduleDataStore;
var schedule_load;

var schedule_type = ["개인","기념일","업무","휴가","행사","출장","공지","국경일","","공휴일"];
var schedule_share = ["개인일정","그룹일정","전체일정"];
var schedule_share_bgcolor = ["#F1FAEC","#FDFBF3","#F5F5F5"];
var schedule_share_color = ["#666666","#000000","#000"];
var schedule_repeat = ["반복안함","일간반복","주간반복","월간반복","년간반복"];
var schedule_alam = ["알리지않음","시작시간","1시간전","1일전","2일전","3일전","1주일전"];
var schdeule_idx_type = ["schedule", "daylong", "anniversary"];