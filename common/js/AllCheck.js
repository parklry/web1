//년체크
function CheckYear(yy, next, select) {
	if(!isNumber(yy.value)) {
		SetMessage('연도에는 문자가 올 수 없습니다.');	
		yy.value = '';
		yy.focus();
		return false;
	} 
	if(yy.value.length==4) {
		if(yy.value>'2200'||yy.value<'1900') {
			SetMessage('유효한 연도를 넣어주십시요.');
			yy.value='';
			return false;
		}
		if(select == 'Y') next.select();
		next.focus();
		return true;
	}
}

//월체크
function CheckMonth(yy,mm,next,select) {
	if(yy.value.length!=4||!isNumber(yy.value)) {
		SetMessage('연도를 먼저 입력하세요.');
		mm.value = '';
		yy.select();
		yy.focus();
		return false;
	}
	if(!isNumber(mm.value)) {
		SetMessage('월에는 문자가 올 수 없습니다.');	
		mm.value = '';
		mm.focus();
		return false;
	}
	if(mm.value.length==1) {
		if(mm.value<='9'&&mm.value>'1') {
			mm.value = '0'+mm.value;
			if(select == 'Y') next.select();
			next.focus();
			return true;
		}
		return false;
	}
	if(mm.value.length==2) {
		if(mm.value<='12'&&mm.value!='00') {	
			if(select == 'Y') next.select();
			next.focus();
			return true;
		} else {
			SetMessage('월은 01~12사이의 값이어야 합니다.');
			mm.value = '';
			mm.focus();
			return false;
		}
	}	
}

//일체크
function CheckDay(yy,mm,dd,next,select) {
	if(yy.value.length!=4||!isNumber(yy.value)) {
		SetMessage('연도를 먼저 입력하세요.');
		dd.value = '';
		yy.select();
		yy.focus();
		return false;
	}
	if(mm.value.length!=2||!isNumber(mm.value)) {
		SetMessage('월을 먼저 입력하세요.');
		dd.value = '';
		mm.select();
		mm.focus();
		return false;
	}
	if(!isNumber(dd.value)) {
		SetMessage('일에는 문자가 올 수 없습니다.');	
		dd.select();
		dd.focus();
		return false;
	}
	if(dd.value.length==1) {
		if(dd.value<='9'&&dd.value>'3') {
			dd.value = '0'+dd.value;
		}
	}
	if(dd.value.length==2) {
		if(VerifyDate(yy.value, mm.value, dd.value)) {
			if(select == 'Y') next.select();
			next.focus();
			return true;
		} else {
			SetMessage('일수가 잘못됐습니다.');
			dd.value = '';
			dd.focus();
			return false;
		}
	}
}

function DateCheck(str, len, name) {
	if(len != 4 && len != 6 && len != 8) {
		SetMessage('날짜체크의 자리수가 잘못되었습니다.');
		if(len > 4) str.select();
		str.focus();
	}
	if(str.value == '' || str.value.length != len){
		SetMessage(name + '를 확인하십시오.');
		if(len > 4) str.select();
		str.focus();
		return false;
	}
	if(!isNumber(str.value)) {
		SetMessage(name + '에는 문자가 올수 없습니다.');
		if(len > 4) str.select();
		str.focus();
		return false;
	}
	
	var year = (str.value.substr(0,4));
	var month = len > 4 ? (str.value.substr(4,2)) : '';
	var day = len > 6 ? (str.value.substr(6,2)) : '';
	if(year > '2200' || year < '1900') {
		SetMessage('[년도]가 유효하지 않습니다.');
		if(len > 4) str.select();
		str.focus();
		return false;
	}
	if(len >= 6) {
		if(month > '12' || month < '01') {
			SetMessage('[월]이 유효하지 않습니다.');
			if(len > 4) str.select();
			str.focus();
			return false;
		}
	}
	if(len >= 8) {
		if(!DayOfMonth(year,month,day)) {
			SetMessage('[일]이 유효하지 않습니다.');
			if(len > 4) str.select();
			str.focus();
			return false;
		}
	}
	return true;
}

function VerifyDate(year, month, day) {
	if(year>'2200'||year<'1900') {
		return false;
	}
	if(month>'12'||month<'01') {
		return false;
	}
	if(!DayOfMonth(year,month,day)) {
		return false;
	}
	return true;
}

