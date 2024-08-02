<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.banking.dao.CustomerDAO,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Banking Application - Customer Dashboard Page</title>
<link rel="stylesheet" href="customer.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
</head>
<body>
	<%
	if (request.getSession(false).getAttribute("user-type") != null) {
		if (!request.getSession().getAttribute("user-type").equals("Customer"))
			response.sendRedirect("index.jsp");
	} 
	%>
	<h1>Customer Dashboard</h1>
	<div class="btn-wrapper">
	<button onclick="downloadPdf()">Download Transaction History</button>
	<a class="btn" href="withdrawPage.jsp">Withdraw</a>
	<a class="btn" href="depositPage.jsp">Deposit</a>
	</div>
	<h2>Last Transactions</h2>
	<div class="table-wrapper">
	<table class="user-table">
		<tr>
			<th>Transaction ID</th>
			<th>Customer ID</th>
			<th>Transaction Type</th>
			<th>Amount</th>
			<th>Balance</th>
			<th>Transaction Date</th>
		</tr>
		<%
		if (request.getSession(false).getAttribute("user") != null) {
			int cust_id = Integer.parseInt((String) request.getSession(false).getAttribute("user"));
			CustomerDAO admin = new CustomerDAO();
			ResultSet rs = admin.getTransactions(cust_id);
			while (rs.next()) {
		%>
		<tr>
			<td align="center"><%=rs.getInt(1)%></td>
			<td align="center"><%=rs.getInt(2)%></td>
			<td align="center"><%=rs.getString(3)%></td>
			<td align="center"><%=rs.getInt(4)%></td>
			<td align="center"><%=rs.getInt(5)%></td>
			<td align="center"><%=rs.getString(6)%></td>
		</tr>
		<%
		}
		}
		%>
	</table>
	</div>
	<form action="LogoutServlet" method="post">
		<input type="submit" value="Logout">
	</form>
	<script>
		function downloadPdf() {
			const table = document.querySelector("table");
			var opt = {
				margin : 10,
				filename : "Statement.pdf",
				image : {
					type : 'jpeg',
					quality : 1
				},
				html2canvas : {
					scale : 2
				},
				jsPDF : {
					unit : 'pt',
					format : 'a4',
					orientation : 'portrait'
				}
			}
			html2pdf().from(table).set(opt).save();
		}
	</script>
</body>
</html>