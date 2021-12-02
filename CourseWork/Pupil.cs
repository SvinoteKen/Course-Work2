using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace CourseWork
{
    public partial class Pupil : Form
    {
        int IDPupil = 0;
        DataSet ds;
        SqlDataAdapter adapter;
        string sql = "SELECT * FROM Pupils";
        string sql1 = "SELECT * FROM Class ORDER BY Class";
        string connectionString = ConfigurationManager.ConnectionStrings["hhh"].ConnectionString;
        public Pupil()
        {
            InitializeComponent();
            Text = "Добавить учащаегося";
        }
        public Pupil(int id)
        {
            InitializeComponent();
            IDPupil = id;
            Text = "Изменить учащаегося";
        }
        private void button1_Click(object sender, EventArgs e)
        {
            if (IDPupil == 0)
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    SqlDataAdapter adapter = new SqlDataAdapter(sql, connection);
                    DataSet ds = new DataSet();
                    adapter.Fill(ds);
                    DataTable dt = ds.Tables[0];
                    // добавим новую строку
                    DataRow newRow = dt.NewRow();
                    newRow["FullName"] = textBoxFullName.Text;
                    newRow["BirthDate"] = textBoxBirthDate.Text;
                    newRow["Years"] = textBoxYears.Text;
                    newRow["Class"] = comboBoxClass.SelectedValue ;
                    newRow["District"] = textBoxDistrict.Text;
                    newRow["Social"] = textBoxSocial.Text;
                    newRow["Phone"] = textBoxPhone.Text;
                    newRow["DateOfReceipt"] = textBoxDateOfReceipt.Text;
                    newRow["DateOfDisposal"] = textBoxDateOfDisposal.Text;
                    newRow["Parent"] = textBoxParent.Text;
                    newRow["PhoneParent"] = textBoxPhoneParent.Text;
                    dt.Rows.Add(newRow);
                    // создаем объект SqlCommandBuilder
                    SqlCommandBuilder commandBuilder = new SqlCommandBuilder(adapter);
                    adapter.Update(ds);
                    ds.Clear();

                }
            }
            else
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                using (SqlCommand command = connection.CreateCommand())
                {
                    command.CommandText = "UPDATE Pupils SET FullName = @fn, BirthDate = @bd, Years = @y, Class = @cl" +
                        ", District = @dist, Social = @s, Phone = @phone," +
                        "DateOfReceipt = @dor, DateOfDisposal = @dod, Parent = @p, PhoneParent = @pp WHERE ID_Pupil=@ID";
                    command.Parameters.AddWithValue("@fn", textBoxFullName.Text);
                    command.Parameters.AddWithValue("@bd", textBoxBirthDate.Text);
                    command.Parameters.AddWithValue("@y", textBoxYears.Text);
                    command.Parameters.AddWithValue("@cl", comboBoxClass.SelectedValue);
                    command.Parameters.AddWithValue("@dist", textBoxDistrict.Text);
                    command.Parameters.AddWithValue("@s", textBoxSocial.Text);
                    command.Parameters.AddWithValue("@phone", textBoxPhone.Text);
                    command.Parameters.AddWithValue("@dor", textBoxDateOfReceipt.Text);
                    if (textBoxDateOfDisposal.Text == null)
                    {
                        command.Parameters.AddWithValue("@dod", DBNull.Value);
                    }
                    else 
                    {
                        command.Parameters.AddWithValue("@dod", textBoxDateOfDisposal.Text);
                    }
                    command.Parameters.AddWithValue("@p", textBoxParent.Text);
                    command.Parameters.AddWithValue("@pp", textBoxPhoneParent.Text);
                    command.Parameters.AddWithValue("@id", IDPupil);
                    connection.Open();
                    command.ExecuteNonQuery();
                    connection.Close();
                }
            }
            DialogResult = System.Windows.Forms.DialogResult.OK;
            Close();
        }

        private void Pupil_Load(object sender, EventArgs e)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                adapter = new SqlDataAdapter(sql1, connection);
                ds = new DataSet();
                adapter.Fill(ds);
                comboBoxClass.DataSource = ds.Tables[0];
                comboBoxClass.DisplayMember = "Class";
                comboBoxClass.ValueMember = "ID_Class";
            }
            if (IDPupil != 0)
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string cmdStr = "select * from Pupils where ID_Pupil=@ID";
                    SqlCommand command = new SqlCommand(cmdStr, connection);
                    command.Parameters.AddWithValue("@id", IDPupil);
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    reader.Read();
                    textBoxFullName.Text = reader.GetString(1);
                    textBoxBirthDate.Text = reader.GetDateTime(2).ToString("dd/MM/yyyy");
                    textBoxYears.Text = reader.GetInt32(3).ToString();
                    comboBoxClass.SelectedValue = reader.GetInt32(4);
                    textBoxDistrict.Text = reader.GetString(5);
                    textBoxSocial.Text = reader.GetString(6);
                    textBoxPhone.Text = reader.GetString(7);
                    textBoxDateOfReceipt.Text = reader.GetDateTime(8).ToString("dd/MM/yyyy");
                    textBoxDateOfDisposal.Text = reader.GetDateTime(9).ToString("dd/MM/yyyy");
                    textBoxParent.Text = reader.GetString(10);
                    textBoxPhoneParent.Text = reader.GetString(11);
                    connection.Close();
                }
            }
        }
    }
}