function DayOfMonth(year, month, day) {	
	var days = new Array('31','28','31','30','31','30','31','31','30','31','30','31');	
	if(month!='02') {
		if(day<'01'||day>days[month-1]) {
			return false;
		}
		return true;
	}	
	if((year%4==0&&year%100!=0)||(year%400==0)) {
		if(day<'01'||day>'29') {
			return false;
		}	
		return true;
	}	
	if(day<'01'||day>'28') {
		return false;
	}	
	return true;		
}

function containsCharsOnly(input,chars) {
	var dotcnt = 0;
	var minuscnt = 0;
	for (var inx = 0; inx < input.length; inx++) {
		if (chars.indexOf(input.charAt(inx)) == -1)	return false;
		if (input.charAt(inx) == '.') dotcnt++;
		if (input.charAt(inx) == '-') minuscnt++;
		if (dotcnt > 1) return false;
		if (minuscnt > 1) return false;
	}
	return true;
}
function isNumber(input) {
	var chars = "0123456789";
	return containsCharsOnly(input,chars);
}
function isNumberminus(input) {
	var chars = "-0123456789";
	return containsCharsOnly(input,chars);
}
function isNumberdot(input) {
	var chars = ".0123456789";
	return containsCharsOnly(input,chars);
}
function isNumberminusdot(input) {
	var chars = "-.0123456789";
	return containsCharsOnly(input,chars);
}
function isNumberalphabet(input) {
	var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	return containsCharsOnly(input,chars);
}
function isNumberdash(input) {
	var chars = "-0123456789";
	for (var inx = 0; inx < input.length; inx++) {
		if (chars.indexOf(input.charAt(inx)) == -1)	return false;
	}
	return true;
}

function CheckInt(number) {
	number = number.replace(/[^0-9]/gi,"");
	return number;
}

//체크값, 양수, 소수
function CheckNumber(number, plus, dot) {
	if(number.indexOf('.') ==  -1) {
		number = parseFloat(number,10).toString();
		number = number.replace(/[^0-9]/gi,"").length > plus ? number.replace(/[^0-9]/gi,"").substr(0,plus) : number.replace(/[^0-9]/gi,"");
	} else {
		number = number.substr(0,number.indexOf('.')).replace(/[^0-9]/gi,"") + '.' + (number.substr(number.indexOf('.')+1).replace(/[^0-9]/gi,"").length > dot ? number.substr(number.indexOf('.')+1).replace(/[^0-9]/gi,"").substr(0,dot) : number.substr(number.indexOf('.')+1).replace(/[^0-9]/gi,""));
	}
	return number;
}

//상품코드 점검
function CheckBitmcd1(bitmcd1, next, select) {
	if (!isNumberalphabet(bitmcd1.value)) {
		SetMessage('숫자,영문자 외 입력할 수 없습니다.');
		bitmcd1.value = "";
		bitmcd1.focus();
		return;
	}
	if(bitmcd1.value.length == 9) {
		if(select == 'Y') next.select();
		next.focus();
	}
}

function CheckBitmcd2(bitmcd1, bitmcd2, next, select) {
	if (!isNumberalphabet(bitmcd2.value)) {
		SetMessage('숫자,영문자 외 입력할 수 없습니다.');
		bitmcd2.value = "";
		bitmcd2.focus();
		return;
	}
	if (bitmcd2.value.length == 9) {
		if (bitmcd1.value != "" && bitmcd2.value != "") {
			if (bitmcd1.value > bitmcd2.value) {
				SetMessage('[상품코드]의 범위를 확인하십시요');
				bitmcd2.value = "";
				bitmcd2.focus();
				return false;
			} else {
				if(select == 'Y') next.select();
				next.focus();
			}
		}
	}
}

function ConvBitmcd(bitmcd) {
	if (!isNumberalphabet(bitmcd.value)) {
		SetMessage('숫자,영문자 외 입력할 수 없습니다.');
		bitmcd.value = '';
		bitmcd.focus();
		return '';
	}
	
	var conv_bitmcd = bitmcd.value.substring(0,2) + '0' + bitmcd.value.substring(2,7) + '0' + (bitmcd.value.length == 9 ? bitmcd.value.substring(7,9) : '');
	return conv_bitmcd;
}

//범위로 된 필드 점검
function CheckField1(str1, siz, next, select){
	if (!isNumber(str1.value)){
		SetMessage('문자는 입력받을 수 없습니다.');
		str1.value = "";
		str1.focus();
		return;
	}
	if(str1.value.length == siz){
		if(select == 'Y') next.select();
		next.focus();
	}
}

