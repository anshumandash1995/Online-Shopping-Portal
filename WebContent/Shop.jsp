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
	if (session.getValue("user")!=null)
	{%>
	<script language="Javascript">
	function validate()
	{
 	var r = document.form1;
    	var creditcard=r.Card.value;
 	var year = r.Year.value;
 	var month = r.Month.value;
     	var day = r.Day.value;
   
     	if(creditcard.length!=16)
 	{
		   alert("Invalid Credit Card Number");
		   r.Card.focus();
		   return;
  	}		   
//-----------------------------------------------------------------------   	
	
	if(day=="Select Day")
	{ 
		alert("Please select the day");
		r.Day.focus();
		return;
	}  	
//-----------------------------------------------------------------------   		
	if(month=="Select Month")
	{ 
		alert("Please select the month");
		r.Month.focus();
		return;
	}
//----------------------------------------------------------------------- 	
  	if(year.length==0)
	{ 
		alert("Please enter the year");
		r.Year.focus();
	}
     	else if (year.length!=4)
	{
		alert("Please enter the year in YYYY format");
 		r.Year.focus();
	}
//-----------------------------------------------------------------------
     	if (( month == "3" || month == "5" || month == "8" || month == "10") && (day == "31"))
        {
        	alert("Please enter a valid date");
                r.Day.focus();
        }
     	if ((month == "1") && (day == "30" || day == "31"))
        {
                alert("Please enter a valid date");
                r.Day.focus();
        }
        
        //------- To check that card date  is not less than current date----------
        var vr_day;
	var vr_month;
	var vr_year;
	var d=new Date();
	vr_year=d.getFullYear();
	vr_month=d.getMonth();
	vr_day=d.getDate();

	if(parseInt(vr_year)>parseInt(document.form1.Year.value))
	{
		alert("Year cannot be less than Current Year");
		return false;
	}
	else if(parseInt(vr_year)==parseInt(document.form1.Year.value))
	{
		if(parseInt(vr_month)>parseInt(document.form1.Month.value))
		{
			alert("Month cannot be less than Current Month");
			return false;
		}
		else if(parseInt(vr_month)==parseInt(document.form1.Month.value))
		{
			if(parseInt(vr_day)>parseInt(document.form1.Day.value))
			{
				alert("Day cannot be less than current Day");
				return false;
			}
		}
	}
	
	//------------------------------------------------------------------------
	document.form1.submit();
	document.forms[0].action="Final.jsp";
	}
	</script>
	<%
		int counter=0;	
		counter=Integer.parseInt((String)session.getValue("TotalSel"));
		String query="";
		int[] bookid=new int[counter];
		int[] bk_price=new int[counter];
		int[] bk_quantity=new int[counter];
		
                Connection conn;
		conn=null;
		ResultSet rs;
		rs=null;
		Class.forName("oracle.jdbc.driver.OracleDriver");
 conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","1995"); 
		
		PreparedStatement stat=null;
		int ctr=0,bookprice=0;
		int i=1;
		while(i<=counter)
		{
			if((String)session.getValue("chk_var"+i)!=null)
			{
				bookid[i-1]=Integer.parseInt((String)session.getValue("chk_var"+i));
		
				query="SELECT PRICE FROM BOOK_DETAILS WHERE BOOKID=?";
				stat=conn.prepareStatement(query);
				stat.setInt(1,bookid[i-1]);
		
				rs=stat.executeQuery();
				if(rs.next())
				{
					bk_price[i-1]=rs.getInt(1);
				}
				else
				{
					bk_price[i-1]=0;
				}
			
			}
			
			if(request.getParameter("qty"+i)!=null)
			{
				bk_quantity[i-1]=Integer.parseInt(request.getParameter("qty"+i));
				String sess_var=String.valueOf(bk_quantity[i-1]);
				session.putValue(sess_var,String.valueOf(bk_quantity[i-1]));
			}
			
			bookprice=bookprice+(bk_price[i-1]*bk_quantity[i-1]);
			i++;
		}
		session.putValue("bPrice",String.valueOf(bookprice));
	%>
	
	<form method="POST" action="Final.jsp" name="form1">
  	<table width="70%">
    	<tr>
    		<td colspan=4 ><b>Total Amount (in Rs.) is : <%=bookprice%></b></td></tr>
    	<tr>
    	</tr>
    	<tr>
    		<td><font size="3"><b>Credit Card Number: </b></font></td>
      		<td colspan=3>
      	<input type="text" name="Card" size="39" maxlength="16" tab="1"></td>
    	</tr>
    	<tr>
      		<td><font size="3"><b>Expiry Date :     </b></font></td>
      		<td>
      		     		
      		<select size="1" name="Day">
          	<option value="Select Day">Select Day</option>
          	<option value="1">1</option>
          	<option value="2">2</option>
          	<option value="3">3</option>
          	<option value="4">4</option>
          	<option value="5">5</option>
          	<option value="6">6</option>
          	<option value="7">7</option>
          	<option value="8">8</option>
          	<option value="9">9</option>
          	<option value="10">10</option>
          	<option value="11">11</option>
         	<option value="12">12</option>
         	<option value="13">13</option>
         	<option value="14">14</option>
         	<option value="15">15</option>
         	<option value="16">16</option>
         	<option value="17">17</option>
         	<option value="18">18</option>
        	<option value="19">19</option>
        	<option value="20">20</option>
        	<option value="21">21</option>
        	<option value="22">22</option>
        	<option value="23">23</option>
         	<option value="24">24</option>
        	<option value="25">25</option>
          	<option value="26">26</option>
          	<option value="27">27</option>
          	<option value="28">28</option>
          	<option value="29">29</option>
          	<option value="30">30</option>
          	<option value="31">31</option>
        	</select>
        	</td>
        	<td>
        	<select size="1" name="Month">
          	<option value="Select Month">Select Month</option>
          	<option value="0">January</option>
          	<option value="1">February</option>
          	<option value="2">March</option>
          	<option value="3">April</option>
          	<option value="4">May</option>
          	<option value="5">June</option>
          	<option value="6">July</option>
          	<option value="7">August</option>
          	<option value="8">September</option>
          	<option value="9">October</option>
          	<option value="10">November</option>
          	<option value="11">December</option>
        	</select>
        	</td>
        	<td>
        	<font size="3"><input type="text" name="Year" size="11"></font>
      		</td>
    	</tr>
  	</table>
  
  	</font><input type="button" value="Submit" name="B1" onClick="validate();" >
  	</form>
	<%
	}
	else
	{
		response.sendRedirect("Unauthorised.htm");
	}%> 
                                    
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

