package com.beans;

import java.io.Serializable;
import java.sql.Timestamp;

public class EstimateRequestsBean implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int estimateSeqId=-1;
	private String submitterName="";
	private String submitterPhone="";
	private String submitterEmail="";
	private String submitterNote="";
	private byte selectAnimal=-1;
	private int fileSeqId=-1;
	private byte os=-1;
	private String remotePlace="";
	private Timestamp submittedTime=null;
	
	//just for the extra information
	private FileUploadedToDropboxBean fb=null;
	
	public FileUploadedToDropboxBean getFb()
	{
		return fb;
	}
	public void setFb(FileUploadedToDropboxBean fb)
	{
		this.fb = fb;
	}
	public int getEstimateSeqId()
	{
		return estimateSeqId;
	}
	public void setEstimateSeqId(int estimateSeqId)
	{
		this.estimateSeqId = estimateSeqId;
	}
	public String getSubmitterName()
	{
		return submitterName;
	}
	public void setSubmitterName(String submitterName)
	{
		this.submitterName = submitterName;
	}
	public String getSubmitterPhone()
	{
		return submitterPhone;
	}
	public void setSubmitterPhone(String submitterPhone)
	{
		this.submitterPhone = submitterPhone;
	}
	public String getSubmitterEmail()
	{
		return submitterEmail;
	}
	public void setSubmitterEmail(String submitterEmail)
	{
		this.submitterEmail = submitterEmail;
	}
	public String getSubmitterNote()
	{
		return submitterNote;
	}
	public void setSubmitterNote(String submitterNote)
	{
		this.submitterNote = submitterNote;
	}
	public short getSelectAnimal()
	{
		return selectAnimal;
	}
	public void setSelectAnimal(byte selectAnimal)
	{
		this.selectAnimal = selectAnimal;
	}
	public int getFileSeqId()
	{
		return fileSeqId;
	}
	public void setFileSeqId(int fileSeqId)
	{
		this.fileSeqId = fileSeqId;
	}
	public Byte getOs()
	{
		return os;
	}
	public void setOs(Byte os)
	{
		this.os = os;
	}
	public String getRemotePlace()
	{
		return remotePlace;
	}
	public void setRemotePlace(String remotePlace)
	{
		this.remotePlace = remotePlace;
	}
	public Timestamp getSubmittedTime()
	{
		return submittedTime;
	}
	public void setSubmittedTime(Timestamp submittedTime)
	{
		this.submittedTime = submittedTime;
	}
	public String toString()
	{
		//https://www.dropbox.com/home/Apps/webmonster/estimates?preview=Younggu_kwon_Unchained_melody___%EC%82%AC%EB%9E%91%EA%B3%BC%EC%98%81%ED%98%BCost_(alto)_2016_06_02_11_27_44.enc
		return  "<p>"+
					"<strong>Submitter Name</strong>: " + submitterName +"<br/>"+
					"<strong>Submitter Phone</strong>: " + submitterPhone +"<br/>"+
					"<strong>Submitter E-Mail</strong>: " + submitterEmail +"<br/>"+
					"<strong>Submitter Note</strong>: <p>" + submitterNote +"</p>"+
					"<strong>Selected Animal</strong>: "+ selectAnimal +"<br/>"+
					"<strong>File Path</strong>: <a href='"+ fb.getDropboxFilePath()+"'>"+fb.getDropboxFilePath()+"</a><br/>"+
					"<strong>OS</strong>: " + (os==0? "PC" : (os==1? "TABLET" : "MOBILE")) +"<br/>"+
					"<strong>Remote Place</strong>: " + remotePlace +"<br/>"+
					"<strong>Submitter Time</strong>: " +submittedTime+
				"</p>";
	}
	public String toClient()
	{
		return
				"<p>"+
				"Hi "+submitterName+",<br/><br/>"+
				"Thank you for stopping by the WebMonster Freelance App Developer website and submitting your estimate information.<br/><br/>"+
				"I will get back to you as soon as possible!<br/><br/>"+
				"Sincerely,<br/>John KWON,<br/>"+
				"Freelance App Developer,<br/>"+
				"<a href='http://www.webmonster.ca'>www.webmonster.ca</a>"+
				"</p>";
	}
}
