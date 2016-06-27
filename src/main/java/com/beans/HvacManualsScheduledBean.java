package com.beans;

import java.io.Serializable;
import java.sql.Timestamp;

public class HvacManualsScheduledBean implements Serializable
{
	private static final long serialVersionUID = 7710341364330478224L;
	private long hvacManualScheduledSeqId=-1;
	private String manualType="";
	private String brandName="";
	private String spaceType="";
	private String systemType="";
	private String modelNumber="";
	private String manualFor="";
	private String fuelType="";
	private int submittingCompanyId=-1;
	private String fileUrl="";
	private Timestamp submissionTime=null;
	private Timestamp uploadedTime=null;
	private boolean uploaded=false;
	private boolean valid=false;
	
	public long getHvacManualScheduledSeqId()
	{
		return hvacManualScheduledSeqId;
	}
	public void setHvacManualScheduledSeqId(long hvacManualScheduledSeqId)
	{
		this.hvacManualScheduledSeqId = hvacManualScheduledSeqId;
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
	public int getSubmittingCompanyId()
	{
		return submittingCompanyId;
	}
	public void setSubmittingCompanyId(int submittingCompanyId)
	{
		this.submittingCompanyId = submittingCompanyId;
	}
	public String getFileUrl()
	{
		return fileUrl;
	}
	public void setFileUrl(String fileUrl)
	{
		this.fileUrl = fileUrl;
	}
	public Timestamp getSubmissionTime()
	{
		return submissionTime;
	}
	public void setSubmissionTime(Timestamp submissionTime)
	{
		this.submissionTime = submissionTime;
	}
	public Timestamp getUploadedTime()
	{
		return uploadedTime;
	}
	public void setUploadedTime(Timestamp uploadedTime)
	{
		this.uploadedTime = uploadedTime;
	}
	public boolean isUploaded()
	{
		return uploaded;
	}
	public void setUploaded(boolean uploaded)
	{
		this.uploaded = uploaded;
	}
	public boolean isValid()
	{
		return valid;
	}
	public void setValid(boolean valid)
	{
		this.valid = valid;
	}
}