function CheckField2(str1, siz, str2, name, next, select){
	if (!isNumber(str2.value)){
		SetMessage('문자는 입력받을 수 없습니다.');
		str2.value = "";
		str2.focus();
		return;
	}
	if (str2.value.length == siz){
		if (str1.value != "" && str2.value != ""){
			if (str1.value > str2.value){
				SetMessage(name+'의 범위를 확인하십시요.');
				str2.value = "";
				str2.focus();
				return false;
			}else{
				if(select == 'Y') next.select();
				next.focus();
			}
		}
	}
}

//SUBMIT전 필드점검
function StrCheck(str, len, name){
	if(str.value == '' || str.value.length != len){
		SetMessage(name + '를 입력하십시요');
		str.select();
		str.focus();
		return false;
	}
	if(!isNumber(str.value)){
		SetMessage(name + '에는 문자가 올수 없습니다');
		str.select();
		str.focus();
		return false;
	}
	return true;
}

//두개 비교
function StrCompare(str1, str2, str3, name){
	if (str1.value > str2.value){
		SetMessage(name + '의 범위가 틀립니다');
		//SetMessage(str1.value + str2.value);
		str3.select();
		str3.focus();
		return false;
	}
	return true;
}

//SUBMIT전 필드점검
function IntCheck(str, name){
	if(str.value == ''){
		SetMessage(name + '를 입력하십시요');
		str.select();
		str.focus();
		return false;
	}
	if(!isNumber(str.value)){
		SetMessage(name + '에는 문자가 올수 없습니다');
		str.select();
		str.focus();
		return false;
	}
	return true;
}

//두개 비교
function IntCompare(str1, str2, str3, name){
	if (parseInt(str1.value,10) > parseInt(str2.value,10)){
		SetMessage(name + '의 범위가 틀립니다');
		str3.select();
		str3.focus();
		return false;
	}
	return true;
}

//SUBMIT전 필드점검 : 알파벳포함
function StrACheck(str, len, name) {
	if(str.value == '' || str.value.length != len){
		SetMessage(name + '를 입력하십시요');
		str.select();
		str.focus();
		return false;
	}
	if(!isNumberalphabet(str.value)){
		SetMessage(name + '에는 숫자,영문자 외 문자는 올수 없습니다');
		str.select();
		str.focus();
		return false;
	}
	return true;
}

//SUBMIT전 필드점검 : 기호
function StrChCheck(str, len, name, ch) {
	if(str.value == '' || str.value.length != len){
		SetMessage(name + '를 입력하십시요');
		str.select();
		str.focus();
		return false;
	}
	if(!isNumberChar(str.value, ch)) {
		SetMessage(name + '에는 숫자,영문자 외 문자는 올수 없습니다');
		str.select();
		str.focus();
		return false;
	}
	return true;
}

//말일구하기
function MakeYmd(year,month) {
	var dayOfMonth = "31:28:31:30:31:30:31:31:30:31:30:31".split(":");
	var days = dayOfMonth[parseInt(month,10)-1];
	if(month == '08') days = dayOfMonth[7];
	if(month == '09') days = dayOfMonth[8];
	if((year%4==0 && year%100 != 0 && month == '02') || (year%400 ==0 && month == '02'))
		days = 29;
	return days;	
}

//콤마넣기, 콤마빼기
function AddComma(val) {
	str = '';
	str = val.toString();
	strs = str.split('.');
	str = KillComma(strs[0]); check='';

	if(str.substring(0,1)=='-') {
		str = str.substring(1,str.length);
		check='-';
	}
	addcomma='';
	for(i=str.length-3; i>=1; i=i-3){
		addcomma = ',' + str.substring(i,i+3) + addcomma;
	}
	addcomma = str.substring(0,i+3) + addcomma;
	if(check=='-') addcomma = '-' + addcomma;	

	return (strs.length == 2) ? (addcomma + '.' + strs[1]) : addcomma;
}

function KillComma(str) {
	killcomma=''; 
	str1 = ''; 
	str1 = str;
	for(i=0; i<str1.length; i++){
		substr = str1.substring(i,i+1);
		if(substr != ',')
		killcomma += substr;
	}
	return killcomma;
}

function CheckBytes(str, maxlen) {
	var strlen = 0;
	var uselen = 0;

	for (var i=0; i<str.value.length; i++) {
		var onechar = str.value.charAt(i);
		//한글일 경우
        if (escape(onechar).length > 4) {
                strlen += 2;
        } else {
                strlen ++;
        }
        
		if(strlen > maxlen) {
            SetMessage('한글 '+(maxlen/2)+'자, 영문 '+maxlen+'자 까지 가능합니다.');
            str.value = str.value.substring(0,i);
            return false;
        }
	}
	
	return true;
}

