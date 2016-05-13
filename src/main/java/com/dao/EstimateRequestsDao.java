package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Logger;

import javax.sql.DataSource;

import com.beans.EstimateRequestsBean;
import com.exceptions.DAOException;

public class EstimateRequestsDao
{
	private Logger log = Logger.getLogger(this.getClass().getName());
	private DataSource _ds=null;
	
	public EstimateRequestsDao(DataSource ds)
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
	public EstimateRequestsBean create(EstimateRequestsBean eb) throws DAOException
	{		
		log.info("Calling for create(EstimateRequestsBean lb)");
		Connection c = null;
		PreparedStatement ps = null;
		
		try
		{
			c = _ds.getConnection();
			String sQuery="insert into estimate_requests values(default,?,?,?,?,?,?,?,?,?)";
			ps = c.prepareStatement(sQuery);
			
			ps.setString(1, eb.getSubmitterName());
			ps.setString(2, eb.getSubmitterPhone());
			ps.setString(3, eb.getSubmitterEmail());
			ps.setString(4, eb.getSubmitterNote()); 
			ps.setObject(5, "B"+String.format("%08d", Integer.parseInt(Integer.toBinaryString(eb.getSelectAnimal()))), java.sql.Types.BIT);
			ps.setInt(6, eb.getFileSeqId());
			ps.setObject(7, "B"+String.format("%08d", Integer.parseInt(Integer.toBinaryString(eb.getOs()))), java.sql.Types.BIT);
			ps.setString(8, eb.getRemotePlace());
			ps.setTimestamp(9, eb.getSubmittedTime());
								
			log.info(ps.toString());
			ps.executeUpdate();
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
			log.info("Ending for create(EstimateRequestsBean lb)");
		}
		return eb;
	}
	public EstimateRequestsBean getARecord(int estimateSeqId) throws DAOException
	{
		log.info("Calling for getARecord(int estimateSeqId)");
		EstimateRequestsBean eb=new EstimateRequestsBean();
		Connection c = null;
		Statement s=null;
		ResultSet rs=null;
		try
		{
			c = _ds.getConnection();
			s = c.createStatement();
			rs = s.executeQuery("select * from estimate_requests where estimate_seq_id="+estimateSeqId);
						
			if (rs.next())
			{
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
			log.info("Ending for getARecord(EstimateRequestsBean lb)");
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
