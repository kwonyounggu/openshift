<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.common.*" %>
<%@ page import="java.util.*" %>
<%@ page isELIgnored ="false" %>
<style>


	ul.no-bullets
	{
		list-style: none outside none;
	}
	ul.no-bullets li:before
	{
		content: "»";
		padding-right: 5px;
	}
	ul.no-bullets li
	{
		list-style-type: none;
	}

</style>

<div style="width: 100%; background-color: #555762; color: #ffffff; padding: 10px 10px 10px 10px; text-align:left;">
	<h4 style="color: #f9d548;">What to provide</h4>
   	<ul>
   		<li>Web Applications</li>
   		<li>PC-based Applications</li>
   		<li>Smart Phone Applications</li>
   		<li>Tablet Applications</li>
   		<li>Web Site Support and Maintenance</li>
   	</ul>
</div>
<div style="height: 5px;"></div>
<div style="width: 100%; background-color: #555762; color: #ffffff; padding: 10px 10px 10px 10px; text-align:left;">
	<h4 style="color: #f9d548;">Developement Technologies</h4>
   	<ul>
   		<li>Java, C/C++</li>
   		<li>Actionscript 3.0 including Starling, Feathers UI</li>
   		<li>HTML/CSS/Javascript including JQuery</li>
   		<li>Oracle, PostgreSQL, MySql, Ms Access</li>
   		<li>Tomcat 5.x, 6.x, 7.x, 8.x and JBoss</li>
   	</ul>
</div>
<div style="height: 5px;"></div>

