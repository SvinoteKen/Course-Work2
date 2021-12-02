using System;
using System.Data;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Configuration;

namespace CourseWork
{
    public partial class Performance : Form
    {
        DataSet ds;
        DataSet DiagramDs = new DataSet();
        SqlDataAdapter adapter;
        string sql1 = "SELECT * FROM Pupils";
        string sql2 = "SELECT * FROM Subject ORDER BY ID_Subject";
        string sql3 = "SELECT * FROM Class ";
        string sql4 = "SELECT * FROM PerfomanceClass ";
        string sql5 = "SELECT Оценка, Предмет, Период FROM PerfomancePupil ";
        string sql6 = "SELECT * FROM PerfomanceSubject ";
        string sqlPerf = "SELECT * FROM PerfomanceView";
        string connectionString = ConfigurationManager.ConnectionStrings["hhh"].ConnectionString;
        public Performance()
        {
            InitializeComponent();
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                adapter = new SqlDataAdapter(sql1, connection);
                ds = new DataSet();
                adapter.Fill(ds);
                comboBoxPupil.DataSource = ds.Tables[0];
                comboBoxPupil.DisplayMember = "FullName";
                comboBoxPupil.ValueMember = "ID_Pupil";
                adapter = new SqlDataAdapter(sql2, connection);
                ds = new DataSet();
                adapter.Fill(ds);
                comboBoxLesson.DataSource = ds.Tables[0];
                comboBoxLesson.DisplayMember = "Name";
                comboBoxLesson.ValueMember = "ID_Subject";
                adapter = new SqlDataAdapter(sql3, connection);
                ds = new DataSet();
                adapter.Fill(ds);
                comboBoxClass.DataSource = ds.Tables[0];
                comboBoxClass.DisplayMember = "Class";
                comboBoxClass.ValueMember = "Class";
            }
            if (Status.Value == Role.Pupil)
            {
                radioButton2.Enabled = false;
                radioButton3.Enabled = false;
                рассписаниеToolStripMenuItem.Enabled = false;
            }
            FillPerfomanceGrid();
        }

        private void Perfomance_FormClosing(object sender, FormClosingEventArgs e)
        {
            DialogResult = System.Windows.Forms.DialogResult.OK;
        }

