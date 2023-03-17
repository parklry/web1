package ;

import java.text.*;
import java.util.*;

public clas CommUtil {
  
    //null -> 공백
    public static String NullChange(String val) {
        if( val == null ) val = "";
        return val;
    }
    //현재날짜 8자리
    public static String getCurDate() {
    }
    //현재시간 6자리
    public static String getCurTime() {
    }
    //문자포맷 : 숫자,소수점,퍼센트
    
    //날짜,시간 Text - 구분자
    2023-01-01
    10:10
    getDispYmd(code,strGubn) 8,6 
    getDispHms(code,strGubn) 6,4
    
/**
 * 문자열의 바이크 길이 구하기
 * 인코딩 문자셋에 따라 바이크 길이 달라짐.
 *
 * @param str 문자열
 * @param charset 인코딩 문자셋
 * @return
 */
private int getByteLength(String str, String charset) {
  try {
    return str.getBytes(charset).length;
  } catch (Exception e) {
    e.printStackTrace();
  }
  return 0;
}
}
