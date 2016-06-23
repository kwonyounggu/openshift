package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Logger;

import javax.sql.DataSource;

import com.beans.HvacManualsBean;
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
