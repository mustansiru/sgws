using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SGWSPromoPlan.DAL.SQLOperation
{
    public class SQLHelper
    {
        SqlConnection MySqlConnction;
        SqlCommand MySqlCommand;
        SqlDataAdapter MySqlDataAdapter;

        public SQLHelper(string ConnectionString)
        {
            OpenConnction(ConnectionString);
        }
        #region Private Method

        private void OpenConnction(string ConnectionString)
        {
            try
            {
                MySqlConnction = new SqlConnection(ConnectionString);
                MySqlCommand = new SqlCommand();
                MySqlCommand.CommandTimeout = 240;

                MySqlDataAdapter = new SqlDataAdapter();

                MySqlConnction.ConnectionString = ConnectionString;
                MySqlConnction.Open();

            }
            catch (Exception)
            {
                CloseConnction(MySqlConnction);
                throw;
            }

        }

        private void CloseConnction(SqlConnection pConn)
        {
            if (pConn != null)
            {
                if (pConn.State == System.Data.ConnectionState.Open)
                {
                    pConn.Close();
                    pConn.Dispose();
                    pConn = null;
                }
            }
        }

        private void DisposeAllConnObjects()
        {
            MySqlCommand.Dispose();
            MySqlCommand = null;

            MySqlDataAdapter.Dispose();
            MySqlDataAdapter = null;

            CloseConnction(MySqlConnction);
        }



        #endregion

        #region FillDataTable

        public void GetDataTable(string pStrCommandText, DataTable dataTable, CommandType pEnmCommandType, List<SqlParameter> pParamList = null)
        {
            try
            {
                MySqlCommand.CommandType = pEnmCommandType;
                MySqlCommand.CommandText = pStrCommandText;
                MySqlCommand.Connection = MySqlConnction;

                if (pEnmCommandType == CommandType.StoredProcedure && pParamList != null)
                {
                    for (int i = 0; i < pParamList.Count; i++)
                    {
                        if (pParamList[i] != null)
                            MySqlCommand.Parameters.Add(pParamList[i]);
                    }
                }

                MySqlDataAdapter.SelectCommand = MySqlCommand;

                MySqlDataAdapter.Fill(dataTable);
            }
            catch (SqlException ex)
            {
                throw;
            }
            finally
            {
                dataTable = null;
                DisposeAllConnObjects();
            }
        }

        #endregion

        #region FillDataTable

        public void GetDataSet(string pStrCommandText, DataSet dataSet, CommandType pEnmCommandType, List<SqlParameter> pParamList = null)
        {
            try
            {
                MySqlCommand.CommandType = pEnmCommandType;
                MySqlCommand.CommandText = pStrCommandText;
                MySqlCommand.Connection = MySqlConnction;

                if (pEnmCommandType == CommandType.StoredProcedure && pParamList != null)
                {
                    for (int i = 0; i < pParamList.Count; i++)
                    {
                        if (pParamList[i] != null)
                            MySqlCommand.Parameters.Add(pParamList[i]);
                    }
                }

                MySqlDataAdapter.SelectCommand = MySqlCommand;

                MySqlDataAdapter.Fill(dataSet);
            }
            catch (SqlException ex)
            {
                throw;
            }
            finally
            {
                dataSet = null;
                DisposeAllConnObjects();
            }
        }

        #endregion

        #region SqlDataReader

        public SqlDataReader ExeReader(string pStrCommandText, CommandType pEnmCommandType, List<SqlParameter> pParamList = null)
        {
            try
            {

                MySqlCommand.CommandType = CommandType.StoredProcedure;
                MySqlCommand.CommandText = pStrCommandText;
                MySqlCommand.Connection = MySqlConnction;

                if (pEnmCommandType == CommandType.StoredProcedure && pParamList != null)
                {                  
                    MySqlCommand.CommandType = CommandType.StoredProcedure;
                    for (int i = 0; i < pParamList.Count; i++)
                    {
                        if (pParamList[i] != null)
                            MySqlCommand.Parameters.Add(pParamList[i]);
                    }
                }
                else if (pEnmCommandType == CommandType.Text)
                {
                    MySqlCommand.CommandType = CommandType.Text;
                }

                return MySqlCommand.ExecuteReader();
            }
            catch (SqlException ex)
            {
                throw;
            }

        }

        #endregion

        #region Execute Non Query

        public int ExeNonQuery(string pStrCommandText, CommandType pEnmCommandType, List<SqlParameter> pParamList = null)
        {
            int IntResult = 0;
            try
            {
                MySqlCommand.CommandType = CommandType.StoredProcedure;
                MySqlCommand.CommandText = pStrCommandText;
                MySqlCommand.Connection = MySqlConnction;
                MySqlCommand.CommandTimeout = 6000;
                if (pEnmCommandType == CommandType.StoredProcedure && pParamList != null)
                {
                    MySqlCommand.CommandType = CommandType.StoredProcedure;
                    for (int i = 0; i < pParamList.Count; i++)
                    {
                        if (pParamList[i] != null)
                            MySqlCommand.Parameters.Add(pParamList[i]);
                    }
                }
                else if (pEnmCommandType == CommandType.Text)
                {
                    MySqlCommand.CommandType = CommandType.Text;
                }

                IntResult = MySqlCommand.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                return -1;
            }
            finally
            {
                DisposeAllConnObjects();
            }
            return IntResult;
        }

        #endregion

        #region Execute Scalar

        public string ExeScalar(string pStrCommandText, CommandType pEnmCommandType, List<SqlParameter> pParamList = null)
        {
            string StrResult = "";
            try
            {
                MySqlCommand.CommandType = CommandType.StoredProcedure;
                MySqlCommand.CommandText = pStrCommandText;
                MySqlCommand.Connection = MySqlConnction;

                if (pEnmCommandType == CommandType.StoredProcedure && pParamList != null)
                {
                    MySqlCommand.CommandType = CommandType.StoredProcedure;
                    for (int i = 0; i < pParamList.Count; i++)
                    {
                        if (pParamList[i] != null)
                            MySqlCommand.Parameters.Add(pParamList[i]);
                    }
                }
                else if (pEnmCommandType == CommandType.Text)
                {
                    MySqlCommand.CommandType = CommandType.Text;
                }

                StrResult = MySqlCommand.ExecuteScalar().ToString();

            }
            catch (SqlException ex)
            {
                //MessageBox.Show(ex.Message.ToString());
                return "";
            }
            finally
            {
                DisposeAllConnObjects();
            }
            return StrResult;
        }

        #endregion
    }
}
