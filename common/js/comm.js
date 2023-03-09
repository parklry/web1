// 펼치기,닫기
function Tree(currMenu) {
	thisMenu = eval(currMenu + ".style");
	if (thisMenu.display == "block") {
		thisMenu.display = "none";
	} else {
		thisMenu.display = "block";
	}
}

//페이지 로딩후 로딩중 div 만들기
/*
document.attachEvent('onreadystatechange', function(){
	// check if the DOM is fully loaded
	if(document.readyState === 'complete') {
		newdiv = document.createElement('div');
		newdiv.className = 'LoadingBar';
		newdiv.id = 'LoadingBar';
		document.body.appendChild(newdiv);
		
		newimg = document.createElement('img');
		newimg.className = 'Loading-image';
		newimg.id = 'Loading-image';
		newimg.src = '/2020/images/loading4.gif';
		document.getElementById('LoadingBar').appendChild(newimg);
 }
});
*/
 
//로딩중 보이기
function LoadingStart() {
	if(!document.getElementById('LoadingBar')) {
		newdiv = document.createElement('div');
		newdiv.className = 'LoadingBar';
		newdiv.id = 'LoadingBar';
		document.body.appendChild(newdiv);
		
		newimg = document.createElement('img');
		newimg.className = 'Loading-image';
		newimg.id = 'Loading-image';
		newimg.src = '/2020/images/loading4.gif';
		document.getElementById('LoadingBar').appendChild(newimg);
	}
	
	var twidth = parseInt((document.querySelectorAll('.topbar')[0].style.width).replace('px',''),10);
	var bwidth = document.body.clientWidth;
	twidth = twidth > bwidth ? bwidth : twidth;
	document.getElementById('LoadingBar').style.left = (twidth * 0.5) - 90 + 'px';
	document.getElementById('LoadingBar').style.display = 'block';
}

//로딩중 감추기
function LoadingEnd() {
	if(document.getElementById('LoadingBar')) {
		document.getElementById('LoadingBar').style.display = 'none';
	}
}

//다운페이지 호출시 쿠키를 이용한 로딩표시 / 감추기
function DownStart() {
    document.cookie = _TableForm.cookid.value+"=false; path=/";
	LoadingStart();
	DownEnd();
}

function DownEnd() {
	if (document.cookie.indexOf(_TableForm.cookid.value+"=true") != -1) {
	    var date = new Date(1000);
	    document.cookie = _TableForm.cookid.value+"=; expires=" + date.toUTCString() + "; path=/";
	    LoadingEnd();
	    SetButton(_TableForm.btnlst.value,_TableForm.btnset.value);
	    return;
	}
	setTimeout(DownEnd, 500);
}

//프로그램설명 팝업
function OpenMenual(bpgmid,bpgmnm,dept) {
	var w = 730;
	var h = 690;
	var winl = (screen.width-w)/2;
	var wint = (screen.height-h)/2 - 20;
	wint = 0;
	winprops = 'height='+h+',width='+w+',top='+wint+',left='+winl+',scrollbars='+(dept == '2530' ? 'no' : 'yes')+',resizable=yes';

	window.open('/BSIS/BC0000J/BC4025J'+(dept == '2530' ? '' : '_R')+'.jsp?bpgmid='+bpgmid+'&bpgmnm='+bpgmnm+'&subsystem=B&grpid=14',bpgmid+'_man',winprops).focus();
}

//즐겨찾기 등록/해제
function ChangeBookmark(pgmid, imgbm) {
	var bcheck = '';
	if(imgbm.src.indexOf('_on') == -1) {
		bcheck = 'on';
	} else {
		bcheck = 'off';
	}
	
	newiframe = document.createElement('iframe');
	newiframe.setAttribute('name','bookmark');
	newiframe.style.width = '100px';
	newiframe.style.height = '0px';
	newiframe.setAttribute('src','/common/bookmark.jsp?pgmid='+pgmid+'&check='+(bcheck == 'on' ? 'I' : 'D'));
	document.body.appendChild(newiframe);
	
	imgbm.src = '/2020/images/br_bmark_'+bcheck+'.png';
}

