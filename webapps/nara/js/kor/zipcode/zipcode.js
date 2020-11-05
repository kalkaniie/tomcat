function SearchZip(fname,zip1,zip2,addr1,addr2)
{
  var objZip;
  var att;
  objZip = "zipcode.public.do?method=searchzip_form&formname="+fname+"&zip1="+zip1+"&zip2="+zip2+"&addr1="+addr1+"&addr2="+addr2;
  att    = "status=no,resizable=1,toolbar=no,scrollbars=no,width=500,height=300";
  window.open(objZip,"zip",att);
  
}