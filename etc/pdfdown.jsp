import java.util.*;
import java.sql.*;
import java.text.*;
import java.awt.Color;

import java.io.File;
import java.io.IOException;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import java.text.NumberFormat;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.text.DecimalFormat;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

try{
    String deaDocTitle              = "";
    String strseller                = "";
    String strbuyer                 = "";
    String strPrvdName              = "";
    String strComName               = "";
    String strHeadNo                = "";
    String strConPrvdNo             = "";
    String strHeadOwnerName         = "";
    String strPrvdOwnerName         = "";
    String strHeadContrctInform     = "";
    String strBaseFee               = "";
    String strHeadBaseCnt           = "";
    String strHeadPmgName           = "";
    String strHeadCont              = "";
    String strHeadTerm              = "";
    String strHeadAccMonth          = "";
    String strHeadCpid              = "";
    String strCertCntTitle          = "";
    String strHeadDate              = "";
    String strHeadTryCnt            = "";
    String strHeadSuccCnt           = "";
    String strHeadAccCont           = "";
    String strHeadAllCnt            = "";
    String strHeadAllCntDetail      = "";
    String strHeadAccSuccCnt        = "";
    String strHeadAccSuccCntDetail  = "";
    String strHeadPrvdValue         = "";
    String strHeadPrvdValueDetail   = "";
    String strHeadVat               = "";
    String strHeadVatDetail         = "";
    String strHeadResultFee         = "";
    String strHeadResultFeeDetail   = "";

    Document document = new Document(PageSize.A4, 0, 0,50,50);
    ServletOutputStream output = response.getOutputStream();
    PdfWriter.getInstance(document, output);

    document.open();

    BaseFont bf = BaseFont.createFont("HYGoThic-Medium", "UniKS-UCS2-H", BaseFont.NOT_EMBEDDED);

    Font font = new Font(bf, 9, Font.NORMAL);
    Font title_font = new Font(bf, 20, Font.NORMAL);
    Font table_header_font = new Font(bf, 9, Font.HELVETICA);
    Font cert_font = new Font(bf, 10, Font.HELVETICA);
    Font corp_font = new Font(bf, 18, Font.HELVETICA);
    Font ceo_font = new Font(bf, 15, Font.HELVETICA);
    Font interval_font = new Font(bf, 2, Font.HELVETICA);

    String strJohaeStrtYmd = strFinalReqYm+"01";  //년월01
    String strJohaeEndYmd = kDu.getNowMonthLastYmd(strFinalReqYm+"01").substring(6,8);
    strJohaeEndYmd = strFinalReqYm + strJohaeEndYmd;

    //타이틀
    Image logo = Image.getInstance("logo.png");

    logo.scaleAbsolute(80,30);
    logo.setAbsolutePosition(60,770);

    document.add(logo);

    deaDocTitle    = "거래명세서";

    Paragraph title = new Paragraph(deaDocTitle, title_font);

    document.add(new Paragraph("\r\n"));

    title.setAlignment(Element.ALIGN_CENTER);

    document.add(title);
    document.add(new Paragraph("\r\n"));

    String docNumberYM = strFinalReqYm.substring(2,6);

    Paragraph content_num = new Paragraph("                   문서번호 : KMC"+docNumberYM+"-"+strdocNumber+"                                                           [단위 : 월, 원, 건 / VAT별도]" , font);
    document.add(content_num);

    Paragraph interval = new Paragraph("  ", interval_font);

    document.add(interval);

    //상단 테이블 

    PdfPTable table1 = new PdfPTable(9);

    table1.setWidths(new int[]{40,25,25,25,40,30,25,25,25});

    PdfPCell title1 = new PdfPCell(new Paragraph(strseller,table_header_font));
    PdfPCell title2 = new PdfPCell(new Paragraph(strbuyer,table_header_font));

    title1.setColspan(4);
    title2.setColspan(5);
    title1.setBackgroundColor(new Color(153,204,255));
    title2.setBackgroundColor(new Color(153,204,255));
    
    title1.setFixedHeight(17);
    title2.setFixedHeight(17);

    //가로 정렬
    title1.setHorizontalAlignment(Element.ALIGN_CENTER);
    title2.setHorizontalAlignment(Element.ALIGN_CENTER);

    //세로 정렬
    title1.setVerticalAlignment(Element.ALIGN_MIDDLE);
    title2.setVerticalAlignment(Element.ALIGN_MIDDLE);

    table1.addCell(title1);
    table1.addCell(title2);

    PdfPCell Cell1_1 = new PdfPCell(new Paragraph(strPrvdName,font));
    Cell1_1.setColspan(1);
    Cell1_1.setFixedHeight(17);
    Cell1_1.setHorizontalAlignment(Element.ALIGN_CENTER);
    Cell1_1.setVerticalAlignment(Element.ALIGN_MIDDLE);
    Cell1_1.setBackgroundColor(new Color(153,204,255));
    table1.addCell(Cell1_1);

    PdfPCell Cell1_2 = new PdfPCell(new Paragraph(strComName,font));
    Cell1_2.setColspan(3);
    Cell1_2.setFixedHeight(17);
    Cell1_2.setHorizontalAlignment(Element.ALIGN_CENTER);
    Cell1_2.setVerticalAlignment(Element.ALIGN_MIDDLE);
    table1.addCell(Cell1_2);

    PdfPCell Cell1_3 = new PdfPCell(new Paragraph(strPrvdName,font));
    Cell1_3.setColspan(1);
    Cell1_3.setFixedHeight(17);                    
    Cell1_3.setHorizontalAlignment(Element.ALIGN_CENTER);                    
    Cell1_3.setVerticalAlignment(Element.ALIGN_MIDDLE);
    Cell1_3.setBackgroundColor(new Color(153,204,255));
    table1.addCell(Cell1_3);

    PdfPCell Cell1_4 = new PdfPCell(new Paragraph(strcompanyName,font));
    Cell1_4.setColspan(4);
    Cell1_4.setFixedHeight(17);                    
    Cell1_4.setHorizontalAlignment(Element.ALIGN_CENTER);                    
    Cell1_4.setVerticalAlignment(Element.ALIGN_MIDDLE);
    table1.addCell(Cell1_4);

    PdfPCell Cell1_5 = new PdfPCell(new Paragraph(strHeadNo,font));
    Cell1_5.setColspan(1);
    Cell1_5.setFixedHeight(17);
    Cell1_5.setHorizontalAlignment(Element.ALIGN_CENTER);    
    Cell1_5.setVerticalAlignment(Element.ALIGN_MIDDLE);
    Cell1_5.setBackgroundColor(new Color(153,204,255));
    table1.addCell(Cell1_5);

    PdfPCell Cell1_6 = new PdfPCell(new Paragraph(strConPrvdNo,font));
    Cell1_6.setColspan(3);
    Cell1_6.setFixedHeight(17);
    Cell1_6.setHorizontalAlignment(Element.ALIGN_CENTER);        
    Cell1_6.setVerticalAlignment(Element.ALIGN_MIDDLE);
    table1.addCell(Cell1_6);

    PdfPCell Cell1_7 = new PdfPCell(new Paragraph(strHeadNo,font));
    Cell1_7.setColspan(1);
    Cell1_7.setFixedHeight(17);                
    Cell1_7.setHorizontalAlignment(Element.ALIGN_CENTER);    
    Cell1_7.setVerticalAlignment(Element.ALIGN_MIDDLE);
    Cell1_7.setBackgroundColor(new Color(153,204,255));
    table1.addCell(Cell1_7);

    PdfPCell Cell1_8 = new PdfPCell(new Paragraph(strcompanyNo,font));
    Cell1_8.setFixedHeight(17);        
    Cell1_8.setColspan(4);
    Cell1_8.setHorizontalAlignment(Element.ALIGN_CENTER);                        
    Cell1_8.setVerticalAlignment(Element.ALIGN_MIDDLE);
    table1.addCell(Cell1_8);

    PdfPCell Cell1_9 = new PdfPCell(new Paragraph(strHeadOwnerName,font));
    Cell1_9.setColspan(1);
    Cell1_9.setFixedHeight(17);
    Cell1_9.setHorizontalAlignment(Element.ALIGN_CENTER);                        
    Cell1_9.setVerticalAlignment(Element.ALIGN_MIDDLE);
    Cell1_9.setBackgroundColor(new Color(153,204,255));
    table1.addCell(Cell1_9);

    PdfPCell Cell1_10 = new PdfPCell(new Paragraph(strPrvdOwnerName,font));
    Cell1_10.setColspan(3);
    Cell1_10.setFixedHeight(17);                
    Cell1_10.setHorizontalAlignment(Element.ALIGN_CENTER);        
    Cell1_10.setVerticalAlignment(Element.ALIGN_MIDDLE);
    table1.addCell(Cell1_10);

    PdfPCell Cell1_11 = new PdfPCell(new Paragraph(strHeadOwnerName,font));
    Cell1_11.setColspan(1);
    Cell1_11.setFixedHeight(17);                    
    Cell1_11.setHorizontalAlignment(Element.ALIGN_CENTER);                
    Cell1_11.setVerticalAlignment(Element.ALIGN_MIDDLE);
    Cell1_11.setBackgroundColor(new Color(153,204,255));
    table1.addCell(Cell1_11);

    PdfPCell Cell1_12 = new PdfPCell(new Paragraph(strownerName,font));
    Cell1_12.setColspan(4);
    Cell1_12.setFixedHeight(17);                    
    Cell1_12.setHorizontalAlignment(Element.ALIGN_CENTER);                        
    Cell1_12.setVerticalAlignment(Element.ALIGN_MIDDLE);
    table1.addCell(Cell1_12);

    PdfPCell title2_1 = new PdfPCell(new Paragraph(strHeadContrctInform,table_header_font));
    title2_1.setColspan(9);
    title2_1.setBackgroundColor(new Color(153,204,255));
    title2_1 .setFixedHeight(17);
    title2_1.setHorizontalAlignment(Element.ALIGN_CENTER);
    title2_1.setVerticalAlignment(Element.ALIGN_MIDDLE);
    table1.addCell(title2_1);

    PdfPCell Cell2_1 = new PdfPCell(new Paragraph(strBaseFee,font));
    Cell2_1.setColspan(2);
    Cell2_1.setFixedHeight(17);                            
    Cell2_1.setHorizontalAlignment(Element.ALIGN_CENTER);        
    Cell2_1.setVerticalAlignment(Element.ALIGN_MIDDLE);
    table1.addCell(Cell2_1);

    PdfPCell Cell2_2 = new PdfPCell(new Paragraph(strHeadBaseCnt,font));
    Cell2_2.setColspan(2);
    Cell2_2.setFixedHeight(17);                
    Cell2_2.setHorizontalAlignment(Element.ALIGN_CENTER);                
    Cell2_2.setVerticalAlignment(Element.ALIGN_MIDDLE);
    table1.addCell(Cell2_2);

    PdfPCell Cell2_3 = new PdfPCell(new Paragraph("인증("+stricmName+")건당",font));
    Cell2_3.setColspan(3);
    Cell2_3.setFixedHeight(17);            
    Cell2_3.setHorizontalAlignment(Element.ALIGN_CENTER);            
    Cell2_3.setVerticalAlignment(Element.ALIGN_MIDDLE);
    table1.addCell(Cell2_3);

    PdfPCell Cell2_4 = new PdfPCell(new Paragraph(strHeadPmgName,font));
    Cell2_4.setColspan(2);
    Cell2_4.setFixedHeight(17);                
    Cell2_4.setHorizontalAlignment(Element.ALIGN_CENTER);            
    Cell2_4.setVerticalAlignment(Element.ALIGN_MIDDLE);
    table1.addCell(Cell2_4);

    PdfPCell Cell2_5 = new PdfPCell(new Paragraph(strcomma_baseCharge,font));
    Cell2_5.setColspan(2);
    Cell2_5.setFixedHeight(17);                
    Cell2_5.setHorizontalAlignment(Element.ALIGN_CENTER);            
    Cell2_5.setVerticalAlignment(Element.ALIGN_MIDDLE);
    table1.addCell(Cell2_5);

    PdfPCell Cell2_6 = new PdfPCell(new Paragraph(strcomma_baseCnt,font));
    Cell2_6.setColspan(2);
    Cell2_6.setFixedHeight(17);            
    Cell2_6.setHorizontalAlignment(Element.ALIGN_CENTER);                        
    Cell2_6.setVerticalAlignment(Element.ALIGN_MIDDLE);
    table1.addCell(Cell2_6);

    PdfPCell Cell2_7 = new PdfPCell(new Paragraph(strstrBaseHpAmt,font));
    Cell2_7.setColspan(3);
    Cell2_7.setFixedHeight(17);                    
    Cell2_7.setHorizontalAlignment(Element.ALIGN_CENTER);                    
    Cell2_7.setVerticalAlignment(Element.ALIGN_MIDDLE);
    table1.addCell(Cell2_7);

    PdfPCell Cell2_8 = new PdfPCell(new Paragraph("111",font));
    Cell2_8.setColspan(2);
    Cell2_8.setFixedHeight(17);                    
    Cell2_8.setHorizontalAlignment(Element.ALIGN_CENTER);                    
    Cell2_8.setVerticalAlignment(Element.ALIGN_MIDDLE);
    table1.addCell(Cell2_8);

    PdfPCell title3_1 = new PdfPCell(new Paragraph(strHeadCont,table_header_font));
    title3_1.setColspan(9);
    title3_1.setBackgroundColor(new Color(153,204,255));
    title3_1.setHorizontalAlignment(Element.ALIGN_CENTER);    
    title3_1.setVerticalAlignment(Element.ALIGN_MIDDLE);
    title3_1.setFixedHeight(17);
    table1.addCell(title3_1);

    PdfPCell Cell3_1 = new PdfPCell(new Paragraph(strHeadTerm,font));
    Cell3_1.setColspan(1);
    Cell3_1.setFixedHeight(17);    
    Cell3_1.setHorizontalAlignment(Element.ALIGN_CENTER);                    
    Cell3_1.setVerticalAlignment(Element.ALIGN_MIDDLE);
    table1.addCell(Cell3_1);

    PdfPCell Cell3_2 = new PdfPCell(new Paragraph(Term_Date,font));
    Cell3_2.setColspan(3);
    Cell3_2.setFixedHeight(17);                
    Cell3_2.setHorizontalAlignment(Element.ALIGN_CENTER);                
    Cell3_2.setVerticalAlignment(Element.ALIGN_MIDDLE);
    table1.addCell(Cell3_2);

    PdfPCell Cell3_3 = new PdfPCell(new Paragraph(strHeadAccMonth,font));
    Cell3_3.setColspan(1);
    Cell3_3.setFixedHeight(17);                    
    Cell3_3.setHorizontalAlignment(Element.ALIGN_CENTER);                    
    Cell3_3.setVerticalAlignment(Element.ALIGN_MIDDLE);
    table1.addCell(Cell3_3);

    PdfPCell Cell3_4 = new PdfPCell(new Paragraph(strFinalReqYm,font));
    Cell3_4.setColspan(1);
    Cell3_4.setFixedHeight(17);            
    Cell3_4.setHorizontalAlignment(Element.ALIGN_CENTER);
    Cell3_4.setVerticalAlignment(Element.ALIGN_MIDDLE);
    table1.addCell(Cell3_4);

    PdfPCell Cell3_5 = new PdfPCell(new Paragraph(strHeadCpid,font));
    Cell3_5.setColspan(1);
    Cell3_5.setFixedHeight(17);                                                    
    Cell3_5.setHorizontalAlignment(Element.ALIGN_CENTER);                        
    Cell3_5.setVerticalAlignment(Element.ALIGN_MIDDLE);
    table1.addCell(Cell3_5);

    PdfPCell Cell3_6 = new PdfPCell(new Paragraph(strPrvdIdForm,font));
    Cell3_6.setColspan(4);
    Cell3_6.setFixedHeight(17);                    
    Cell3_6.setHorizontalAlignment(Element.ALIGN_CENTER);                
    Cell3_6.setVerticalAlignment(Element.ALIGN_MIDDLE);
    table1.addCell(Cell3_6);

    document.add(table1);

    Paragraph table1_bottom1 = new Paragraph("222222222222222222222", font);
    document.add(table1_bottom1);

    document.add(interval);
    document.add(interval);
    document.add(interval);
    document.add(interval);
    document.add(interval);

    Paragraph certification_cont = new Paragraph(strCertCntTitle, cert_font);
    document.add(certification_cont);
    document.add(interval);

    PdfPTable table4 = new PdfPTable(9);
    table4.setWidths(new int[]{15,15,15,15,15,15,15,15,15});
    PdfPCell title4_1 = new PdfPCell(new Paragraph(strHeadDate,font));
    PdfPCell title4_2 = new PdfPCell(new Paragraph(strHeadTryCnt,font));
    PdfPCell title4_3 = new PdfPCell(new Paragraph(strHeadSuccCnt,font));
    PdfPCell title4_4 = new PdfPCell(new Paragraph(strHeadDate,font));
    PdfPCell title4_5 = new PdfPCell(new Paragraph(strHeadTryCnt,font));
    PdfPCell title4_6 = new PdfPCell(new Paragraph(strHeadSuccCnt,font));
    PdfPCell title4_7 = new PdfPCell(new Paragraph(strHeadDate,font));
    PdfPCell title4_8 = new PdfPCell(new Paragraph(strHeadTryCnt,font));
    PdfPCell title4_9 = new PdfPCell(new Paragraph(strHeadSuccCnt,font));

    title4_1.setHorizontalAlignment(Element.ALIGN_CENTER);
    title4_2.setHorizontalAlignment(Element.ALIGN_CENTER);
    title4_3.setHorizontalAlignment(Element.ALIGN_CENTER);
    title4_4.setHorizontalAlignment(Element.ALIGN_CENTER);
    title4_5.setHorizontalAlignment(Element.ALIGN_CENTER);
    title4_6.setHorizontalAlignment(Element.ALIGN_CENTER);
    title4_7.setHorizontalAlignment(Element.ALIGN_CENTER);
    title4_8.setHorizontalAlignment(Element.ALIGN_CENTER);
    title4_9.setHorizontalAlignment(Element.ALIGN_CENTER);

    title4_1.setVerticalAlignment(Element.ALIGN_MIDDLE);
    title4_2.setVerticalAlignment(Element.ALIGN_MIDDLE);
    title4_3.setVerticalAlignment(Element.ALIGN_MIDDLE);
    title4_4.setVerticalAlignment(Element.ALIGN_MIDDLE);
    title4_5.setVerticalAlignment(Element.ALIGN_MIDDLE);
    title4_6.setVerticalAlignment(Element.ALIGN_MIDDLE);
    title4_7.setVerticalAlignment(Element.ALIGN_MIDDLE);
    title4_8.setVerticalAlignment(Element.ALIGN_MIDDLE);
    title4_9.setVerticalAlignment(Element.ALIGN_MIDDLE);

    title4_1.setFixedHeight(17);
    title4_2.setFixedHeight(17);
    title4_3.setFixedHeight(17);
    title4_4.setFixedHeight(17);
    title4_5.setFixedHeight(17);
    title4_6.setFixedHeight(17);
    title4_7.setFixedHeight(17);
    title4_8.setFixedHeight(17);
    title4_9.setFixedHeight(17);

    title4_1.setBackgroundColor(new Color(153,204,255));
    title4_2.setBackgroundColor(new Color(153,204,255));
    title4_3.setBackgroundColor(new Color(153,204,255));
    title4_4.setBackgroundColor(new Color(153,204,255));
    title4_5.setBackgroundColor(new Color(153,204,255));
    title4_6.setBackgroundColor(new Color(153,204,255));
    title4_7.setBackgroundColor(new Color(153,204,255));
    title4_8.setBackgroundColor(new Color(153,204,255));
    title4_9.setBackgroundColor(new Color(153,204,255));

    table4.addCell(title4_1);
    table4.addCell(title4_2);
    table4.addCell(title4_3);
    table4.addCell(title4_4);
    table4.addCell(title4_5);
    table4.addCell(title4_6);
    table4.addCell(title4_7);
    table4.addCell(title4_8);
    table4.addCell(title4_9);

    PdfPCell Cell4_1 = new PdfPCell(new Paragraph(strMonth +"/01",font));
    Cell4_1.setFixedHeight(17);
    Cell4_1.setHorizontalAlignment(Element.ALIGN_CENTER);
    Cell4_1.setVerticalAlignment(Element.ALIGN_MIDDLE);
    
    PdfPCell Cell4_2 = new PdfPCell(new Paragraph(strDayTry[0],font));
    Cell4_2.setFixedHeight(17);
    Cell4_2.setHorizontalAlignment(Element.ALIGN_RIGHT);
    Cell4_2.setVerticalAlignment(Element.ALIGN_MIDDLE);

    PdfPCell Cell4_3 = new PdfPCell(new Paragraph(strDaySucc[0],font));
    Cell4_3.setFixedHeight(17);
    Cell4_3.setHorizontalAlignment(Element.ALIGN_RIGHT);
    Cell4_3.setVerticalAlignment(Element.ALIGN_MIDDLE);

    PdfPCell Cell4_4 = new PdfPCell(new Paragraph(strMonth +"/11",font));
    Cell4_4.setFixedHeight(17);
    Cell4_4.setHorizontalAlignment(Element.ALIGN_CENTER);
    Cell4_4.setVerticalAlignment(Element.ALIGN_MIDDLE);

    PdfPCell Cell4_5 = new PdfPCell(new Paragraph(strDayTry[10],font));
    Cell4_5.setFixedHeight(17);
    Cell4_5.setHorizontalAlignment(Element.ALIGN_RIGHT);
    Cell4_5.setVerticalAlignment(Element.ALIGN_MIDDLE);
    
    PdfPCell Cell4_6 = new PdfPCell(new Paragraph(strDaySucc[10],font));
    Cell4_6.setFixedHeight(17);
    Cell4_6.setHorizontalAlignment(Element.ALIGN_RIGHT);
    Cell4_6.setVerticalAlignment(Element.ALIGN_MIDDLE);

    PdfPCell Cell4_7 = new PdfPCell(new Paragraph(strMonth +"/21",font));
    Cell4_7.setFixedHeight(17);
    Cell4_7.setHorizontalAlignment(Element.ALIGN_CENTER);
    Cell4_7.setVerticalAlignment(Element.ALIGN_MIDDLE);
    
    PdfPCell Cell4_8 = new PdfPCell(new Paragraph(strDayTry[20],font));
    Cell4_8.setFixedHeight(17);
    Cell4_8.setHorizontalAlignment(Element.ALIGN_RIGHT);
    Cell4_8.setVerticalAlignment(Element.ALIGN_MIDDLE);
    
    PdfPCell Cell4_9 = new PdfPCell(new Paragraph(strDaySucc[20],font));
    Cell4_9.setFixedHeight(17);
    Cell4_9.setHorizontalAlignment(Element.ALIGN_RIGHT);
    Cell4_9.setVerticalAlignment(Element.ALIGN_MIDDLE);

    PdfPCell Cell4_91 = new PdfPCell(new Paragraph(strMonth +"/31",font));
    Cell4_91.setFixedHeight(17);
    Cell4_91.setHorizontalAlignment(Element.ALIGN_CENTER);
    Cell4_91.setVerticalAlignment(Element.ALIGN_MIDDLE);
    

    PdfPCell Cell4_92 = new PdfPCell(new Paragraph(strDayTry[30],font));
    Cell4_92.setFixedHeight(17);
    Cell4_92.setHorizontalAlignment(Element.ALIGN_RIGHT);
    Cell4_92.setVerticalAlignment(Element.ALIGN_MIDDLE);
    

    PdfPCell Cell4_93 = new PdfPCell(new Paragraph(strDaySucc[30],font));
    Cell4_93.setFixedHeight(17);
    Cell4_93.setHorizontalAlignment(Element.ALIGN_RIGHT);
    Cell4_93.setVerticalAlignment(Element.ALIGN_MIDDLE);
    
    PdfPCell Cell4_gongback = new PdfPCell(new Paragraph("",font));
    Cell4_gongback.setFixedHeight(17);
    Cell4_gongback.setHorizontalAlignment(Element.ALIGN_CENTER);
    Cell4_gongback.setVerticalAlignment(Element.ALIGN_MIDDLE);
    

    table4.addCell(Cell4_1);
    table4.addCell(Cell4_2);
    table4.addCell(Cell4_3);
    table4.addCell(Cell4_4);
    table4.addCell(Cell4_5);
    table4.addCell(Cell4_6);
    table4.addCell(Cell4_7);
    table4.addCell(Cell4_8);
    table4.addCell(Cell4_9);

    table4.addCell(Cell4_gongback);
    table4.addCell(Cell4_gongback);
    table4.addCell(Cell4_gongback);
    table4.addCell(Cell4_gongback);
    table4.addCell(Cell4_gongback);
    table4.addCell(Cell4_gongback);
    table4.addCell(Cell4_91);
    table4.addCell(Cell4_92);
    table4.addCell(Cell4_93);

    document.add(table4);

    document.add(new Paragraph("\r\n"));

    Paragraph bottom1 = new Paragraph("33333333333333333333", font);

    document.add(bottom1);
    document.add(new Paragraph("\r\n"));

    Paragraph bottom2 = new Paragraph("121212121212121212121", corp_font);
    bottom2.setAlignment(Element.ALIGN_CENTER);
    document.add(bottom2);

    Paragraph bottom3 = new Paragraph("31313131313131313", ceo_font);
    bottom3.setAlignment(Element.ALIGN_CENTER);
    document.add(bottom3);

    Image stamp = Image.getInstance("xxxx.png");

    stamp.scaleAbsolute(50,50);

    stamp.setAbsolutePosition(385,100);

    document.add(stamp);

    document.close();

} catch (Exception ex) {
    ex.printStackTrace();
}