//즐겨찾기 처리 후
function ClearBookmark() {
}

//메세지
function SetMessage(s) {
	if(trim(s) != '') alert(s);
}

//메세지 t 1:alert, 2:message, 3:all
function SetMessage(m,t) {
	if(parent.parent.document.getElementById('message') != null && (t == undefined || t == 2 || t == 3)) {
		parent.parent.message.SetMessage(m);
	}
	if(parent.parent.document.getElementById('message') == null || t == 1 || t == 3) {
		if(trim(m) != '') {
			alert(m);
		}
	}
}

function alerts(s) {
	var audio = document.getElementById("audio1");
	if(s == undefined || trim(s) == '') {
		audio.volume = 0;
		audio.play();
	} else {
		audio.volume = 1;
		audio.play();
		alert(s);
	}
	/*
	if(!document.getElementById('alert_sound')) {
		newdiv = document.createElement('audio');
		newdiv.id = 'alert_sound';
		newdiv.src = '/2020/sound/ringin.wav';
		document.body.appendChild(newdiv);
	}

	var audio = document.getElementById("alert_sound");
	audio.play();
	alert(s);
	*/
}	

//년도Select : 개체, 아래최소년도, 위최대년도, 아래개수, 위개수
function SetOptYear(Opt, minyyy, maxyyy, mincnt, maxcnt) {
	var curSelected = parseInt(Opt.value,10);
	optidx = 0;
	for(var i = curSelected + maxcnt * 2; i >= curSelected - mincnt * 2; i--) {
		if(i < minyyy || i > maxyyy) continue;
		if(i < curSelected - mincnt || i > curSelected + maxcnt) continue;
		Opt.options[optidx] = new Option(i.toString(),i.toString());
		optidx++;
		if(optidx == mincnt + maxcnt + 1) break;
	}
	Opt.value = curSelected;
}

//날짜형식반환
Date.prototype.format = function (f) {
    if (!this.valueOf()) return " ";
    var weekKorName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
    var weekKorShortName = ["일", "월", "화", "수", "목", "금", "토"];
    var weekEngName = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
    var weekEngShortName = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    var d = this;
    return f.replace(/(yyyy|yy|MM|dd|KS|KL|ES|EL|HH|hh|mm|ss|a\/p)/gi, function ($1) {
        switch ($1) {
            case "yyyy": return d.getFullYear(); // 년 (4자리)
            case "yy": return (d.getFullYear() % 1000).zf(2); // 년 (2자리)
            case "MM": return (d.getMonth() + 1).zf(2); // 월 (2자리)
            case "dd": return d.getDate().zf(2); // 일 (2자리)
            case "KS": return weekKorShortName[d.getDay()]; // 요일 (짧은 한글)
            case "KL": return weekKorName[d.getDay()]; // 요일 (긴 한글)
            case "ES": return weekEngShortName[d.getDay()]; // 요일 (짧은 영어)
            case "EL": return weekEngName[d.getDay()]; // 요일 (긴 영어)
            case "HH": return d.getHours().zf(2); // 시간 (24시간 기준, 2자리)
            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2); // 시간 (12시간 기준, 2자리)
            case "mm": return d.getMinutes().zf(2); // 분 (2자리)
            case "ss": return d.getSeconds().zf(2); // 초 (2자리)
            case "a/p": return d.getHours() < 12 ? "오전" : "오후"; // 오전/오후 구분
            default: return $1;
        }
    });
};

String.prototype.string = function (len) { var s = '', i = 0; while (i++ < len) { s += this; } return s; };
String.prototype.zf = function (len) { return "0".string(len - this.length) + this; };
Number.prototype.zf = function (len) { return this.toString().zf(len); };
//let today = new Date();
//console.log(today.format("yyyy.MM.dd a/p hh:mm:ss"));
