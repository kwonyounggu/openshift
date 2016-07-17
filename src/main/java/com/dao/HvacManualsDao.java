package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.logging.Logger;

import javax.sql.DataSource;

import com.beans.FileUploadedToDropboxBean;
import com.beans.HvacManualsBean;
import com.beans.HvacManualsScheduledBean;
import com.exceptions.DAOException;

public class HvacManualsDao
{
	private Logger log = Logger.getLogger(this.getClass().getName());
	private DataSource _ds=null;
	
	public HvacManualsDao(DataSource ds)
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
	public HvacManualsBean create(HvacManualsBean hb) throws DAOException
	{		
		log.info("Calling for create(HvacManualsBean lb)");
		Connection c = null;
		PreparedStatement ps = null;
		
		try
		{
			c = _ds.getConnection();
			String sQuery="insert into hvac_manuals values(default,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			ps = c.prepareStatement(sQuery);
			
			ps.setString(1, hb.getManualType());
			ps.setString(2, hb.getBrandName());
			ps.setString(3, hb.getSpaceType());
			ps.setString(4, hb.getSystemType()); 
			ps.setString(5, hb.getModelNumber());
			ps.setString(6, hb.getManualFor());
			ps.setString(7, hb.getFuelType()); 
			ps.setObject(8, "B"+String.format("%08d", Integer.parseInt(Integer.toBinaryString(hb.getOs()))), java.sql.Types.BIT);
			ps.setInt(9, hb.getSubmittingCompanyId());
			ps.setInt(10, hb.getFileSeqId());
			
			ps.setString(11, hb.getRemotePlace());
			ps.setTimestamp(12, hb.getSubmissionTime());
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
			log.info("Ending for create(HvacManualsBean lb)");
		}
		//The following is the same as a statement implemented at the last in the catch block
		return hb;
	}
	public HvacManualsBean getARecord(int hvacManualSeqId) throws DAOException
	{
		log.info("Calling for getARecord(int hvacManualSeqId)");
		HvacManualsBean eb=new HvacManualsBean();
		Connection c = null;
		Statement s=null;
		ResultSet rs=null;
		try
		{
			c = _ds.getConnection();
			s = c.createStatement();
			rs = s.executeQuery("select * from hvac_manuals where hvac_manual_seq_id="+hvacManualSeqId);
						
			if (rs.next())
			{
				/* do it later June-23-2016
				eb.setEstimateSeqId(rs.getInt(1));
				eb.setSubmitterName(rs.getString(2));
				eb.setSubmitterPhone(rs.getString(3));
				eb.setSubmitterEmail(rs.getString(4));
				eb.setSubmitterNote(rs.getString(5));
				eb.setSelectAnimal(rs.getByte(6));
				eb.setFileSeqId(rs.getInt(7));
				eb.setOs(rs.getByte(8));
				eb.setRemotePlace(rs.getString(9));
				eb.setSubmittedTime(rs.getTimestamp(10));
				*/
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
			log.info("Ending for getARecord(HvacManualsBean lb)");
		}
		return eb;

	}
	public List<HvacManualsBean> getRecords(String arg) throws DAOException
	{
		log.info("Calling for getRecords("+arg+")");
		
		List<HvacManualsBean> list=new ArrayList<HvacManualsBean>();
		
		Connection c = null;
		Statement s=null;
		ResultSet rs=null;
		try
		{
			c = _ds.getConnection();
			s = c.createStatement();
			rs = s.executeQuery("select * from hvac_manuals "+arg);
			FileUploadedToDropboxDao fDao=new FileUploadedToDropboxDao(_ds);
			while (rs.next())
			{
				HvacManualsBean hb=new HvacManualsBean();
				
				hb.setHvacManualSeqId(rs.getInt(1));
				hb.setManualType(rs.getString(2));
				hb.setBrandName(rs.getString(3));
				hb.setSpaceType(rs.getString(4));
				hb.setSystemType(rs.getString(5));
				hb.setModelNumber(rs.getString(6));
				hb.setManualFor(rs.getString(7));
				hb.setFuelType(rs.getString(8));
				hb.setOs(rs.getByte(9));
				hb.setSubmittingCompanyId(rs.getInt(10));
				
				hb.setFileSeqId(rs.getInt(11));
				hb.setFb(fDao.getARecord(hb.getFileSeqId()));
				
				hb.setRemotePlace(rs.getString(12));
				hb.setSubmissionTime(rs.getTimestamp(13));
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
			log.info("Ending for getRecords(String arg)");
		}
		return list;

	}
	//Map<'file link','filename'>
	public Map<String, String> getKeysValuesForFiles(String sqlStatement) throws DAOException
	{
		log.info("Calling for getKeysValuesForFiles("+sqlStatement+")");
		
		Map<String, String> map=new TreeMap<String, String>();
		
		Connection c = null;
		Statement s=null;
		ResultSet rs=null;
		try
		{
			c = _ds.getConnection();
			s = c.createStatement();
			rs = s.executeQuery(sqlStatement);
			FileUploadedToDropboxDao fDao=new FileUploadedToDropboxDao(_ds);
			while (rs.next())
			{
				FileUploadedToDropboxBean fb=fDao.getARecord(rs.getInt(1));
				map.put(fb.getDropboxFilePath(), fb.getFileNameSubmitted());
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
			log.info("Ending for getKeysValuesForFiles(String sqlStatement)");
		}
		return map;

	}
	//select brand_name, count(*) from hvac_manuals where valid=true group by brand_name order by brand_name asc;
	public Map<String, Integer> getBrandNames(String arg) throws DAOException
	{
		log.info("Calling for getBrandNames("+arg+")");
		
		Map<String, Integer> map=new TreeMap<String, Integer>();
		
		Connection c = null;
		Statement s=null;
		ResultSet rs=null;
		try
		{
			c = _ds.getConnection();
			s = c.createStatement();
			rs = s.executeQuery("select brand_name, count(*) from hvac_manuals "+arg);
			while (rs.next())
			{
				map.put(rs.getString(1), rs.getInt(2));
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
			log.info("Ending for getBrandNames(String arg)");
		}
		return map;

	}
	//select brand_name, count(*) from hvac_manuals where valid=true group by brand_name order by brand_name asc;
	public Map<String, Integer> getKeysValues(String sqlStatement) throws DAOException
	{
		log.info("Calling for getKeysValues("+sqlStatement+")");
		
		Map<String, Integer> map=new TreeMap<String, Integer>();
		
		Connection c = null;
		Statement s=null;
		ResultSet rs=null;
		try
		{
			c = _ds.getConnection();
			s = c.createStatement();
			rs = s.executeQuery(sqlStatement);
			while (rs.next())
			{
				map.put(rs.getString(1), rs.getInt(2));
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
			log.info("Ending for getKeysValues(String sqlStatement)");
		}
		return map;

	}
	public Map<String, String> getKeysValues_SS(String sqlStatement) throws DAOException
	{
		log.info("Calling for getKeysValues("+sqlStatement+")");
		
		Map<String, String> map=new TreeMap<String, String>();
		
		Connection c = null;
		Statement s=null;
		ResultSet rs=null;
		try
		{
			c = _ds.getConnection();
			s = c.createStatement();
			rs = s.executeQuery(sqlStatement);
			while (rs.next())
			{
				map.put(rs.getString(1), rs.getString(2));
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
			log.info("Ending for getKeysValues(String sqlStatement)");
		}
		return map;

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
