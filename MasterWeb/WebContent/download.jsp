<%@page import="com.avalant.utility.EncryptUtil"%>
<%@page import="com.avalant.rms.utility.EncodeUtil"%>
<%@page import="com.master.util.MasterUtil"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.DataInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.net.URL"%>
<%@page import="com.avalant.feature.FT022_UploadFile"%>
<%
String filePath = request.getParameter("a");

try {
	if(MasterUtil.empty(filePath)) {
		out.print("<center><H3>File path is null!!!</H3></center>");
		return;
	}
	
	filePath = new EncryptUtil().deCrypt(filePath);
	
	if(!new File(filePath).isFile()) {
		out.print("<center><H3>Invalid File Path ["+filePath+"] !!!</H3></center>");
		return;
	}
	
	int BUFSIZE = 4096;
	File file = new File(filePath);
	int length   = 0;
	ServletOutputStream outStream = response.getOutputStream();
	ServletContext context  = getServletConfig().getServletContext();
	String mimetype = context.getMimeType(filePath);
	
	System.out.println("download mimetype >>>> " + mimetype);   

// 	sets response content type

	if (mimetype == null) {
		mimetype = "application/octet-stream; charset=UTF-8";
	}
	response.setContentType(mimetype);
	response.setContentLength((int)file.length());
	//response.setCharacterEncoding("UTF-8");
	
	String fileName = (new File(filePath)).getName();
	
	System.out.println("download fileName >>>> " + fileName);
	String origFileName = "";
	
	String browserType = request.getHeader("User-Agent");
	
	if (browserType.indexOf("MSIE") > -1) {
		// convert to ASCII
		StringBuffer ascii = new StringBuffer(fileName);
		int code;
		for(int i = 0; i < fileName.length(); i++) {
			code = (int)fileName.charAt(i);
			if ((0xE01<=code) && (code <= 0xE5B )) {
				ascii.setCharAt( i, (char)(code - 0xD60));
			}
		}
		origFileName = ascii.toString();
	}else{
		origFileName = URLEncoder.encode(fileName, "UTF-8");
		origFileName = URLDecoder.decode(origFileName, "ISO8859_1");
	}
	
// 	sets HTTP header
	response.setHeader("Content-Disposition", "attachment; filename=\""+origFileName+"\"");
	response.setHeader("language", "th-TH");
	byte[] byteBuffer = new byte[BUFSIZE];
	DataInputStream in = new DataInputStream(new FileInputStream(file));
	
// 	reads the file's bytes and writes them to the response stream
	while ((in != null) && ((length = in.read(byteBuffer)) != -1))
	{
		outStream.write(byteBuffer,0,length);
	}
	
	in.close();
	outStream.close();
} catch(Exception e) {
	out.println("download filePath >>>> " + filePath + " is error >>> " + e.getMessage());
	out.print("<center><H3>download filePath >>>> " + filePath + " is error >>> " + e.getMessage() + "</H3></center>");
}
%>