function CheckBnotxt(str) {
    var tmpStr = str.value;
    var tcount = 0;
    for (var i=0; i<tmpStr.length; i++) {
        if(tmpStr.substring(i,i+1) == '"' || tmpStr.substring(i,i+1) == '\'') {
        	SetMessage(' [\'] 또는 ["] 는 사용할수 없습니다.');
        	str.value = str.value.substring(0,i);
        	return false;
        }
    }
    return true;
}

function GetBytes(str, len1, len2) {
	var strlen = 0;
	var tmpstr = '';

	for (var i=0; i<str.length; i++) {
		var onechar = str.charAt(i);
		//한글일 경우
        if (escape(onechar).length > 4) {
                strlen += 2;
        } else {
                strlen ++;
        }
		
		if(strlen > len1 && strlen <= len2) {
			tmpstr += onechar;
		}
	}
	return tmpstr;
}

//현재일자, 추가년수, 추가월수, 추가일수
function GetSearchDate(curymd, addyy, addmm, adddd){	
	var curyy = curymd.substr(0,4);
	var curmm = curymd.substr(4,2) - 1;
	var curdd = curymd.substr(6,2);
    
	now = new Date(curyy, curmm, curdd);
	
	now.setFullYear(now.getFullYear() + addyy);	//추가년수를 더함
	now.setMonth   (now.getMonth()    + addmm);	//추가월수를 더함
	now.setDate    (now.getDate()     + adddd);	//추가일수를 더함

	var newyy = now.getFullYear();
	var newmm = now.getMonth()+1;
	var newdd = now.getDate();
	
	if ((''+newmm).length == 1) newmm = '0' + newmm;
	if ((''+newdd).length == 1) newdd = '0' + newdd;
	return (newyy +''+ newmm +''+ newdd);
}

function Detail(form, btn) {
	var allSpan = eval(form+'.all.tags("span")');
	if (allSpan.length > 0) {
		for (i=0; i<allSpan.length; i++) {
			var n = allSpan[i].id;
			if(eval(btn).innerText == "요약" || eval(btn).value == "요약") allSpan[i].style.display = "none";
			else allSpan[i].style.display = "block";
		}

		if(eval(btn).innerText == "요약") eval(btn).innerText = "상세";
		else if(eval(btn).value == "요약") eval(btn).value = "상세";
		else if(eval(btn).innerText == "상세") eval(btn).innerText = "요약";
		else eval(btn).value = "요약";
	}
}

function Tree(currMenu) {
	thisMenu = eval(currMenu + ".style");
	if (thisMenu.display == "block") {
		thisMenu.display = "none";
	} else {
		thisMenu.display = "block";
	}
}

function DetailDiv(form, btn) {
	var allDivs = eval(form+'.all.tags("div")');
	var cnt = 0;
	for(var i = 0; i < allDivs.length; i++) {
		if(allDivs[i].id.length > 4 && allDivs[i].id.substring(0,4) == 'step') {
			if(eval(btn).innerText == '요약' || eval(btn).value == '요약') allDivs[i].style.display = 'none';
			else allDivs[i].style.display = 'block';
			cnt++;
		}
	}
	if(cnt > 0) {
		if(eval(btn).innerText == '요약') eval(btn).innerText = '상세';
		else if(eval(btn).value == '요약') eval(btn).value = '상세';
		else if(eval(btn).innerText == '상세') eval(btn).innerText = '요약';
		else eval(btn).value = '요약';
	}
}

function SetButton(Btn_Name, Btn_Type) {
	var Btn_Names = Btn_Name.split('|');
	var Btn_Types = Btn_Type.split('|');
	for(var i=0; i<Btn_Names.length; i++) {
		eval(Btn_Names[i]).disabled = (Btn_Types[i]=='0');
		if(eval(Btn_Names[i]).disabled && eval(Btn_Names[i]).type == 'checkbox') eval(Btn_Names[i]).checked = false;
	}
}

function GetButton(Btn_Name) {
	var Btn_Names = Btn_Name.split('|');
	var Btn_Types = '';
	for(var i = 0; i < Btn_Names.length; i++) {
		Btn_Types += (i == 0 ? '' : '|') + (eval(Btn_Names[i]).disabled ? '0' : '1');
	}
	return Btn_Types;
}

function OffButton(Btn_Name) {
	var btnset = GetButton(Btn_Name);
	
	var Btn_Names = Btn_Name.split('|');
	var Btn_Types = '';
	for(var i = 0; i < Btn_Names.length; i++) {
		Btn_Types += (i == 0 ? '' : '|') + ('0');
	}

	SetButton(Btn_Name,Btn_Types);
	
	return btnset;
}