        private void comboBoxLesson_SelectedIndexChanged(object sender, EventArgs e)
        {
            DiagramDs.Tables.Clear();
            string sqlwhere = sql6 + string.Format("WHERE ID_Subject = {0}", comboBoxLesson.SelectedValue);
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                adapter = new SqlDataAdapter(sqlwhere, connection);
                ds = new DataSet();
                adapter.Fill(ds);
                int sub = int.Parse(ds.Tables[0].Rows[0].ItemArray[0].ToString());
                int low = 0;
                int middle = 0;
                int sufficient = 0;
                int high = 0;
                int intValue = 0;
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    if (int.TryParse(ds.Tables[0].Rows[i].ItemArray[1].ToString(), out intValue) == true)
                    {
                        low += int.Parse(ds.Tables[0].Rows[i].ItemArray[1].ToString());
                    }
                    if (int.TryParse(ds.Tables[0].Rows[i].ItemArray[2].ToString(), out intValue) == true)
                    {
                        middle += int.Parse(ds.Tables[0].Rows[i].ItemArray[2].ToString());
                    }
                    if (int.TryParse(ds.Tables[0].Rows[i].ItemArray[3].ToString(), out intValue) == true)
                    {
                        sufficient += int.Parse(ds.Tables[0].Rows[i].ItemArray[3].ToString());
                    }
                    if (int.TryParse(ds.Tables[0].Rows[i].ItemArray[4].ToString(), out intValue) == true)
                    {
                        high += int.Parse(ds.Tables[0].Rows[i].ItemArray[4].ToString());
                    }
                }
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    ds.Tables[0].Rows[i].Delete();
                }
                DataTable dt = ds.Tables[0];
                DataRow newRow = dt.NewRow();
                newRow["ID_Subject"] = sub;
                newRow["Низкий"] = low;
                newRow["Средний"] = middle;
                newRow["Достаточный"] = sufficient;
                newRow["Высокий"] = high;
                dt.Rows.Add(newRow);
                DiagramDs.Tables.Add(ds.Tables[0].Copy());
                dataGridView1.DataSource = ds.Tables[0];
            }
        }

        private void comboBoxClass_SelectedIndexChanged(object sender, EventArgs e)
        {
            DiagramDs.Tables.Clear();
            string sqlwhere = sql4 + string.Format(" Where Class = {0}", comboBoxClass.SelectedValue);
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                adapter = new SqlDataAdapter(sqlwhere, connection);
                ds = new DataSet();
                adapter.Fill(ds);
                int cl = int.Parse(ds.Tables[0].Rows[0].ItemArray[0].ToString());
                int low = 0;
                int middle = 0;
                int sufficient = 0;
                int high = 0;
                int intValue = 0;
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    if (int.TryParse(ds.Tables[0].Rows[i].ItemArray[1].ToString(), out intValue) == true)
                    {
                        low += int.Parse(ds.Tables[0].Rows[i].ItemArray[1].ToString());
                    }
                    if (int.TryParse(ds.Tables[0].Rows[i].ItemArray[2].ToString(), out intValue) == true)
                    {
                        middle += int.Parse(ds.Tables[0].Rows[i].ItemArray[2].ToString());
                    }
                    if (int.TryParse(ds.Tables[0].Rows[i].ItemArray[3].ToString(), out intValue) == true)
                    {
                        sufficient += int.Parse(ds.Tables[0].Rows[i].ItemArray[3].ToString());
                    }
                    if (int.TryParse(ds.Tables[0].Rows[i].ItemArray[4].ToString(), out intValue) == true)
                    {
                        high += int.Parse(ds.Tables[0].Rows[i].ItemArray[4].ToString());
                    }
                }
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    ds.Tables[0].Rows[i].Delete();
                }
                DataTable dt = ds.Tables[0];
                DataRow newRow = dt.NewRow();
                newRow["Class"] = cl;
                newRow["Низкий"] = low;
                newRow["Средний"] = middle;
                newRow["Достаточный"] = sufficient;
                newRow["Высокий"] = high;
                dt.Rows.Add(newRow);
                DiagramDs.Tables.Add(ds.Tables[0].Copy());
                dataGridView1.DataSource = ds.Tables[0];
            }
        }
        private void radioButton1_CheckedChanged(object sender, EventArgs e)
        {
            if (radioButton1.Checked)
            {
                radioButton2.Checked = false;
                radioButton3.Checked = false;
                comboBoxPupil.Enabled = true;
                button1.Enabled = false;
                button2.Enabled = false;
            }
            else
            {
                comboBoxPupil.Enabled = false;
            }
        }

        private void radioButton2_CheckedChanged(object sender, EventArgs e)
        {
            if (radioButton2.Checked)
            {
                radioButton3.Checked = false;
                radioButton1.Checked = false;
                comboBoxLesson.Enabled = true;
                button1.Enabled = true;
                button2.Enabled = false;
            }
            else
            {
                comboBoxLesson.Enabled = false;
            }
        }

        private void radioButton3_CheckedChanged(object sender, EventArgs e)
        {
            if (radioButton3.Checked)
            {
                radioButton1.Checked = false;
                radioButton2.Checked = false;
                comboBoxClass.Enabled = true;
                button1.Enabled = false;
                button2.Enabled = true;
            }
            else
            {
                comboBoxClass.Enabled = false;
            }
        }

        private void показатьToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FillPerfomanceGrid();
        }
        public void FillPerfomanceGrid()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                adapter = new SqlDataAdapter(sqlPerf, connection);
                ds = new DataSet();
                adapter.Fill(ds);
                dataGridView1.DataSource = ds.Tables[0];
                dataGridView1.Columns["ID_Perf"].ReadOnly = true;
            }
        }

        private void добавитьToolStripMenuItem_Click(object sender, EventArgs e)
        {
            PerformanceAdd PerfAdd = new PerformanceAdd();
            PerfAdd.ShowDialog();
            FillPerfomanceGrid();
        }

        private void изменитьToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Вы действительно хотите изменить эту запись",
                    "Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
            {
                if (dataGridView1.SelectedRows.Count == 1)
                {
                    int id = int.Parse(dataGridView1.SelectedRows[0].Cells[0].Value.ToString());
                    PerformanceAdd PerfChange = new PerformanceAdd(id);
                    PerfChange.ShowDialog();
                    FillPerfomanceGrid();
                }
            }
        }

        private void comboBoxPupil_SelectedIndexChanged(object sender, EventArgs e)
        {
            string sqlwhere = sql5 + string.Format("WHERE Pupil = {0}", comboBoxPupil.SelectedValue);
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                adapter = new SqlDataAdapter(sqlwhere, connection);
                ds = new DataSet();
                adapter.Fill(ds);
                dataGridView1.DataSource = ds.Tables[0];
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            PerfDiagram diagram = new PerfDiagram(2, DiagramDs.Tables[0].Rows.Count - 1, comboBoxLesson.Text, DiagramDs);
            diagram.ShowDialog();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            PerfDiagram diagram = new PerfDiagram(1, DiagramDs.Tables[0].Rows.Count-1,comboBoxClass.Text, DiagramDs);
            diagram.ShowDialog();
        }
    }
}
