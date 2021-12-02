using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace CourseWork
{
    public partial class ScheduleAdd : Form
    {
        int IDSchedule = 0;
        DataSet ds;
        SqlDataAdapter adapter;
        string sql4 = "SELECT * FROM Subject";
        string sql1 = "SELECT * FROM Class";
        string sql2 = "SELECT * FROM Teachers";
        string sql3 = "SELECT * FROM Day";
        string sql = "SELECT * FROM Schedule";
        string connectionString = ConfigurationManager.ConnectionStrings["hhh"].ConnectionString;
        public ScheduleAdd()
        {
            InitializeComponent();
            Text = "Добавить расписание";
        }
        public ScheduleAdd(int id)
        {
            InitializeComponent();
            IDSchedule = id;
            Text = "Изменить расписание";
        }

        private void ScheduleAdd_Load(object sender, EventArgs e)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                adapter = new SqlDataAdapter(sql1, connection);
                ds = new DataSet();
                adapter.Fill(ds);
                comboBoxClass.DataSource = ds.Tables[0];
                comboBoxClass.DisplayMember = "Class";
                comboBoxClass.ValueMember = "ID_Class";
                adapter = new SqlDataAdapter(sql2, connection);
                ds = new DataSet();
                adapter.Fill(ds);
                comboBoxTeacher.DataSource = ds.Tables[0];
                comboBoxTeacher.DisplayMember = "FullName";
                comboBoxTeacher.ValueMember = "ID_Teach";
                adapter = new SqlDataAdapter(sql3, connection);
                ds = new DataSet();
                adapter.Fill(ds);
                comboBoxDay.DataSource = ds.Tables[0];
                comboBoxDay.DisplayMember = "Day";
                comboBoxDay.ValueMember = "ID_Day";
                adapter = new SqlDataAdapter(sql4, connection);
                ds = new DataSet();
                adapter.Fill(ds);
                comboBoxSubject.DataSource = ds.Tables[0];
                comboBoxSubject.DisplayMember = "Name";
                comboBoxSubject.ValueMember = "ID_Subject";
            }
            if (IDSchedule != 0)
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string cmdStr = "select * from Schedule where ID_Sched=@ID";
                    SqlCommand command = new SqlCommand(cmdStr, connection);
                    command.Parameters.AddWithValue("@id", IDSchedule);
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    reader.Read();
                    comboBoxClass.SelectedValue = reader.GetInt32(1);
                    comboBoxDay.SelectedValue = reader.GetInt32(2);
                    comboBoxTeacher.SelectedValue = reader.GetInt32(3);
                    comboBoxSubject.SelectedValue = reader.GetInt32(4);
                    textBoxLesson.Text = reader.GetInt32(5).ToString();
                    connection.Close();
                }
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (IDSchedule == 0)
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
                    newRow["Class"] = comboBoxClass.SelectedValue;
                    newRow["Day"] = comboBoxDay.SelectedValue;
                    newRow["Teacher"] = comboBoxTeacher.SelectedValue;
                    newRow["Subjest"] = comboBoxSubject.SelectedValue;
                    newRow["Lesson"] = textBoxLesson.Text;
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
                    command.CommandText = "UPDATE Schedule SET Class = @cl, Day = @d, Teacher = @t, Subjest = @s" +
                        ", Lesson = @l WHERE ID_Sched=@ID";
                    command.Parameters.AddWithValue("@cl", comboBoxClass.SelectedValue);
                    command.Parameters.AddWithValue("@d", comboBoxDay.SelectedValue);
                    command.Parameters.AddWithValue("@t", comboBoxTeacher.SelectedValue);
                    command.Parameters.AddWithValue("@s", comboBoxSubject.SelectedValue);
                    command.Parameters.AddWithValue("@l", textBoxLesson.Text);
                    command.Parameters.AddWithValue("@id", IDSchedule);
                    connection.Open();
                    command.ExecuteNonQuery();
                    connection.Close();
                }
            }
            DialogResult = System.Windows.Forms.DialogResult.OK;
            Close();
        }
    }
}