//일범위제한
function CheckLimit(ymd1, ymd2, limit, yy2) {	//일자1, 일자2, 제한일수, 포커스
	var day1 = new Date(parseInt(ymd1.value.substring(0,4),10),parseInt(ymd1.value.substring(4,6),10)-1,parseInt(ymd1.value.substring(6,8),10));
	var day2 = new Date(parseInt(ymd2.value.substring(0,4),10),parseInt(ymd2.value.substring(4,6),10)-1,parseInt(ymd2.value.substring(6,8),10));
	var result = 0;
	result = (day2-day1)/1000/60/60/24;
	
	if(result<0) {
		SetMessage('일자범위가 올바르지 않습니다.');
		yy2.select();
		yy2.focus();
		return false;
	}
	if(result>limit) {
		SetMessage('시스템 과부하 방지를 위해 일자범위를 '+limit+'일 이내로 제한합니다.');
		yy2.select();
		yy2.focus();
		return false;
	}
	return true;
}

//월범위제한
function CheckMMLimit(ym1, ym2, limit, yy2) {	//월1, 월2, 제한개월수, 포커스
	var day1 = new Date(parseInt(ym1.value.substring(0,4),10),parseInt(ym1.value.substring(4,6),10)-1,1);
	var day2 = new Date(parseInt(ym2.value.substring(0,4),10),parseInt(ym2.value.substring(4,6),10)-1,31);
	var result = 0;
	result = (day2-day1)/1000/60/60/24/30;
	
	if(result<0) {
		SetMessage('일자범위가 올바르지 않습니다.');
		yy2.select();
		yy2.focus();
		return false;
	}
	if(result>limit+1) {
		SetMessage('시스템 과부하 방지를 위해 월범위를 '+limit+'개월 이내로 제한합니다.');
		yy2.select();
		yy2.focus();
		return false;
	}
	return true;
}

//날짜와 날짜 사이의 일수를 리턴한다.
function getBetweenDay(yy1, mm1, dd1, yy2, mm2, dd2) {
	var rtnValue = 0;

	var yy = yy1 + "";
	var mm = mm1 + "";
	var dd = dd1 + "";
	var startDate = new Date(yy,(eval(mm)-1),dd);
	
	yy = yy2 + "";
	mm = mm2 + "";
	dd = dd2 + "";
	var endDate = new Date(yy,(eval(mm)-1),dd);
	
	rtnValue = ((endDate-startDate)/60/60/24/1000) + 1;

    return rtnValue;
}

//공백제거
function trim(strSource) {
	re = /(^\s*)|(\s*$)/g
	return strSource.replace(re, '');
}

//좌측공백제거
function ltrim(strSource) {
	re = /^ +/g;
	return strSource.replace(re, '');
}

//우측공백제거
function rtrim(strSource) {
	re = / +$/g;
	return strSource.replace(re, '');
}

//확장자체크
function isExt(bfname,bextnm) {
	var bextnms = bextnm.split('|');
	var ext;
	var idx = 0;
	while (bfname.substring(idx).indexOf(".") > -1) {
		idx = idx + bfname.substring(idx).indexOf(".") + 1;
	}
	ext = bfname.substring(idx).toUpperCase();
	for (var i=0; i<bextnms.length; i++) {
		if (ext.toUpperCase() == bextnms[i].toUpperCase()) {
			return true;
		}
	}
	return false;
}

//카드번호 체크
function CheckBprno(str, next) {
	if(!isNumber(str.value)) {
		alert("문자는 입력받을수 없습니다."); 
		str.value = "";
		str.focus();
		return;
	}
	if(str.value.length == 4) {
		next.focus();
	}
}

//선택된 option 값 가져오기
function GetOptVal(opt) {
	val = '';
	for(var i = 0; i < opt.length; i++) {
		if(opt[i].checked) {
			val = opt[i].value;
			break;
		}
	}
	return val;
}

//지정한 option 값 선택하기
function SetOptVal(opt, val) {
	for(var i = 0; i < opt.length; i++) {
		if(opt[i].value == val) {
			opt[i].checked = true;
			break;
		}
	}
}

function SaveCompare(sav, str, name, next, select) {
	if (sav != str) {
		SetMessage(name + '가(이) 변경 되었습니다.\n조회 후 작업하십시오.');
		if(select == 'Y') next.select();
		next.focus();
		return false;
	}
	return true;
}
