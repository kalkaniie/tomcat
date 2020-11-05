<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*, java.io.*, org.apache.log4j.Logger, com.nara.jdf.http.*, com.nara.jdf.util.*, com.nara.jdf.data.*,com.nara.util.*" %>
<%@ include file = "/jsp/kor/common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%		
	
	Logger logger = Logger.getLogger(this.getClass());
	
	request.setCharacterEncoding("utf-8");
	
	System.out.println("FILE_SAVE.jsp1===>requestddddd "+ request.getParameter("fromBuddyNm"));
	HttpAttributes attr = getAttributes( request );
	DataSet input = attr.getDataSet();   

	System.out.println("FILE_SAVE.jsp===>attribute "+input.toString());
	String buddyIndex = attr.getString( "buddyIndex");
	System.out.println("#############################################" + input.toString());
	
	StringBuffer result = new StringBuffer();
	InputStream in = null;
	FileOutputStream fos = null;
	try
	{
		// com.nara.msg.note_file.dir=/usr/local/apache-tomcat-6.0.16/bin/notefile
		
		com.nara.jdf.Config conf = com.nara.jdf.Configuration.lookup("/com/nara/msg/note_file");
		com.nara.jdf.Config conf_fileserver = com.nara.jdf.Configuration.lookup("/com/nara/msg/fileserver");
		
		
		//String uploadPath 
		//= conf_fileserver.getString("serverfullpath", System.getProperty("user.dir")+File.separator+"notefile")+File.separator+com.nara.jdf.util.DateTime.getShortDateString();
		//String uploadPath = conf.getString("dir", File.separator+"notefile")+File.separator+com.nara.jdf.util.DateTime.getShortDateString();
		//String uploadPath = conf.getString("dir", "notefile")+File.separator+com.nara.jdf.util.DateTime.getShortDateString();
		
		
		String saveFileName = System.currentTimeMillis()+"";
		String localFileName = input.getText(buddyIndex+"_attachFile");
		/*
		File dir = new File(uploadPath);
		if(!dir.exists()) dir.mkdirs();   
		
		File file = new File(uploadPath+java.io.File.separator+saveFileName);
		
		String filePath = conf.getString("dir")+File.separator+com.nara.jdf.util.DateTime.getShortDateString()
			+ java.io.File.separator+saveFileName;
		
		fos = new FileOutputStream(file);
		in = attr.getInputStream(buddyIndex+"_attachFile");
		com.nara.jdf.io.StreamUtil.copy(in, fos);
		fos.flush();
		fos.close();
		in.close();
		*/	
		
		
		String localIP = null;
		
		localIP = conf_fileserver.getString("serverip");
		String localport = conf_fileserver.getString("serverport");
		System.out.println("#############################################");
//		System.out.println( filePath +":::localIP:::"+ localIP);
		System.out.println("#############################################");
		StringBuffer buf = new StringBuffer();
		long fileTotSize = 0;
		
		int attache_file_size = input.getCount("attache_file");
		if (attache_file_size > 0) {
		
			String uploadDir = com.nara.util.UtilFileAttacheApp.getAttacheDir((String)session.getAttribute("call_domain"));

			try {
				for (int i = 0; i < attache_file_size; i++) {
					File f = new File(java.net.URLDecoder.decode(uploadDir + File.separator
							+ (String)  input.getText("attache_file" ,i),"UTF-8"));
					//		+ (String) attache_file.get(i),"UTF-8"));
	  			    String srcFileName = f.getName();						
					
					//String strAttacheFileName = com.nara.springframework.service.BbsService.getAttacheFile((String)session.getAttribute("call_domain"), boardEntity.B_IDX, i);
					String uploadPath 
					= conf_fileserver.getString("serverfullpath", System.getProperty("user.dir")+File.separator+"notefile")+File.separator+com.nara.jdf.util.DateTime.getShortDateString();
					
					File dir = new File(uploadPath);
					if(!dir.exists()) dir.mkdirs();  
					
					String strAttacheFileName = uploadPath+java.io.File.separator+System.currentTimeMillis()+"";
					
					//UtilFileApp.renameToSystemCommand(f.getAbsolutePath(),strAttacheFileName);
					buf.append(srcFileName+","+strAttacheFileName+",,"+f.length()+","+ i+1 +","+localIP+","+ localport +"|");
					
					fileTotSize += f.length();
					System.out.println("*******1**************" +f.getAbsolutePath() );
					System.out.println("*******2**************" +strAttacheFileName );
					System.out.println("*******3**************" +strAttacheFileName );
					
					UtilFileApp.renameTo(f.getAbsolutePath(),strAttacheFileName);
				}
					System.out.println("*******file info**************" +buf.toString() );
					System.out.println("******fileTotSize**************" +fileTotSize );
			} catch(IOException e) {
				e.printStackTrace();
				System.out.println(e.toString());
				logger.error(e);
			} catch(Exception e) {
				e.printStackTrace();
				System.out.println(e.toString());
				logger.error(e);
			} finally {
				/*
				String filename = "";
				for (int i = 0; i < attache_file.size(); i++) {
					filename = uploadDir + File.separator
							+ (String) attache_file.get(i);
					//UtilFileApp.deleteDir(filename.substring(0,filename.lastIndexOf(File.separatorChar)));
					UtilFileApp.deleteDir(filename.substring(0,filename.lastIndexOf("/")));
				}*/
				
			}
		}
		
		
	
		
		/*
		java.net.NetworkInterface netface = null;
		Enumeration e = java.net.NetworkInterface.getNetworkInterfaces();
		
    while(e.hasMoreElements()) 
    {
	    	netface = (java.net.NetworkInterface)e.nextElement();
			  Enumeration e2 = netface.getInetAddresses();
		    	
    		while(e2.hasMoreElements()) 
    		{
    			java.net.InetAddress ip 	= (java.net.InetAddress)e2.nextElement();
    			
    			if ( !ip.isLoopbackAddress() && !ip.isLinkLocalAddress())
    			{	    				
    				localIP =  ip.getHostAddress();
    			}    			
    		}
	    }
		*/
	
				
	  result.append("{").append("\n")					
		      .append("	success:true,").append("\n")		      
	        .append(" data : {").append("\n")
	        .append("		fileCount: \""+ attache_file_size+"\"").append(",").append("\n")
	       // .append("		fileSize: \""+file.length()+"\"").append(",").append("\n")
	        .append("		fileSize: \""+fileTotSize+"\"").append(",").append("\n")
	        //.append("		fileInfo: \""+localFileName+","+file.getAbsolutePath()+",,"+file.length()+",1,"+localIP+","+ localport+"\"").append(",").append("\n")
	        .append("		fileInfo: \""+ buf.toString() +"\"").append(",").append("\n")
	        .append("		webpath: \"http://"+localIP+"/msgfile/"+com.nara.jdf.util.DateTime.getShortDateString()+"/"+saveFileName+"\"").append("\n")
	        .append("	}").append("\n")
		      .append("}");
	  
	} catch(Exception ex)
	{
		result.append("{").append("\n")					
		      .append("	success:false,").append("\n")		      
		      .append(" errors : {").append("\n")
		      .append("		ErrorCode: \"ERROR\"").append("\n")
		      .append("	}").append("\n")
		      .append("}");
		logger.fatal(ex);		
		ex.printStackTrace();      
		      
		      
	} finally
	{
		if( in != null )  try{ in.close(); }catch( IOException ie){}
	    if( fos != null ) try{ fos.close(); }catch( IOException ie){}	 
	}
	System.out.println(result.toString());
	out.println(result.toString());
	out.flush();
%>