package com.beans;

import java.io.Serializable;

public class FileUploadedToDropboxBean implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int fileSeqId=-1;
	private String dropboxFilePath="";
	private String fileNameSubmitted="";
	private int fileSize=-1;//in K-bytes, upto 32,767 Kbytes in max limit but the user's limit is 5 MB so sufficient enough
	public int getFileSeqId()
	{
		return fileSeqId;
	}
	public void setFileSeqId(int fileSeqId)
	{
		this.fileSeqId = fileSeqId;
	}
	public String getDropboxFilePath()
	{
		return dropboxFilePath;
	}
	public void setDropboxFilePath(String dropboxFilePath)
	{
		this.dropboxFilePath = dropboxFilePath;
	}
	public String getFileNameSubmitted()
	{
		return fileNameSubmitted;
	}
	public void setFileNameSubmitted(String fileNameSubmitted)
	{
		this.fileNameSubmitted = fileNameSubmitted;
	}
	public int getFileSize()
	{
		return fileSize;
	}
	public void setFileSize(int fileSize)
	{
		this.fileSize = fileSize;
	}
	public static long getSerialversionuid()
	{
		return serialVersionUID;
	}
	public String toString()
	{		
		return "File SeqID: "+fileSeqId+"\n"+
		  	   "DropBox File Path: "+dropboxFilePath+"\n"+
		  	   "File Name Submitted: "+fileNameSubmitted+"\n"+
		  	   "File Size (Kb): "+fileSize;
	}
}
	