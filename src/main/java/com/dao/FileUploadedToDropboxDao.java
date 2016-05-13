package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Logger;

import javax.sql.DataSource;

import com.beans.FileUploadedToDropboxBean;
import com.exceptions.DAOException;

public class FileUploadedToDropboxDao
{
	private Logger log = Logger.getLogger(this.getClass().getName());
	private DataSource _ds=null;
	
	public FileUploadedToDropboxDao(DataSource ds)
	{
		_ds=ds;
	}
	//String sqlString="SELECT * FROM standard_reference_interval_v2_0 where analyte like '"+analyte+"%' and metric_system=b'"+(metric? 1 : 0)+"';";
	//sb.setMatric_system(rs.getString(14));
	//Now I'd like to set the field in a PreparedStatement
	//PreparedStatement update =
	//		connection.prepareStatement("UPDATE test SET a=?");
	//		update.setObject(1, "B10101010", java.sql.Types.BIT);
	//		update.executeUpdate();
	//		 
	//		and I get
	//		org.postgresql.util.PSQLException: ERROR: column "a"
	//		is of type bit but expression is of type boolean
	public FileUploadedToDropboxBean create(FileUploadedToDropboxBean fb) throws DAOException
	{		
		log.info("Calling for create(FileUploadedToDropboxBean fb)");
		Connection c = null;
		PreparedStatement ps = null;
		Statement s=null;
		ResultSet rs=null;
		try
		{
			c = _ds.getConnection();
			String sQuery="insert into file_uploaded_to_dropbox values(default,?,?,?)";
			ps = c.prepareStatement(sQuery);
			
			ps.setString(1, fb.getDropboxFilePath());
			ps.setString(2, fb.getFileNameSubmitted());
			ps.setInt(3, fb.getFileSize());
								
			ps.executeUpdate();
			
			s = c.createStatement();
			rs = s.executeQuery("SELECT CURRVAL('file_seq_id');");
			rs.next();

			fb.setFileSeqId(rs.getInt(1));
		}
		catch (SQLException e)
		{
			log.severe(e.getMessage());
			throw new DAOException(e);
		}
		finally
		{
			closeResultSet(rs);
			closeStatement(s);
			closeStatement(ps);
			closeConnection(c);
			log.info("Ending for create(FileUploadedToDropboxBean lb)");
		}
		return fb;
	}
	public FileUploadedToDropboxBean getARecord(int fileSeqId) throws DAOException
	{
		log.info("Calling for getARecord(int fileSeqId)");
		FileUploadedToDropboxBean fb=new FileUploadedToDropboxBean();
		Connection c = null;
		Statement s=null;
		ResultSet rs=null;
		try
		{
			c = _ds.getConnection();
			s = c.createStatement();
			rs = s.executeQuery("select * from file_uploaded_to_dropbox where file_seq_id="+fileSeqId);
						
			if (rs.next())
			{
				fb.setFileSeqId(rs.getInt(1));
				fb.setDropboxFilePath(rs.getString(2));
				fb.setFileNameSubmitted(rs.getString(3));
				fb.setFileSize(rs.getShort(4));
			}
		}
		catch (SQLException e)
		{
			log.severe(e.getMessage());
			throw new DAOException(e);
		}
		finally
		{
			closeResultSet(rs);
			closeStatement(s);
			closeConnection(c);
			log.info("Ending for getARecord(int fileSeqId)");
		}
		return fb;

	}
	private void closeResultSet(ResultSet rs)
	{
		try
		{
			if(rs!=null) rs.close();
			rs=null;
		}
		catch (Exception e)
		{
			log.severe(e.getMessage());
		}
	}
	private void closeConnection(Connection con)
	{
		try
		{
			if(con!=null) con.close();
			con=null;
		}
		catch (Exception e)
		{
			log.severe(e.getMessage());
		}
	}
	private void closeStatement(Statement stmt)
	{
		try
		{
			if(stmt!=null) stmt.close();
			stmt=null;
		}
		catch (Exception e)
		{
			log.severe(e.getMessage());
		}
	}
}
