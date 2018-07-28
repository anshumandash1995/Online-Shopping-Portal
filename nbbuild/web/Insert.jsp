<%-- 
    Document   : AddBook
    Created on : Mar 23, 2015, 4:10:17 PM
    Author     : HCL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>MyFreeCssTemplates.com free CSS template</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="styles.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="nivo-slider.css" type="text/css" media="screen" />
</head>
<body>

<div id="bg">
<div id="bg_top_bg">
<div id="bg_top">
<div id="bg_bot">


<div id="main">
<!-- header begins -->
<div id="header">
	<div id="buttons">
      <a href="gallery.html" class="but but_t"  title="">Home</a>
      <a href="Logout.jsp" class="but" title="">Logout</a>
      <a href="index.jsp"  class="but" title="">About us</a>
      <a href="contact_us.html" class="but" title="">Contact us</a>
      
    </div>
	<div id="logo">
    	<a href="#">Bigb.com<br>Online Shopping Cart </a>
        <hr><hr><h2><a href="#">Your stores. Your place.</a></h2>
    </div>
	
</div>
<!-- header ends -->


<div style="height: 47px"></div>
        <!-- content begins -->
        		<div></div>
       			<div>
                	<div>
                        	<div >
                                     <!-- content .................................................................begins -->
                                 
	
	
        <br><br>
        <a href="Admin.html">Click here to go to administrator page</a>
        <BR>
	<H2> Add Book</H2>
	<BODY bgcolor="#CCFFFF">
	<SCRIPT language="Javascript">
  	function check()
  	{
	var ctr=0;
  	if(document.addbook.title.value=="")
  	{
  		alert("Please Enter Title");
		return;
  	}
  	if(document.addbook.author.value=="")
  	{
  		alert("Please Enter Author");
		return;
  	}
  	if(document.addbook.pub.value=="")
  	{
  		alert("Please Enter Publisher Name");
		return;
  	}
  	if(document.addbook.edition.value=="")
  	{
  		alert("Please Enter Edition");
		return;
  	}
  	if(document.addbook.price.value=="")
  	{
  		alert("Please Enter Price (in Rs.)");
		return;
  	}
  	
  	if(document.addbook.qty.value=="")
  	{
  		alert("Please Enter Quantity");
		return;
  	}
  	if(document.addbook.desc.value=="")
  	{
  		alert("Please Enter Description");
		return;
  	}
  	if(isNaN(document.addbook.price.value))
  	{
  		alert("Please Enter a numeric value for Price (in Rs.)");
  		ctr=1;
  	}
  	if(isNaN(document.addbook.qty.value))
  	{
  		alert("Please Enter a numeric value for Quantity");
		ctr=1;
  	}
  	if(ctr==0)
  	{
  		document.forms[0].action="AddBook.jsp";
  		document.forms[0].submit();
  	}
  	else
  	{
		return true;  	
	};
	  	
  	}

  	</SCRIPT>
	<%@ page errorPage="errorpage.jsp" import="java.net.*" %>
	<%@ page import="java.io.*" %>
	<%@ page import="java.sql.*" %>
	<%
	Connection con = null;
	String query1=null;
	PreparedStatement stat=null;
	ResultSet rs=null;
	
	int ctr=0, flag=0;
	try
	{
	Class.forName("oracle.jdbc.driver.OracleDriver");
 con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","1995");  
	
	query1="select * from category_details";
	stat = con.prepareStatement(query1);
			
	rs=stat.executeQuery();
	%>
	<br>
	<hr>
	<h3> Insert New Book Details</h3>
	<form name="addbook">
	<table border=1>
	<tr><td>Book Title</td><td><input type="text" name="title"></td>
	<tr><td>Author Name</td><td><input type="text" name="author"></td>
	<tr><td>Publisher</td><td><input type="text" name="pub"></td>
	<tr><td>Edition</td><td><input type="text" name="edition"></td>
	<tr><td>Price (in Rs.)</td><td><input type="text" name="price"></td>
	<tr><td>Quantity Available(Nos.)</td><td><input type="text" name="qty"></td>
	<tr><td>Description</td><td><input type="text" name="desc"></td>
	<tr><td>Category</td> <td><select size="1" name="cat">
	<%
		while(rs.next())
		{%>
	    	<option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
	  	<%}%>
    		</select></td></tr>
	<tr><td><input type="submit" value="   Add    " onClick="check();"></td>
	<td><input type="Reset" value="    Clear    "></td>
	</table>
	</form>
	<%
	}
	catch(Exception e)
	{
	out.print("Error = " + e + "<HR>");
	}
	%> 
                                    
	         <!-- content .................................................................end -->                     
                                    
                          		
                        	</div>                        
                      		
               	  	</div>
                    <div style="height:20px"></div>
                    <div class="box_more">
                    	<div class="box_more_l">Nothing can do what a book can do. Lifts you out of your life... to a whole new world, whole new perspective. A book is like a dream you're borrowing from a friend.
                          <br> So Bigb.com offer you to shop new books,children books,Competitive Exam Books and lots more other books at your dream cost.</div>
                        <div class="box_more_r">
                        	<a href="#" class="but_more">MORE INFO</a>
                        </div>
                        <div style="clear: both"></div>
                    </div>
                      
                	
        		</div>
    <!-- content ends --> 
    <div style="height:40px"></div>
    <!-- bottom begin -->
    <br>
        <br>
        <div id="bottom_bot">
        <div id="bottom">
        <div id="b_col1">
              <h1>Account & Orders </h1>
                <div style="height:10px"></div>
                    <ul class="spis_bot">
                        <li><a href="#">About Us </a></li>
                        <li><a href="#">Why Shop at Bigb.com</a></li>
                        <li><a href="#">Highlights</a></li>
                        <li><a href="#">Payment, Shipping & Cancellation Details </a></li>
                        <li><a href="#">Policies & Terms </a></li>
                        <li><a href="#">My Order History</a></li>
                    </ul>
                </div>
                <div id="b_col2">
                    <h1>Contact Us</h1>
                    <div style="height:20px"></div>
                    <div style="padding-left:10px">
                        <div  class="box_us">
                              <div  class="box_us_l">
                                <img src="images/fish_us1.png" alt="" />
                              </div>
                              <div  class="box_us_r">
                                    <b class="lh"> Samnagar,near SBI bank, India-809032</b>
                              </div>
                              <div style="clear: both; height:10px;"></div>
                        </div>
                        <div  class="box_us">
                              <div  class="box_us_l">
                                <img src="images/fish_us2.png" alt="" />
                              </div>
                              <div  class="box_us_r">
                                    <b class="lh">Phone:  1(234) 567 8910<br />
                                        Fax: 1(234) 567 8910
                                    </b>
                              </div>
                              <div style="clear: both; height:10px;"></div>
                        </div>
                        <div  class="box_us">
                              <div  class="box_us_l">
                                <img src="images/fish_us3.png" alt="" />
                              </div>
                              <div  class="box_us_r">
                                    <b class="lh">E-mail: bmonline@gmail.com</b>
                              </div>
                              <div style="clear: both; height:10px;"></div>
                        </div>
                    </div>
            </div>
    
            <div id="b_col3">
            	<h1>Share with Others</h1>
              	<div style="height:15px"></div>
                    <ul>
                        <li><img src="images/fu_i1.png" class=" fu_i" alt="" /><a href="#">Subscribe to Blog</a></li>
                        <li><img src="images/fu_i2.png" class=" fu_i" alt="" /><a href="#">Be a fan on Facebook</a></li>
                        <li><img src="images/fu_i3.png" class=" fu_i" alt="" /><a href="#">Search on Google</a></li>
                       <li><img src="images/fu_i4.png" class=" fu_i" alt="" /><a href="#">Follow us on Twitter</a></li>
                    </ul>  
                        
                </div>
          	<div style="clear: both; height:20px;"></div>
        </div>
    </div>
<!-- bottom end --> 
<!-- footer begins -->
            <div id="footer">
          		Bigb.com 2014 fasterOnline  | <!-- Do not remove --><a href="#" title="Free CSS Templates">Private Limited </a><!-- end --><br />
                <a href="#">Privacy Policy</a> | <a href="#">Terms of Use</a>
             </div>
        <!-- footer ends -->
</div>



</div>
</div>
</div>
</div>

</body>
</html>

