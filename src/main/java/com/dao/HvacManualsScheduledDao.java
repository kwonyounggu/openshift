package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import javax.sql.DataSource;

import com.beans.HvacManualsScheduledBean;
import com.exceptions.DAOException;

public class HvacManualsScheduledDao
{
	private Logger log = Logger.getLogger(this.getClass().getName());
	private DataSource _ds=null;
	
	public HvacManualsScheduledDao(DataSource ds)
	{
		_ds=ds;
	}

	public HvacManualsScheduledBean create(HvacManualsScheduledBean hb) throws DAOException
	{		
		log.info("Calling for create(HvacManualsScheduledBean lb)");
		Connection c = null;
		PreparedStatement ps = null;
		
		try
		{
			c = _ds.getConnection();
			String sQuery="insert into hvac_manuals_scheduled values(default,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			ps = c.prepareStatement(sQuery);
			
			ps.setString(1, hb.getManualType());
			ps.setString(2, hb.getBrandName());
			ps.setString(3, hb.getSpaceType());
			ps.setString(4, hb.getSystemType()); 
			ps.setString(5, hb.getModelNumber());
			ps.setString(6, hb.getManualFor());
			ps.setString(7, hb.getFuelType()); 
			ps.setInt(8, hb.getSubmittingCompanyId());
			ps.setString(9, hb.getFileUrl());
			ps.setTimestamp(10, hb.getSubmissionTime());
			ps.setTimestamp(11, hb.getUploadedTime());
			ps.setBoolean(12, hb.isUploaded());
			ps.setBoolean(13, hb.isValid());
								
			log.info(ps.toString());
			//The following ps statement does not work with bit operation
			//ps.executeUpdate();
			c.createStatement().execute(ps.toString());
		}
		catch (SQLException e)
		{
			log.severe(e.getMessage());
			throw new DAOException(e);
		}
		finally
		{
			closeStatement(ps);
			closeConnection(c);
			log.info("Ending for create(HvacManualsScheduledBean lb)");
		}
		//The following is the same as a statement implemented at the last in the catch block
		return hb;
	}
	public List<HvacManualsScheduledBean> getRecordsToUpload(String arg) throws DAOException
	{
		log.info("Calling for getRecordsToUpload("+arg+")");
		
		List<HvacManualsScheduledBean> list=new ArrayList<HvacManualsScheduledBean>();
		
		Connection c = null;
		Statement s=null;
		ResultSet rs=null;
		try
		{
			c = _ds.getConnection();
			s = c.createStatement();
			rs = s.executeQuery("select * from hvac_manuals_scheduled "+arg);
			
			while (rs.next())
			{
				HvacManualsScheduledBean hb=new HvacManualsScheduledBean();
				
				hb.setHvacManualScheduledSeqId(rs.getLong(1));
				hb.setManualType(rs.getString(2));
				hb.setBrandName(rs.getString(3));
				hb.setSpaceType(rs.getString(4));
				hb.setSystemType(rs.getString(5));
				hb.setModelNumber(rs.getString(6));
				hb.setManualFor(rs.getString(7));
				hb.setFuelType(rs.getString(8));
				hb.setSubmittingCompanyId(rs.getInt(9));
				hb.setFileUrl(rs.getString(10));
				hb.setSubmissionTime(rs.getTimestamp(11));
				hb.setUploadedTime(rs.getTimestamp(12));
				hb.setUploaded(rs.getBoolean(13));
				hb.setValid(rs.getBoolean(14));

				list.add(hb);
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
			log.info("Ending for getRecordsToUpload(HvacManualsScheduledBean lb)");
		}
		return list;

	}
	//return the number of rows updated
	public int update(String arg) throws DAOException
	{
		log.info("Calling for update("+arg+")");
		
		Connection c = null;
		Statement s=null;


		try
		{
			c = _ds.getConnection();
			s = c.createStatement();
			int rows = s.executeUpdate(arg) ;

			return rows;
		}
		catch (SQLException e)
		{
			log.severe(e.getMessage());
			throw new DAOException(e);
		}
		finally
		{
			closeStatement(s);
			closeConnection(c);
			log.info("Ending for update("+arg+")");
		}
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
