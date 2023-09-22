<% 
String strFilePath = request.getParameter("filePath"); if(strFilePath == null) strFilePath = "";
String strFileName = request.getParameter("fileName"); if(strFileName == null) strFileName = "";

String strBaseFilePath = "/wcappl/html/BSIS/BZ0000J/file";
if(strFilePath.equals("")) strFilePath = strBaseFilePath;

// Download file
java.io.File file = new java.io.File(strFilePath+"/"+strFileName);
byte b[] = new byte[(int)file.length()];

//if(strFileName != null) { strFileName = com.ehwaseung.ok.Kr.k2a(strFileName); }
//response.setHeader("Content-Disposition", "attachment;filename=" + strFileName + " ;");

response.setHeader("Content-Disposition", "attachment;filename=" + java.net.URLEncoder.encode(strFileName,"UTF-8").replace("+","%20") + " ;");
           
if (file.isFile())
{
	java.io.BufferedInputStream fin = new java.io.BufferedInputStream(new java.io.FileInputStream(file));
	
	java.io.BufferedOutputStream outs = new java.io.BufferedOutputStream(response.getOutputStream());
	
	int read = 0;
	try {
		while ((read = fin.read(b)) != -1){
		           outs.write(b,0,read);
		}
		outs.close();
		fin.close();
	} catch (Exception e) {
		System.out.println(e.getMessage());
	} finally {
		if(outs!=null) outs.close();
		if(fin!=null) fin.close();
	}
}
%>
