<%@ page
	import="java.util.*, com.nara.jdf.http.*, com.nara.jdf.util.*, com.nara.jdf.data.*"%>
<%!
  private static final int APPLICATION= 0;
  private static final int SESSION= 1;
  private static final int REQUEST= 2;
  
  /*private HttpAttributes attr_req = null;
  private HttpAttributes attr_session = null;
  private HttpAttributes attr_multi = null;*/
	
	public HttpAttributes getAttributes( HttpServletRequest req)
	{
		return getAttributes( req, REQUEST);
	}
	
	public HttpAttributes getAttributes(HttpServletRequest req, int scope)
    {
        
        HttpAttributes attr_req = null;
        HttpAttributes attr_session = null;
        HttpAttributes attr_multi = null;
        
        try
        {
            switch (scope)
            {
                case APPLICATION :
                    return new ApplicationAttributes(getServletContext());

                case SESSION :
                    attr_session= new SessionAttributes(req);
                    return attr_session;

                case REQUEST :
                    String contentType= req.getContentType();

                    if (contentType != null && contentType.toLowerCase().startsWith("multipart"))
                    {                    	
                        attr_multi= new MultipartAttributes(req); 
                        return attr_multi;
                    }

                    else
                    {
                        attr_req= new RequestAttributes(req);
                        return attr_req;
                    }

            }

        }
        catch (Exception ex)
        {
            //logging( "getAttributes() exec ERROR! " );
        }

        return null;
    }
%>