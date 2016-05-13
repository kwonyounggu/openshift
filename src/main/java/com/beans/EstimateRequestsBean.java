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
}