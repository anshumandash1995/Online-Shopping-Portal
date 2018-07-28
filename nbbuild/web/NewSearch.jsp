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
                                 <CENTER>
	<H1> <u>Online Shopping Cart</u> </H1>
	</CENTER>
	<BR>
	<a href="Logout.jsp" ><font size="4"  >Click here to Logout</font></a>
	<%@  page errorPage="errorpage.jsp" language="java"  import="java.sql.*"  %>
	<%
  	String user_src=(String)session.getValue("user");
  	if (user_src!=null)
  	{
	String str_searchvar=null;
	String str_colvar=null;
	String query="";
	String tab_var="";
	int total_sel=Integer.parseInt((String)session.getValue("TotalSel"));
	int[] old_bookid=new int[total_sel];
	Connection conn;
	Connection conn1;
	conn=null;
	conn1=null;
	ResultSet rs;
	rs=null;
	Class.forName("oracle.jdbc.driver.OracleDriver");
 conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","1995"); 
	conn1=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","1995"); 
	
	
	PreparedStatement stat=null,stat_ins=null,stat_del=null;
	

	for (int i=1;i<=total_sel;i++)
	{
		old_bookid[i-1]=Integer.parseInt((String)session.getValue("chk_var"+i));
		
	}%>
		<h3>Your Cart Details are as follows:</h3>
		<form name="shop" action="Cart_quantity.jsp">
		<table border=1>
		<tr>
		<td>S.No</td>
		<td>Book Name</td>
		<td>Price (in Rs.)</td>
		</tr>	
		<%
		int price=0; int bookprice=0;
		for (int j=0;j<total_sel;j++)
		{
			out.println("<tr><td>"+j+1);
			

			query="select title, price from book_details where bookid=?";
			stat= conn.prepareStatement(query);
			stat.setInt(1,old_bookid[j]);

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
			out.println("</tr>");
		}%>
		<tr>
		<td colspan=3>Total Cart Amount(in Rs.)=
		<%=bookprice%>
		<td></tr>
		</table>
		<br>
		<input type=submit value="Place Order">
		</form>
	<%
	String test_src=null;
	int chk_ctr=0;
	
	
	if(request.getParameter("R1").equals("Title"))
	{
		str_searchvar=request.getParameter("BookTitle");
		str_colvar="Title";
		
	}
	if(request.getParameter("R1").equals("Category"))	
	{
		chk_ctr=1;
		str_searchvar=request.getParameter("BookCategory");
		str_colvar="Categoryname";
	}
	
	if(request.getParameter("R1").equals("Publisher"))	
	{
		str_searchvar=request.getParameter("BookPublisher");
		str_colvar="Publisher";
	}
	if(request.getParameter("R1").equals("Author"))
	{
		str_searchvar=request.getParameter("BookAuthor");
		str_colvar="Author";
	}
		
	String ss = request.getParameter("R2");
	
	if (request.getParameter("R2")==null)
	{
		tab_var="book_details";		
	}
	else
	{
	// to get the name of the table in which the search to be done-------
		if (request.getParameter("R2").equals("A"))
		{
			
			tab_var="temp_detail";
		}
		else
		{  
			tab_var="book_details";
			
		}
	}
	
		
	//-------- whether search is by category or other criteria-----------
	if (chk_ctr==0)
	{

		query="select a.* from "+tab_var+" a, category_details b where a."+str_colvar+" = ? and a.CATEGORYID = b.CATEGORYID";
	}
	else
	{
			
		query="SELECT a.*,b.categoryname FROM "+tab_var+" a,CATEGORY_DETAILS b where b."+str_colvar+"=? and a.categoryid=b.categoryid";
	}
		
	try
	{
		 PreparedStatement stat1=conn1.prepareStatement(query);
		stat1.setString(1,str_searchvar);


		rs = stat1.executeQuery();

		int ctr=0;%>
		<h3>Search Results are as follows:</h3>
		<form name="cart" action="NewInter_cart.jsp" method="POST">
		<table border=1>
		<tr>
		<td>S.No</td>
		<td>Select</td>
		<td>Book Name</td>
		<td>Author Name</td>
		<td>Publisher</td>
		<td>Edition</td>
		<td>Price (in Rs.)</td>
		<td>Quantity Available(Nos.)</td>
		<td>Description</td>
		</tr>
		<%
		String delete_query="Delete from TEMP_DETAIL";
		stat_del= conn.prepareStatement(delete_query);
		String ins_query=null;
		int int_BOOKID,int_CATEGORYID,int_PRICE,int_QUANTITY;
		String str_TITLE,str_AUTHOR,str_PUBLISHER,str_EDITION,str_DESCRIPTION;

		int rs_del=stat_del.executeUpdate();
		while(rs.next())
		{
			ctr=ctr+1;
			out.println("<tr><td>"+ctr);
			int_BOOKID=rs.getInt(1);
			out.println("<td><input type=checkbox name=chk"+ctr+" value="+int_BOOKID+">");
					
			int_CATEGORYID=rs.getInt(2);
						
			str_TITLE=rs.getString(3);
			out.println("<td>");
			out.println(str_TITLE);
			
			str_AUTHOR=rs.getString(4);
			out.println("<td>");
			out.println(str_AUTHOR);
			
			
			
			str_PUBLISHER=rs.getString(5);
			out.println("<td>");
			out.println(str_PUBLISHER);
			
			str_EDITION=rs.getString(6);
			out.println("<td>");
			out.println(str_EDITION);
			
			int_PRICE=rs.getInt(7);
			out.println("<td>");
			out.println(int_PRICE);
			
			int_QUANTITY=rs.getInt(8);
			out.println("<td>");
			out.println(int_QUANTITY);

			str_DESCRIPTION=rs.getString(9);
			out.println("<td>");
			out.println(str_DESCRIPTION);

			
			out.println("</tr>");

			ins_query="INSERT INTO TEMP_DETAIL VALUES(?,?,?,?,?,?,?,?,?)";
			stat_ins=conn.prepareStatement(ins_query);
			stat_ins.setInt(1,int_BOOKID);
			stat_ins.setInt(2,int_CATEGORYID);
                        stat_ins.setString(3,str_TITLE);
			stat_ins.setString(4,str_AUTHOR);
			stat_ins.setString(5,str_PUBLISHER);
			stat_ins.setString(6,str_EDITION);
			stat_ins.setInt(7,int_PRICE);
                        stat_ins.setInt(8,int_QUANTITY);
			stat_ins.setString(9,str_DESCRIPTION);
			

		int rs_ins=stat_ins.executeUpdate();
		
		}
		String str_ctr=String.valueOf(ctr);
		session.putValue("ctr_val",str_ctr);
		
		%>
	
		
	</table>
	
	<input type="submit" value="    Add to Cart    " name="Add">
	</form>
	<%

	ResultSet rscombo=null;
		String query1="select * from category_details";
		PreparedStatement stat_combo = conn.prepareStatement(query1);

		rscombo=stat_combo.executeQuery();%>	
	
	<br><h3>Search Results are as follows:</h3>
	<form name="newsrc" action="NewSearch.jsp" method="POST">
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
	catch(Exception E)
	{
		out.println("Error  "+E);
	}
	finally{conn.close();}


}
else
	{
		response.sendRedirect("Unauthorised.htm");
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

