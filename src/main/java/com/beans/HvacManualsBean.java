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
	private int submittingCompanyId=-1;
	private int fileSeqId=-1;
	private String remotePlace="";
	private Timestamp submissionTime=null;
	private boolean valid=false;
	//just for the extra information
	private FileUploadedToDropboxBean fb=null;
}
