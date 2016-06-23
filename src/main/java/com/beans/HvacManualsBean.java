package com.beans;

import java.io.Serializable;
import java.sql.Timestamp;

public class HvacManualsBean implements Serializable
{
	private static final long serialVersionUID = -2884718064885239976L;
	private int hvacManualSeqId=-1;
	private String manualType="";
	private String brandName="";
	private String spaceType="";
	private String systemType="";
	private String modelNumber="";
	private String manualFor="";
	private String fuelType="";
	private byte os=-1;
	private int submittingCompanyId=-1;
	private int fileSeqId=-1;
	private String remotePlace="";
	private Timestamp submissionTime=null;
	private boolean valid=false;
	//just for the extra information
	private FileUploadedToDropboxBean fb=null;
	public int getHvacManualSeqId()
	{
		return hvacManualSeqId;
	}
	public void setHvacManualSeqId(int hvacManualSeqId)
	{
		this.hvacManualSeqId = hvacManualSeqId;
	}
	public String getManualType()
	{
		return manualType;
	}
	public void setManualType(String manualType)
	{
		this.manualType = manualType;
	}
	public String getBrandName()
	{
		return brandName;
	}
	public void setBrandName(String brandName)
	{
		this.brandName = brandName;
	}
	public String getSpaceType()
	{
		return spaceType;
	}
	public void setSpaceType(String spaceType)
	{
		this.spaceType = spaceType;
	}
	public String getSystemType()
	{
		return systemType;
	}
	public void setSystemType(String systemType)
	{
		this.systemType = systemType;
	}
	public String getModelNumber()
	{
		return modelNumber;
	}
	public void setModelNumber(String modelNumber)
	{
		this.modelNumber = modelNumber;
	}
	public String getManualFor()
	{
		return manualFor;
	}
	public void setManualFor(String manualFor)
	{
		this.manualFor = manualFor;
	}
	public String getFuelType()
	{
		return fuelType;
	}
	public void setFuelType(String fuelType)
	{
		this.fuelType = fuelType;
	}
	public byte getOs()
	{
		return os;
	}
	public void setOs(byte os)
	{
		this.os = os;
	}
	public int getSubmittingCompanyId()
	{
		return submittingCompanyId;
	}
	public void setSubmittingCompanyId(int submittingCompanyId)
	{
		this.submittingCompanyId = submittingCompanyId;
	}
	public int getFileSeqId()
	{
		return fileSeqId;
	}
	public void setFileSeqId(int fileSeqId)
	{
		this.fileSeqId = fileSeqId;
	}
	public String getRemotePlace()
	{
		return remotePlace;
	}
	public void setRemotePlace(String remotePlace)
	{
		this.remotePlace = remotePlace;
	}
	public Timestamp getSubmissionTime()
	{
		return submissionTime;
	}
	public void setSubmissionTime(Timestamp submissionTime)
	{
		this.submissionTime = submissionTime;
	}
	public boolean isValid()
	{
		return valid;
	}
	public void setValid(boolean valid)
	{
		this.valid = valid;
	}
	public FileUploadedToDropboxBean getFb()
	{
		return fb;
	}
	public void setFb(FileUploadedToDropboxBean fb)
	{
		this.fb = fb;
	}
}
