using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace CourseWork
{
    public partial class PerformanceAdd : Form
    {
        int IDPerf = 0;
        DataSet ds;
        SqlDataAdapter adapter;
        string sql4 = "SELECT * FROM Subject";
        string sql1 = "SELECT * FROM Class";
        string sql3 = "SELECT * FROM Period";
        string sql = "SELECT * FROM Pupils";
        string sql5 = "SELECT * FROM Performance";
        string connectionString = ConfigurationManager.ConnectionStrings["hhh"].ConnectionString;
        public PerformanceAdd()
        {
            InitializeComponent();
            Text = "Добавить успеваемость";
        }
        public PerformanceAdd(int id)
        {
            InitializeComponent();
            IDPerf = id;
            Text = "Изменить успеваемость";
        }

        private void PerfomanceAdd_Load(object sender, EventArgs e)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                adapter = new SqlDataAdapter(sql1, connection);
                ds = new DataSet();
                adapter.Fill(ds);
                comboBoxClass.DataSource = ds.Tables[0];
                comboBoxClass.DisplayMember = "Class";
                comboBoxClass.ValueMember = "ID_Class";
                adapter = new SqlDataAdapter(sql, connection);
                ds = new DataSet();
                adapter.Fill(ds);
                comboBoxPupil.DataSource = ds.Tables[0];
                comboBoxPupil.DisplayMember = "FullName";
                comboBoxPupil.ValueMember = "ID_Pupil";
                adapter = new SqlDataAdapter(sql3, connection);
                ds = new DataSet();
                adapter.Fill(ds);
                comboBoxPeriod.DataSource = ds.Tables[0];
                comboBoxPeriod.DisplayMember = "Name";
                comboBoxPeriod.ValueMember = "ID_Period";
                adapter = new SqlDataAdapter(sql4, connection);
                ds = new DataSet();
                adapter.Fill(ds);
                comboBoxSubject.DataSource = ds.Tables[0];
                comboBoxSubject.DisplayMember = "Name";
                comboBoxSubject.ValueMember = "ID_Subject";
            }
            if (IDPerf != 0)
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string cmdStr = "select * from Performance where ID_Perf=@ID";
                    SqlCommand command = new SqlCommand(cmdStr, connection);
                    command.Parameters.AddWithValue("@id", IDPerf);
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    reader.Read();
                    comboBoxPupil.SelectedValue = reader.GetInt32(1);
                    textBoxGrade.Text = reader.GetInt32(2).ToString();
                    comboBoxSubject.SelectedValue = reader.GetInt32(3);
                    comboBoxPeriod.SelectedValue = reader.GetInt32(4);
                    comboBoxClass.SelectedValue = reader.GetInt32(5);
                    connection.Close();
                }
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (IDPerf == 0)
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    SqlDataAdapter adapter = new SqlDataAdapter(sql5, connection);
                    DataSet ds = new DataSet();
                    adapter.Fill(ds);
                    DataTable dt = ds.Tables[0];
                    // добавим новую строку
                    DataRow newRow = dt.NewRow();
                    try
                    {
                        newRow["Pupil"] = comboBoxPupil.SelectedValue;
                        newRow["Grade"] = textBoxGrade.Text;
                        newRow["Lesson"] = comboBoxSubject.SelectedValue;
                        newRow["Period"] = comboBoxPeriod.SelectedValue;
                        newRow["Class"] = comboBoxClass.SelectedValue;
                    }
                    catch (Exception)
                    {
                        MessageBox.Show("Одно из полей не удовлетворяет требуемому типу данных");
                        return;
                    }
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
                    command.CommandText = "UPDATE Performance SET Pupil = @p, Grade = @g, Lesson = @l, Period = @per" +
                        ", Class = @cl WHERE ID_Perf=@ID";
                    command.Parameters.AddWithValue("@p", comboBoxPupil.SelectedValue);
                    command.Parameters.AddWithValue("@g", textBoxGrade.Text);
                    command.Parameters.AddWithValue("@l", comboBoxSubject.SelectedValue);
                    command.Parameters.AddWithValue("@per", comboBoxPeriod.SelectedValue);
                    command.Parameters.AddWithValue("@cl", comboBoxClass.SelectedValue);
                    command.Parameters.AddWithValue("@ID", IDPerf);
                    connection.Open();
                    try
                    {
                        command.ExecuteNonQuery();
                    }
                    catch (Exception)
                    {
                        MessageBox.Show("Одно из полей не удовлетворяет требуемому типу данных");
                        return;
                    }
                    connection.Close();
                }
            }
            DialogResult = System.Windows.Forms.DialogResult.OK;
            Close();
        }
    }
}
