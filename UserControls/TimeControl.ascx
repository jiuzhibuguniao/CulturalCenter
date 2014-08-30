<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TimeControl.ascx.cs" Inherits="CulturalCenter.TimeControl" %>
<link href="../CSS/TimeControlStyle.css" rel="stylesheet" type="text/css" />
<div id="today"><span id="timespan"></span></div>
<script type="text/javascript" language="javascript">
function changeweek(weeks){
   switch (weeks){
        case 0:
            return "日";
            break;
        case 1:
            return "一";
            break;
        case 2:
            return "二";
            break;
        case 3:
            return "三";
            break;
        case 4:
            return "四";
            break;
        case 5:
            return "五";
            break;
        case 6:
            return "六";
            break;
}
}
function timer() {
thistime= new Date();
var dates=thistime.getDate();
var months=thistime.getMonth()+1;
var years=thistime.getFullYear();
var weeks=thistime.getDay();
var charweek=changeweek(weeks);
var hours=thistime.getHours();
var minutes=thistime.getMinutes();
var seconds=thistime.getSeconds();
if (eval(hours) <10) {hours="0"+hours;}
if (eval(minutes) < 10) {minutes="0"+minutes;}
if (seconds < 10) {seconds="0"+seconds;}
document.getElementById("timespan").innerHTML=years+"年"+months+"月"+ dates+"日"+" 星期"+charweek+"&nbsp;"+hours +":"+minutes+":"+seconds;
t=setTimeout("timer()",1000);
}
timer();

</script>
