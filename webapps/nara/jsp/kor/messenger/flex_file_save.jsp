<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.jdf.Config"%>
<%@page import="com.nara.jdf.Configuration"%>
<%@ page import="java.util.*, java.io.*, org.apache.log4j.Logger, com.nara.jdf.http.*, com.nara.jdf.util.*, com.nara.jdf.data.*,com.nara.util.*" %>
<%@ include file = "/jsp/kor/common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%		
	
	Logger logger = Logger.getLogger(this.getClass());
	
	request.setCharacterEncoding("utf-8");
	HttpAttributes attr = getAttributes( request );
	DataSet input = attr.getDataSet();   
	String buddyIndex = attr.getString( "buddyIndex");
	
	//System.out.println("FILE_SAVE1111111111111.jsp===>attribute " + input.toString());
	
	StringBuffer result = new StringBuffer();
	StringBuffer fileInfobuf = new StringBuffer();
	StringBuffer webpathbuf = new StringBuffer();
	long fileTotSize = 0;
	String localIP = null;
	String localport = null;
	
	try
	{
		com.nara.jdf.Config conf = com.nara.jdf.Configuration.lookup("/com/nara/msg/note_file");
		com.nara.jdf.Config conf_fileserver = com.nara.jdf.Configuration.lookup("/com/nara/msg/fileserver");
		String localFileName = input.getText(buddyIndex+"_attachFile");
		
		localIP = conf_fileserver.getString("serverip");
		localport = conf_fileserver.getString("serverport");
		
		
		int attache_file_size = input.getCount("attache_file");
		if (attache_file_size > 0) {
			Config confhost = Configuration.getInitial();
			String webmail_host = confhost.getString("com.nara.kebimail.host");
			
			System.out.println("*******webmail_host**************" +webmail_host);
			String tmpUploadDir = com.nara.util.UtilFileAttacheApp.getAttacheDir(webmail_host);
			//String tmpUploadDir = com.nara.util.UtilFileAttacheApp.getAttacheDir((String)session.getAttribute("call_domain"));

			try {
				
					for (int i = 0; i < attache_file_size; i++) {
						
						File f = new File(java.net.URLDecoder.decode(tmpUploadDir + File.separator+(String)input.getText("attache_file" ,i),"UTF-8"));
						
		  			    String srcRealFileName = f.getName();						
						
		  			    //real path 
						String folderName = com.nara.jdf.util.DateTime.getShortDateString();
						String fileName = System.currentTimeMillis()+ i +"";
		  			    String realUploadPath 
						= conf_fileserver.getString("serverfullpath", System.getProperty("user.dir")+File.separator+"notefile")+File.separator + folderName;
		  			    
						File realDir = new File(realUploadPath);
						if(!realDir.exists()) realDir.mkdirs();  
						
						String strAttacheFileName = realUploadPath+java.io.File.separator+ fileName +"";
						
						String tmp_down_url = "/maildata/msgserver/data" + File.separator + folderName +java.io.File.separator+ fileName +"";
						// info
						//fileInfobuf.append(srcRealFileName+","+strAttacheFileName+",,"+f.length()+","+ i+1 +","+localIP+","+ localport );
						fileInfobuf.append(srcRealFileName+","+tmp_down_url+",,"+f.length()+","+ i+1 +","+localIP+","+ localport);
						if(i < attache_file_size-1)
							fileInfobuf.append("|");
						
						webpathbuf.append("http://"+localIP+"/msgfile/"+ folderName +"/"+fileName +"|");
						fileTotSize += f.length();
						
						System.out.println("*******1**************" +f.getAbsolutePath() );
						System.out.println("*******2**************" +strAttacheFileName );
						
						//file rename
						UtilFileApp.renameTo(f.getAbsolutePath(),strAttacheFileName);
					}
						System.out.println("*******file info**************" +fileInfobuf.toString() );
						System.out.println("*******webpathbuf info**************" +webpathbuf.toString() );
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
		
		
		  result.append("{").append("\n")					
			    .append("	success:true,").append("\n")		      
		        .append(" data : {").append("\n")
		        .append("		fileCount: \""+ attache_file_size+"\"").append(",").append("\n")
		       // .append("		fileSize: \""+file.length()+"\"").append(",").append("\n")
		        .append("		fileSize: \""+fileTotSize+"\"").append(",").append("\n")
		        //.append("		fileInfo: \""+localFileName+","+file.getAbsolutePath()+",,"+file.length()+",1,"+localIP+","+ localport+"\"").append(",").append("\n")
		        .append("		fileInfo: \""+ fileInfobuf.toString() +"\"").append(",").append("\n")
		        //.append("		webpath: \"http://"+localIP+"/msgfile/"+com.nara.jdf.util.DateTime.getShortDateString()+"/"+saveFileName+"\"").append("\n")
		        .append("		webpath: \""+ webpathbuf.toString()+"\"").append("\n")
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
		// if( in != null )  try{ in.close(); }catch( IOException ie){}
	    // if( fos != null ) try{ fos.close(); }catch( IOException ie){}	 
	}
	System.out.println(result.toString());
	out.println(result.toString());
	out.flush();
%>