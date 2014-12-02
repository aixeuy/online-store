#!/usr/bin/python
import cgi, cgitb

print "Content-type:text/html\r\n\r\n"

print "<html>"
print "<head>"
print "<title>Go to checkout</title>"
print "</head>"
print "<body bgcolor=\"tan\">"
print "<p style=\"margin-top: 30px;\">"
print "<h1 align=\"center\"><i>Bill</i></h1>"
print "</p>"
print "<p>"

form = cgi.FieldStorage() 

class obj:
	
	def __init__(self,x,n,p):
		self.name=x
		self.num=n
		self.price=p
def change(x):
	ob=[]	
	try:
		A=open("Inventory.csv","r")
		l=A.readlines()
		for i in l:
			i=i.split(",");
			if i[0]==x:
				i[1]=int(i[1])-1;
			ob.append(obj(i[0],i[1],i[2].strip()))
	except IOError:
		print "IOerror"
	A.close()
	A=open("Inventory.csv","w")
	for i in ob:
		tb=[i.name,i.num,i.price]
		v=",".join([i.name, str(i.num),i.price])
		A.write(v)
		A.write("\n")
	A.close()

def loggedin(username):#reorder
	try:
		name=open("LoggedIn.csv","r")#Loggedin spelling mistake
		for line in name.readlines():#remove \n
			if line.strip() == username:
				return "1"#retun spelling misstake
		return "0" #same
		name.close()
	except IOError:
		print "Oops!LoggedIn.csv Missing"
# Get data from fields


	                      
username = form.getvalue('username')

mc = form.getvalue('mercury')
vn = form.getvalue('venus')
ms = form.getvalue('mars')
jp = form.getvalue('jupiter')
st = form.getvalue('saturn')

num = form.getlist("num")       #new added to read num from <text>
total = 0


list1 = [mc,vn,ms,jp,st];
list2 = ['Mercury','Venus','Mars','Jupiter','Saturn'];

if loggedin(username) == "0":
	print "<p>You are not logged in.</p>"
	print "<a href=\"http://www.cs.mcgill.ca/~yxia18/store/catalogue.html\">CATALOGUE"
	print "</body> </html>"
else:
	quantity = open("Inventory.csv","r")

	for i in range(0,5):
		if list1[i] == "0":
			if num[i] > "1":
				print "<p>Sorry,We don't have so much stocks</p>"
			else:
				if num[i] == "1":
					l=quantity.readline()
					l=l.split(",");
					if l[1] < "1":
						print "<br>Sold Out"
					else:
						if l[1] == "1":
							print "<p>Iterm name:%s</p>",list2[i]
							print "<p>Iterm quantity:%s</p>",num[i]
							print "<p>Iterm price:%f</p>",l[2]
							change(list2[i])
							total = total + int(l[2])
	print "<br>The total amount is %f",total
	print "<p style=\"line-height: 80px;\">"
	print "<a href=\"http://www.cs.mcgill.ca/~yxia18/store/home.html\">HOME</a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href=\"http://www.cs.mcgill.ca/~yxia18/store/catalogue.html\">CATALOGUE</a>"
	print "</p>"
	print "</body></html>"
	






	