<div id="contents" style="width:100%; padding:10px 10px 10px 10px; text-align:left; border: 1px solid gray"><!-- Resume -->	
	<table>
		<tr>
			<td>
			 	<div style="width:100%;"><!-- Objective and Profile in depth 1 -->
			 		<div style="float:left; width:80%">
			 			<h4>OBJECTIVE:</h4>
			 			<ul>
			 				<li>Seeking freelance works to provide PC-based, Web-based and or Mobile phone-based applications</li>
			 			</ul>
			 		</div>
			 		<div style="float:right;width:20%">
				 		<a href="mailto:<%=AuthData.mycompany_email_address%>?Subject=Hello John KWON" target="_top"><img src="images/JohnKwon.png" width="67" height="73" alt="John KWON" border="0"/></a>
				 	</div>
				 </div>
			</td>
		</tr>
		<tr>
			<td>
				<div style="width: 100%; font-size: 80%; text-align: left;">
					<h4>PROFILE:</h4>
					<ul>
						<li>20 years' software development experience in developing web and desktop applications on clinical research management, accounting management, online shopping mall, network management and CIM areas.</li>
						<li>Over 5 year experience in Flex 2-4.x and Action Script 3.0 including Caurina Tweener, Cairngorm Robotlegs, fds lcds BlazeDs, red5 fms</li>
						<li>Extensive experiences in Java (Servlets, Filters, Java Beans, JavaMail, etc), JSP (EL, JSTL, etc), Ajax HTML JavaScript XML JSON CSS using MVC (Model 2) and C/C++.</li>
						<li>Windows for over 10 years, UNIX family: HP SUN CentOS Ubuntu for over 10 years.</li>
						<li>MySQL PostGreSQL Oracle for 6 years,  MsSQL MsAccess for 5 years,  DB2 for 2 year.</li>
						<li>Good analytical problem-solving capabilities, self-motivated and quick steady learner.</li>
					</ul>
				</div>
			</td>
		</tr>
		<tr>
		  <td>
 	<div style="width: 100%; font-size: 80%; ">
 		<h4>WORK EXPERIENCE:</h4>
 		<div style="padding-left: 5px; padding-right: 5px">
	 		<h5>Clinical Research Software Developer, Contract, 05/2011 - Current</h5>
	 		<h5>The Hospital for Sick Children in the department of Paediatric Laboratory Medicine, Toronto</h5>
	 		<ul >
 				<li>Developed web applications to produce and manage dynamical statistical charts using 65 different blood samples collected from 6000 normal children’s serum, in order to analyze correlations between each analyte and BMI, clustering analytes' concentration in each age group, ethnic group, gender and so on.</li>
 				<li>Main statistical algorithms are Dixon, Harris Boyd and Horn Pesce Robust with mean and standard deviation.</li>
 				<li>Java and ActionScript running in Apache Tomcat Server are used on top of Eclipse IDE in addition to MySQL database and R/Perl.</li>
 			</ul>
 			<h5>The Hospital for Sick Children in the department of Clinical Care Medicine, Toronto</h5>
	 		<ul >
 				<li>Developed  several clinical research applications such as EPOCH providing data management system including research infrastructure,  site enrolment, intervention fidelity, sub-studies and reporting systems with over 50,000 pdf documents uploaded from remote hospitals, EXEMPLAR providing medication safety studies using patient data and over 12,000 drugs, SPIRE providing quality of patient care,  medical education, etc from physician trainees, TTT  (Tele-Team Training System) providing real-time-based online training system through web-cams and clinical video files between local hospitals and remote hospitals, BPEWS (Bedside Pediatric Early Warning System)  providing ways of studies through clinical data provided from over 50 worldwide hospitals and CAP (Cardiac Arrest Preventability) providing anonymous patient data to medical doctors for the study of Cardiac Arrest Preventability.</li>
 				<li>Development methodologies:
 					<ul class="no-bullets">
	 					<li >Collected the user requirements from professional researchers.</li>
	 					<li >Designed architecture using MVC (model 2) design pattern and Robotlegs.</li>
	 					<li >Designed & created DB schema using Oracle11.x PostgresSQL8.4 including MySQL migration.</li>
	 					<li >Implemented Controllers using Java Servlets and Filters, Models using Java Beans  JDBC& PL/SQL and Views (JSP, AJAX, HTML Javascript css, JSON XML, EL & JSTL).</li>
	 					<li >Front end: JSP, AJAX, Javascript, JQuery, HTML HTML5, Flex 4.x and Action Script 3.0</li>
	 					<li >Middleware: Java using BlazeDS, servlets and SOAP service</li>
 					</ul>
 				</li>
 				<li>OS: Windows and Red Hat Linux, Web Server: Apache Tomcat.5-7.x, Stream Server: Red5</li>
 				<li>IDE: Eclipse with Git and SVN</li>
 			</ul>
 		</div>
 		<div style="padding-left: 5px; padding-right: 5px">
	 		<h5>Software Developer, Contract, 05/2007 - 07/2010</h5>
	 		<h5>Cinram International Inc, Toronto</h5>
	 		<ul >
 				<li>Developed web service applications based on SOAP and accounting management applications</li>
 				<li>Development methodologies:
 					<ul class="no-bullets">
	 					<li >Collected the user requirements from professional researchers.</li>
	 					<li >Designed architecture using MVC (model 2) design pattern.</li>
	 					<li >Designed & created DB schema using MySQL/MsSQL database.</li>
	 					<li >Implemented Controllers using JMS, Java Servlets and Filters, Models using Java Beans & JDBC and Views (JSP, HTML Javascript css, EL & JSTL).</li>
	 					<li >Front end: Flex 2.0.1 and Action Script 3.0 (Caurina Tweener, Cairngorm)</li>
	 					<li >Middleware: Java using FDS LCDS & servlets, JMS and SOAP Service</li>
 					</ul>
 				</li>
 				<li>OS: Windows XP, Web Server: Apache Tomcat & JBoss</li>
 				<li>IDE: Eclipse with SVN</li>
 			</ul>
 		</div>
 		<div style="padding-left: 5px; padding-right: 5px">
	 		<h5>Software Engineer, Full Time Permanent, 04/2000 - 12/2006</h5>
	 		<h5>Motorola Canada Inc, Toronto</h5>
	 		<ul >
 				<li>Designed, developed and released web based software application tools for Network Node Performance Configuration Management and QoS(ATM PPPoE FrameRelay  Ethernet Applications), Voice Performance Management and VPN Performance Management including automatic topology discovery, event analysis correlation, configuration management and drill down graphical reporting system.</li>
 				<li>Technologies involved above are OO Design in N-tiered web architecture, Java, Java Swing, JSP Servlets based GUI, JNI, XML HTML JavaScript, JDBC, Oracle MySql MsAccess.</li>
 				<li>JBoss Tomcat servers and 3rd party libs (quadbase reporting, quartz scheduler and Cyberon SNMP) with running platforms; SUN Solaris and Windows and Eclipse Jbuilder.</li>
 				<li>Developed administrative application tool management software using C++ running as services through Windows Service Control Manager, running on Windows platform.</li>
 			</ul>
 		</div>
 		<div style="padding-left: 5px; padding-right: 5px">
	 		<h5>CIM Software Engineer, Full Time Permanent, 03/1995 - 03/2000</h5>
	 		<h5>Motorola Korea, Korea</h5>
	 		<ul >
 				<li>Designed and developed Semiconductor test/process equipment assembly line control software to provide Work In Process (WIP) data, Equipment Utilization Data and Automatic Manufacturing Equipment control system.</li>
 				<li>Technologies involved: 1). OO Design in three-tiered distributed architecture, C++, COM/DCOM/ATL, ODBC/OLE-DB/RDO/DAO/ADO for Oracle7.x/MSSQL6.5 and 2).  OO Designed in three-tiered web architecture, Java, Applet, JNI, HTML/JavaScript, JDBC, Oracle7.x/MSSQL6.5 and IIS4.0 on Windows NT.</li>
 				<li>Designed and developed equipment servers and reporting system to utilize semiconductor machines using C with Oracle DB (i.e., IPC with multi-processes and extensive system calls used with TCP/IP Socket).</li>
 				<li>Development/running environment: HP-UX, SUN and Windows NT.</li>
 			</ul>
 		</div>
 	</div>
 	<div style="width: 100%; font-size: 80%; ">
 		<h4>EDUCATION:</h4>
 		<div style="padding-left: 5px; padding-right: 5px">
	 		<h5>Post Graduate Diploma in Bioinformatics for Software Professionals, Centennial College, Toronto 2010 - 2011</h5>
	 		<ul >
 				<li>Java/ActionScript-based statistical analysis project done with 3,500 patients' data in coronary artery disease, 588 patients' data in knee osteoarthritis, and various Monte Carlo algorithms.</li>
 				<li>Java/ActionScript-based sequence alignment projects done for Needleman-Wounsch algorithm, searching for short DNA sequence and identifying corresponding loci, protein translation from DNA sequence and more.</li>
 				<li>Many more projects done for Genetic Algorithms, DNA compositions and more using Java/Perl/BioPerl.</li>
 				<li>Courses completed include: Molecular Biology, Biochemistry, Biostatistics, Bioinformatics tools, Bioinformatics algorithms, Advanced protein structure and analysis, Developing bioinformatics tools, Database design for biological data, and Computational Intelligence.</li>
 			</ul>
 		</div>
 		<div style="padding-left: 5px; padding-right: 5px">
	 		<h5>Master of Computer Science, National Technological University, Colorado, USA 1997 - 1998</h5>
	 		<ul >
 				<li>Advanced Data Structure from University of Florida</li>
 				<li>Object Oriented Visual C++ from Oklahoma State University</li>
 				<li>Advanced Java Distributed App Development from Southern Methodist University</li>
 				<li>Client/Server Computing from New Jersey Institute of Technology</li>
 				<li>Interactive Computer Graphics from University of Massachusetts Amherst</li>
 				<li>Internetworking Higher from New Jersey Institute of Technology</li>
 			</ul>
 		</div>
 		<div style="padding-left: 5px; padding-right: 5px">
		 		<h5>M & B of Computer Science, University of Newcastle, Australia 1991 - 1994</h5>
	 		</div>

	 	</div>
	 	</td>
	   </tr>
	</table>
</div><!-- Resume -->	

