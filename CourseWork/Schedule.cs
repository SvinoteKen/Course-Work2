using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace CourseWork
{
    public partial class Schedule : Form
    {
        DataSet ds;
        SqlDataAdapter adapter;
        string sql = "SELECT Schedule.Lesson AS Урок, Subject.Name AS Предмет " +
            "FROM Day INNER JOIN " +
            "Schedule ON Day.ID_Day = Schedule.Day INNER JOIN " +
            "Class ON Schedule.Class = Class.ID_Class INNER JOIN " +
            "Teachers ON Schedule.Teacher = Teachers.ID_Teach INNER JOIN " +
            "Subject ON Schedule.Subjest = Subject.ID_Subject";
        string sql1 = "SELECT Schedule.Lesson AS Урок, Subject.Name AS Предмет , Class.Class AS Класс " +
            "FROM Day INNER JOIN " +
            "Schedule ON Day.ID_Day = Schedule.Day INNER JOIN " +
            "Class ON Schedule.Class = Class.ID_Class INNER JOIN " +
            "Teachers ON Schedule.Teacher = Teachers.ID_Teach INNER JOIN " +
            "Subject ON Schedule.Subjest = Subject.ID_Subject";
        string sql2 = "SELECT * FROM Class ORDER BY Class";
        string sql3 = "SELECT * FROM Day ORDER BY ID_Day";
        string sql4 = "SELECT * FROM Teachers";
        string sqlSched = "SELECT Schedule.ID_Sched, Class.Class AS Класс, Day.Day AS День, Teachers.FullName AS Учитель, Subject.Name AS Предмет, " +
            "Schedule.Lesson AS Урок FROM Day INNER JOIN " +
            "Schedule ON dbo.Day.ID_Day = Schedule.Day INNER JOIN " +
            "Class ON Schedule.Class = Class.ID_Class INNER JOIN " +
            "Subject ON Schedule.Subjest = Subject.ID_Subject INNER JOIN " +
            "Teachers ON Schedule.Teacher = Teachers.ID_Teach";
        string connectionString = ConfigurationManager.ConnectionStrings["hhh"].ConnectionString;
        public Schedule()
        {
            InitializeComponent();
            FillScheduleGrid();
            if (Status.Value == Role.Pupil)
            {
                radioButton2.Enabled = false;
                button2.Enabled = false;
                рассписаниеToolStripMenuItem.Enabled = false;
            }
        }
        public void FillScheduleGrid()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                adapter = new SqlDataAdapter(sqlSched, connection);
                ds = new DataSet();
                adapter.Fill(ds);
                dataGridView1.DataSource = ds.Tables[0];
                dataGridView1.Columns["ID_Sched"].ReadOnly = true;
            }
        }
        private void radioButton1_CheckedChanged(object sender, EventArgs e)
        {
            if (radioButton1.Checked)
            {
                radioButton2.Checked = false;
                comboBoxClass.Enabled = true;
                comboBoxTeacher.Enabled = false;
            }
        }

        private void radioButton2_CheckedChanged(object sender, EventArgs e)
        {
            if (radioButton2.Checked)
            {
                radioButton1.Checked = false;
                comboBoxClass.Enabled = false;
                comboBoxTeacher.Enabled = true;
            }
        }

        private void Schedule_Load(object sender, EventArgs e)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                adapter = new SqlDataAdapter(sql2, connection);
                ds = new DataSet();
                adapter.Fill(ds);
                comboBoxClass.DataSource = ds.Tables[0];
                comboBoxClass.DisplayMember = "Class";
                comboBoxClass.ValueMember = "ID_Class";
                adapter = new SqlDataAdapter(sql3, connection);
                ds = new DataSet();
                adapter.Fill(ds);
                comboBoxDay.DataSource = ds.Tables[0];
                comboBoxDay.DisplayMember = "Day";
                comboBoxDay.ValueMember = "ID_Day";
                adapter = new SqlDataAdapter(sql4, connection);
                ds = new DataSet();
                adapter.Fill(ds);
                comboBoxTeacher.DataSource = ds.Tables[0];
                comboBoxTeacher.DisplayMember = "FullName";
                comboBoxTeacher.ValueMember = "ID_Teach";
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string sqlFind = "";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                if (radioButton1.Checked == true)
                {
                    sqlFind = string.Format(sql + " WHERE Schedule.Class = {0} AND Schedule.Day = {1}", comboBoxClass.SelectedValue, comboBoxDay.SelectedValue);
                }
                else
                {
                    sqlFind = string.Format(sql1 + " WHERE Schedule.Teacher = {0} AND Schedule.Day = {1}", comboBoxTeacher.SelectedValue, comboBoxDay.SelectedValue);
                }
                connection.Open();
                adapter = new SqlDataAdapter(sqlFind, connection);
                ds = new DataSet();
                adapter.Fill(ds);
                dataGridView1.DataSource = ds.Tables[0];
            }
        }

        private void добавитьToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ScheduleAdd SchedAdd = new ScheduleAdd();
            SchedAdd.ShowDialog();
            FillScheduleGrid();
        }

        private void показатьToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FillScheduleGrid();
        }

        private void изменитьToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Вы действительно хотите изменить эту запись",
                    "Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
            {
                if (dataGridView1.SelectedRows.Count == 1)
                {
                    int id = int.Parse(dataGridView1.SelectedRows[0].Cells[0].Value.ToString());
                    ScheduleAdd SchedChange = new ScheduleAdd(id);
                    SchedChange.ShowDialog();
                    FillScheduleGrid();
                }
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Вы действительно хотите удалить эту запись",
                    "Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
            {
                if (dataGridView1.SelectedRows.Count == 1)
                {
                    int id = int.Parse(dataGridView1.SelectedRows[0].Cells[0].Value.ToString());
                    foreach (DataGridViewRow row in dataGridView1.SelectedRows)
                    {
                        dataGridView1.Rows.Remove(row);
                    }
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    using (SqlCommand command = connection.CreateCommand())
                    {
                        command.CommandText = "DELETE FROM Schedule WHERE ID_Sched=@id";
                        command.Parameters.AddWithValue("@id", id);
                        connection.Open();
                        command.ExecuteNonQuery();
                        connection.Close();
                    }
                }
            }
        }
    }
}
