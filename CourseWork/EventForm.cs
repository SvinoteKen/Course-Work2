using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace CourseWork
{
    public partial class EventForm : Form
    {
        int IDEvent = 0;
        DataSet ds;
        SqlDataAdapter adapter;
        string sql = "SELECT * FROM Events";
        string sql1 = "SELECT * FROM TypeEvent";
        string sql2 = "SELECT * FROM Teachers";
        string connectionString = ConfigurationManager.ConnectionStrings["hhh"].ConnectionString;
        public EventForm()
        {
            InitializeComponent();
            Text = "Добавить событие";
        }
        public EventForm(int ID)
        {
            InitializeComponent();
            IDEvent = ID;
            Text = "Изменить событие";
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (IDEvent == 0)
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
                    try
                    {
                        newRow["Post"] = comboBoxTeacher.SelectedValue;
                        newRow["Importance"] = textBox2.Text;
                        newRow["Term"] = textBox3.Text;
                        newRow["Place"] = textBox4.Text;
                        newRow["Information"] = textBox5.Text;
                        newRow["Mark"] = false;
                        newRow["Type"] = comboBoxType.SelectedValue;
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
                    command.CommandText = "UPDATE Events SET Post = @p, Importance = @imp, Term = @t, Place = @place" +
                        ", Information = @inf, Mark = @m, Type = @type WHERE ID_Event=@ID";
                    command.Parameters.AddWithValue("@p", comboBoxTeacher.SelectedValue);
                    command.Parameters.AddWithValue("@imp", textBox2.Text);
                    command.Parameters.AddWithValue("@t", textBox3.Text);
                    command.Parameters.AddWithValue("@place", textBox4.Text);
                    command.Parameters.AddWithValue("@inf", textBox5.Text);
                    command.Parameters.AddWithValue("@m", 0);
                    command.Parameters.AddWithValue("@type", comboBoxType.SelectedValue);
                    command.Parameters.AddWithValue("@id", IDEvent);
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

        private void Event_Load(object sender, EventArgs e)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                adapter = new SqlDataAdapter(sql1, connection);
                ds = new DataSet();
                adapter.Fill(ds);
                comboBoxType.DataSource = ds.Tables[0];
                comboBoxType.DisplayMember = "TypeName";
                comboBoxType.ValueMember = "ID_Type";
                adapter = new SqlDataAdapter(sql2, connection);
                ds = new DataSet();
                adapter.Fill(ds);
                comboBoxTeacher.DataSource = ds.Tables[0];
                comboBoxTeacher.DisplayMember = "FullName";
                comboBoxTeacher.ValueMember = "ID_Teach";
            }
            if (IDEvent != 0)
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string cmdStr = "select * from Events where ID_Event=@ID";
                    SqlCommand command = new SqlCommand(cmdStr, connection);
                    command.Parameters.AddWithValue("@id", IDEvent);
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    reader.Read();
                    comboBoxType.SelectedValue = reader.GetInt32(1);
                    textBox2.Text = reader.GetString(2);
                    textBox3.Text = reader.GetString(3);
                    textBox4.Text = reader.GetString(4);
                    textBox5.Text = reader.GetString(5);
                    comboBoxTeacher.SelectedValue = reader.GetInt32(6);
                    connection.Close();
                }
            }
        }
    }
}
