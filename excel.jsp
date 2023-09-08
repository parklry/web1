<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ include file="/login/SessionCheck.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="com.ehwaseung.util.*" %>
<%@ page import="java.sql.*" %>

<%@ page import="java.io.File" %>
<%@ page import="java.io.FileOutputStream" %>

<%@ page import="org.apache.poi.ss.usermodel.IndexedColors" %>
<%@ page import="org.apache.poi.ss.util.CellRangeAddress" %>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFCell" %>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFCellStyle" %>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFColor" %>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFFont" %>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFRow" %>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFSheet" %>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFWorkbook" %>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFRichTextString" %>
<%
try {
    String bchgdt = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());

    String parm_bdlymd1 = request.getParameter("bdlymd1");
	String parm_bdlymd2 = request.getParameter("bdlymd2");
	String parm_bdliss1 = request.getParameter("bdliss1");
	String parm_bdliss2 = request.getParameter("bdliss2");
	String parm_bhopcd1 = request.getParameter("bhopcd1");
	String parm_bhopcd2 = request.getParameter("bhopcd2");
	String parm_bmallc1 = request.getParameter("bmallc1");
	String parm_bmallc2 = request.getParameter("bmallc2");
	String parm_bdltyp = request.getParameter("bdltyp");
	String parm_bcfmgu = request.getParameter("bcfmgu");
	String parm_findgu = request.getParameter("findgu");
	String parm_findnm = request.getParameter("findnm");

	ConnectionResource resource1 = null;
	Connection conn1 = null;
	PreparedStatement pstmt1 = null;
	ResultSet rs1 = null;

	String query = "";
	int tot1 = 0;
	String errmsg = "";

	try {
		resource1 = new ConnectionResource();
		conn1 = resource1.getConnection();

		XSSFWorkbook xssfWb = null; 
		XSSFSheet xssfSheet = null; 
		XSSFRow xssfRow = null; 
		XSSFCell xssfCell = null;

		int rowNo = 0; // 행의 갯수
		int colNo = 0; // 열의 갯수
		xssfWb = new XSSFWorkbook(); //XSSFWorkbook 객체 생성

        xssfSheet = xssfWb.createSheet("쿠팡로켓 확정자료"); // 워크시트 이름 설정
        rowNo = 0; // 행의 갯수 

        // 타이틀 1 ROW 1px * 15
        
        String[] temp_btitle = {"발주번호","발주유형","발주현황","SKU ID","SKU 이름","SKU Barcode","물류센터","입고예정일","발주일","발주수량","확정수량","입고수량","매입유형","면세여부","생산연도","제조일자","유통기한","매입가","공급가","부가세","총발주 매입금","입고금액"};
        xssfRow = xssfSheet.createRow(rowNo++); colNo = 0;
        for(int col = 0; col < temp_btitle.length; col++) {
            xssfCell = xssfRow.createCell((short)colNo++);
            xssfCell.setCellValue(temp_btitle[col]);
        }

        query = "SELECT T1.BDLYMD, T4.BDLTYP, T1.CORDNO, T1.BDLISS, T2.BMALLN, "
              + "       T1.CSKUID, T3.BITMNE, T3.BCOLR1, T3.BCOLR2, T1.BIZENO, " 
              + "       T4.BSIZE BBSIZE, CSKUID, T4.BSTDCD, T1.BDLQTY, T1.BPRCST, " 
              + "       T1.BDLCST, T1.BMALLC, T1.BDLINE "
              + "  FROM BIS.BDLDTP T1 "
              + "   INNER JOIN BIS.BHOPSP T2 ON 1=1 "
              + "       AND T2.BMALLC = T1.BMALLC "
              + "   INNER JOIN BIS.BITMAP T3 ON 1=1 "
              + "       AND T3.BITMCD = T1.BITMCD "
              + "   INNER JOIN BIS.BITEMP T4 ON 1=1 "
              + "       AND T4.BITMCD = T1.BITMCD "
              + "       AND T4.BIZENO = T1.BIZENO "
              + "   INNER JOIN USRMNG T5 ON 1=1 "
              + "       AND T5.USERID = T1.BCHGID "
              + "   INNER JOIN ( "
              + "       SELECT BMALLC, CASE WHEN COUNT(1) > 9 THEN '2' ELSE '1' END BDLTYP "
              + "         FROM BIS.BDLSMP T1 "
              + "        WHERE T1.BDLCOD = 'B' "
              + "          AND T1.BDLYMD BETWEEN '"+parm_bdlymd1+"' AND '"+parm_bdlymd2+"' "
              + "          AND T1.BDLISS BETWEEN  "+parm_bdliss1+"  AND  "+parm_bdliss2+"  "
              + "          AND T1.BHOPCD BETWEEN '"+parm_bhopcd1+"' AND '"+parm_bhopcd2+"' "
              + "          AND T1.BMALLC BETWEEN '"+parm_bmallc1+"' AND '"+parm_bmallc2+"' "
              + "        GROUP BY BMALLC "
              + "       ) T4 ON 1=1 "
              + "       AND T4.BMALLC = T1.BMALLC "
              + (parm_bdltyp.equals("T")?"":("AND T4.BDLTYP = '"+parm_bdltyp+"'"))
              + " WHERE T1.BDLCOD = 'B' "
              + "   AND T1.BDLYMD BETWEEN '"+parm_bdlymd1+"' AND '"+parm_bdlymd2+"' "
              + "   AND T1.BDLISS BETWEEN  "+parm_bdliss1+"  AND  "+parm_bdliss2+"  "
              + "   AND T1.BHOPCD BETWEEN '"+parm_bhopcd1+"' AND '"+parm_bhopcd2+"' "
              + "   AND T1.BMALLC BETWEEN '"+parm_bmallc1+"' AND '"+parm_bmallc2+"' "
              + "   AND T1.CORDNO != '' "
              + (parm_bcfmgu.equals("T")?"":("AND T1.BCFMGU = '"+parm_bcfmgu+"'"))
              + (parm_findgu.equals("T")?"":("AND "+parm_findgu+" LIKE '%"+parm_findnm+"%'"))
              + " ORDER BY BMALLC, BDLYMD, CORDNO, BDLISS, BDLINE "
              + "  WITH UR ";
		//out.println(query + "<br>");
		pstmt1 = conn1.prepareStatement(query);
		rs1 = pstmt1.executeQuery();
		while(rs1.next()) {
            xssfRow = xssfSheet.createRow(rowNo++); colNo = 0;
            xssfCell = xssfRow.createCell((short)colNo++); xssfCell.setCellValue(rs1.getString("CORDNO"));
            xssfCell = xssfRow.createCell((short)colNo++); xssfCell.setCellValue("일반");
            xssfCell = xssfRow.createCell((short)colNo++); xssfCell.setCellValue("거래처확인요청");
            xssfCell = xssfRow.createCell((short)colNo++); xssfCell.setCellValue(rs1.getString("CSKUID"));
            xssfCell = xssfRow.createCell((short)colNo++); xssfCell.setCellValue(rs1.getString("BITMNE")+" / "+rs1.getString("BCOLR1")+" / "+rs1.getString("BBSIZE"));
            xssfCell = xssfRow.createCell((short)colNo++); xssfCell.setCellValue(rs1.getString("BSTDCD"));
            xssfCell = xssfRow.createCell((short)colNo++); xssfCell.setCellValue(rs1.getString("BMALLN"));
            xssfCell = xssfRow.createCell((short)colNo++); xssfCell.setCellValue((rs1.getString("BDLYMD").substring(0,4)+"-"+rs1.getString("BDLYMD").substring(4,6)+"-"+rs1.getString("BDLYMD").substring(6,8)));
            xssfCell = xssfRow.createCell((short)colNo++); xssfCell.setCellValue("");
            xssfCell = xssfRow.createCell((short)colNo++); xssfCell.setCellValue("");
            xssfCell = xssfRow.createCell((short)colNo++); xssfCell.setCellValue(rs1.getString("BDLQTY"));
            xssfCell = xssfRow.createCell((short)colNo++); xssfCell.setCellValue("");
            xssfCell = xssfRow.createCell((short)colNo++); xssfCell.setCellValue("직매입");
            xssfCell = xssfRow.createCell((short)colNo++); xssfCell.setCellValue("N");
            xssfCell = xssfRow.createCell((short)colNo++); xssfCell.setCellValue("");
            xssfCell = xssfRow.createCell((short)colNo++); xssfCell.setCellValue("");
            xssfCell = xssfRow.createCell((short)colNo++); xssfCell.setCellValue("");
            xssfCell = xssfRow.createCell((short)colNo++); xssfCell.setCellValue("");
            xssfCell = xssfRow.createCell((short)colNo++); xssfCell.setCellValue(rs1.getString("BDLCST"));
            xssfCell = xssfRow.createCell((short)colNo++); xssfCell.setCellValue("");
            xssfCell = xssfRow.createCell((short)colNo++); xssfCell.setCellValue("");
            xssfCell = xssfRow.createCell((short)colNo++); xssfCell.setCellValue("");
            tot1++;
        }
        if(rs1 != null) try { rs1.close(); } catch(Exception ne) {}
        if(pstmt1 != null) try { pstmt1.close(); } catch(Exception ne) {}

        for(int col = 0; col < colNo; col++) {
            xssfSheet.autoSizeColumn(col); 
            xssfSheet.setColumnWidth(col, xssfSheet.getColumnWidth(col) + 512);
        }

		// 컨텐츠 타입과 파일명 지정
	    response.setContentType("application/vnd.ms-excel");
    	response.setHeader("Content-Disposition", "attachmente; filename="+java.net.URLEncoder.encode(bchgdt+"_쿠팡로켓 확정자료.xlsx","UTF-8").replace("+","%20")+";");
		if(request.getParameter("cookid") != null) response.setHeader("Set-Cookie",request.getParameter("cookid")+"=true; path=/");

	    out.clear();
	    out = pageContext.pushBody();

	    xssfWb.write(response.getOutputStream());
	    response.getOutputStream().close();

		if(resource1 != null) try { resource1.release(); } catch(Exception ne) {}
	} catch(SQLException sqlex) {
		out.println(sqlex); errmsg = "[자료다운] 처리중 오류가 발생하였습니다. 전산실로 문의하십시오. SQLException";
	} catch(NullPointerException npex) {
		out.println(npex); errmsg = "[자료다운] 처리중 오류가 발생하였습니다. 전산실로 문의하십시오. NullPointerException";
	} catch(Exception ex) {
		out.println(ex); if(errmsg.equals("")) errmsg = "[자료다운] 처리중 오류가 발생하였습니다. 전산실로 문의하십시오. Exception";
	} finally {
		if(rs1 != null) try { rs1.close(); } catch(Exception ne) {}
		if(pstmt1 != null) try { pstmt1.close(); } catch(Exception ne) {}
		if(resource1 != null) try { resource1.release(); } catch(Exception ne) {}
	}
%>
<% } catch(Exception ex) { out.println(ex); } %>
