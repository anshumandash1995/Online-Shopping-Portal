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
<div class="top">

			<div id="slider-wrapper">        
            <div id="slider" class="nivoSlider">
                <img src="images/top.jpg" alt="" />
                <img src="images/top2.jpg" alt=""/>
                <img src="images/top3.jpg" alt="" />
				<img src="images/top4.jpg" alt="" />
				<img src="images/top5.jpg" alt="" />
				<img src="images/top6.jpg" alt="" />
				<img src="images/top7.jpg" alt="" />
            </div>
			        
        </div>

<script type="text/javascript" src="lib/jquery-1.4.3.min.js"></script>
    <script type="text/javascript" src="lib/jquery.nivo.slider.pack.js"></script>
    <script type="text/javascript">
    $(window).load(function() {
        $('#slider').nivoSlider();
    });
    </script>

</div>

<div style="height: 47px"></div>
        <!-- content begins -->
        		<div></div>
       			<div>
                	<div>
                        	<div >
                                     <!-- content .................................................................begins -->
      

	<%@  page errorPage="errorpage.jsp" language="java"  import="java.sql.*"  %>
	<%
	int i;
	String user_src=null;
	user_src=(String)session.getValue("user");
	if (user_src!=null)
   	{
		int counter=0;		
		counter=Integer.parseInt((String)session.getValue("TotalSel"));
		int[] bookid=new int[counter];
		Connection conn;
		conn=null;
		ResultSet rs;
		rs=null;
		Class.forName("oracle.jdbc.driver.OracleDriver");
 conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","1995"); 
		
		PreparedStatement stat=null;
		int ctr=0,bookprice=0;
		for(i=1;i<=counter;i++)
		{
			if((String)session.getValue("chk_var"+i)!=null)
			{
				bookid[i-1]=Integer.parseInt((String)session.getValue("chk_var"+i));
			}
		}
		session.putValue("BookArr",bookid);	
		%>
		
		<h3>Your Cart Details are as follows:</h3>
		<form name="shop" action="Cart_Quantity.jsp">
		<table border=1>
		<tr>
		<td>S.No</td>
		<td>Book Name</td>
		<td>Price (in Rs.)</td>
		</tr>	
		<%
		int price=0;
		for (int j=1;j<=counter;j++)
		{
			out.println("<tr><td>"+j);
			
		
			String query="select title, price from book_details where bookid=?";
			stat= conn.prepareStatement(query);
			stat.setInt(1,bookid[j-1]);
		
			rs = stat.executeQuery();
			while (rs.next())
			{
				out.println("<td>");
				out.println(rs.getString(1));
				out.println("<td>");
				price=rs.getInt(2);
				out.println(price);
			}
			rs.close();
			bookprice=bookprice+price;
			session.putValue("bPrice",String.valueOf(bookprice));
			out.println("</tr>");
			
		}
		ResultSet rscombo=null;
		String query1="select * from category_details";
		PreparedStatement stat_combo = conn.prepareStatement(query1);
		
		rscombo=stat_combo.executeQuery();%>
		<tr>
			<td colspan=3>Total Cart Amount(in Rs.)=
			<%=bookprice%><td>
		</tr>
		</table>
		<br>
		<input type=submit value="Place Order">
		</form>
                <br>
                    <br>
                
		<hr><h3>Search More</h3>
		
		<form name="search" action="NewSearch.jsp" method="POST">
		<table border=1>
		<tr>	
			<td><input type="radio" value="Category" checked name="R1"></td>
			<td>Search based on Category</td>
			<td>
	  		<select size="1" name="BookCategory">
      			<option selected value="Select">Select Category</option>
				<%
				while(rscombo.next())
				{
					String category=rscombo.getString(2);
				%>
    				<option value="<%=category%>"><%=category%></option>
  				<%}%>
    			</select>
			</td>	
		</tr>
		<tr>
      			<td><input type="radio" name="R1" value="Title"></td>
     	 		<td>Search by Book Title</td>
      			<td><input type="text" name="BookTitle" size="25"></td>
    		</tr>
    		<tr>
        		<td><input type="radio" name="R1" value="Author"></td>
      			<td>Search by Book Author</td>
      			<td><input type="text" name="BookAuthor" size="25"></td>
    		</tr>
    		<tr>
      			<td><input type="radio" name="R1" value="Publisher"></td>
     			<td>Search by Book Publisher</td>
      			<td><input type="text" name="BookPublisher" size="25"></td>
    		</tr>
    	    	<tr>
    			<td><input type="radio" name="R2" value="A">Advanced Search</td>
    			<td><input type="radio" name="R2" value="N" checked>New Search</td>
    			<td><input type=submit value="Search"></td>
    		</tr>    	
    		</table>
    		</form>
		<%}
	else
	{
		response.sendRedirect("Unauthorised.html");
	}
	%>
                                    
	         <!-- content .................................................................end -->                     
                                    
                          		
                        	</div>                        
                      		
               	  	</div>
                    <div style="height:20px"></div>
                    <div class="box_more">
                    	<div class="box_more_l">Nothing can do what a book can do. Lifts you out of your life... to a whole new world, whole new perspective. A book is like a dream you're borrowing from a friend.
                          <br> So Bigb.com offer you to shop new books,children books,Competitive Exam Books and lots more other books at your dream cost. </div>
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

