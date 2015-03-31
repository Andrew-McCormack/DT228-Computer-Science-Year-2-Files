<!DOCTYPE html PUBLIC "-//W3C//DD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html lang="en">
<head>
	<meta charset='utf-8'>
   <meta http-equiv="imagetoolbar" content="no" />
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <link rel="stylesheet" href="style.css">
   <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
   <script src="script.js"></script>
	<title>Create An Account</title>
</head>

<body>
<center>
<h1>Create an account</h1> 

<?php
require_once "db_book.php"; 
$result = mysql_query("SELECT * FROM users");
	if ( isset($_POST['userName']) && isset($_POST['password']) && isset($_POST['firstName']) && isset($_POST['surName']) && isset($_POST['addressLine1']) && isset($_POST['addressLine2']) && isset($_POST['city']) && isset($_POST['telephone']) && isset($_POST['mobile']))
	{  
		$check = True;
		
		$u = trim(mysql_real_escape_string( $_POST['userName']));
		$p = trim(mysql_real_escape_string( $_POST['password'])); 
		$pc = trim(mysql_real_escape_string( $_POST['passwordConfirm'])); 
		$n = trim(mysql_real_escape_string( $_POST['firstName']));
		$sn = trim(mysql_real_escape_string( $_POST['surName'])); 
		$a1 = trim(mysql_real_escape_string( $_POST['addressLine1']));
		$a2 = trim(mysql_real_escape_string( $_POST['addressLine2']));
		$c = trim(mysql_real_escape_string( $_POST['city']));
		$t = trim(mysql_real_escape_string( $_POST['telephone']));
		$m = trim(mysql_real_escape_string( $_POST['mobile']));
		
		if ($p === $pc)
		{
		while ( $row = mysql_fetch_row($result) ) 
		{
			if ($row[0] == $u)
			{			
				$check = False;
				echo "That User Name has been taken, please use another User Name";
			}
			
			else if ($u == '' || $p == '' || $n == '' || $sn == '' || $a1 == '' || $a2 == '' || $c == '' || $t == '' || $m == '')
			{
				$check = False;
				echo "Please fill in all fields!";
				break;
			}
		}
		
		if ($check == true)
		{
			$sql = "INSERT INTO `book`.`users` (`userName`, `password`, `firstName`, `surName`, `addressLine1`, `addressLine2`, `city`, `telephone`, `mobile`) 
			VALUES ('$u', '$p', '$n', '$sn', '$a1', '$a2', '$c', '$t', '$m')"; 
			mysql_query($sql);
			echo "Successfully added user: " . $u;
			header("location:index.php");
		}
	}
	else
	{
		echo "The passwords you entered do not match";
	}
	
	}


else
{
	echo "Please fill in your details to create your account";
}

?>

<?php
echo "<form id=\"form4\"  method=\"post\">";
echo "<fieldset><legend>Contact form</legend><p class=\"first\">";
 
echo "<p class=\"first\">";
echo "<label for=\"userName\">User Name:</label>";
echo "<input type=\"text\" name=\"userName\" id=\"userName\" maxlength=\"21\" size=\"30\">"; 
echo "</p>";
echo "<p>";
echo "<label for=\"password\">Password:</label>";
echo "<input type=\"password\" name=\"password\" id=\"password\" maxlength=\"6\" size=\"30\">";
echo "</p>"; 
echo "<p>";
echo "<label for=\"passwordConfirm\">Confirm Password:</label>";
echo "<input type=\"password\" name=\"passwordConfirm\" id=\"passwordConfirm\" maxlength=\"6\" size=\"30\">";
echo "</p>"; 
echo "<p>";
echo "<label for=\"firstName\">First Name:</label>"; 
echo "<input type=\"text\" name=\"firstName\" id=\"firstName\" maxlength=\"11\" size=\"30\">";  
echo "</p>"; 
echo "<p>";
echo "<label for=\"surName:\">SurName:</label>";
echo "<input type=\"text\" name=\"surName\" id=\"surName\" maxlength=\"21\" size=\"30\">"; 
echo "</p>"; 
echo "<p>";
echo "<label for=\"addressLine1\">AddressLine 1:</label>";
echo "<input type=\"text\" name=\"addressLine1\" id=\"addressLine1\" maxlength=\"21\" size=\"30\">"; 
echo "</p>"; 
echo "<p>";
echo "<label for=\"addressLine2\">Address Line 2:</label>";
echo "<input type=\"text\" name=\"addressLine2\" id=\"addressLine2\" maxlength=\"21\" size=\"30\">"; 
echo "</p>"; 
echo "<p>";
echo "<label for=\"city\">City:</label>";
echo "<input type=\"text\" name=\"city\" id=\"city\" maxlength=\"11\" size=\"30\">"; 
echo "</p>"; 
echo "<p>";
echo "<label for=\"telephone\">Telephone:</label>";
echo "<input type=\"number\" name=\"telephone\" id=\"telephone\" maxlength=\"10\" size=\"30\">"; 
echo "<label for=\"mobile\">Mobile:</label>";
echo "<input type=\"number\" name=\"mobile\" id=\"number\" maxlength=\"10\ size=\"30\">";  
echo "</p>"; 
echo "<p>";
echo "<p class=\"submit\"><button type=\"submit\">Add New</button></p>";
echo "</fieldset>";
echo "</form>"; 
?>

<br>
<br>
<a href="index.php">Return To Index</a>
</center>
<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
   <script src="script.js"></script>
<script type="text/javascript">
_uacct = "UA-783567-1";
urchinTracker();
</script>	   
</body>
</html>