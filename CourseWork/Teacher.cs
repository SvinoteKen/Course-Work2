using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace CourseWork
{
    public partial class Teacher : Form
    {
        int IDTeacher = 0;
        string sql = "SELECT * FROM Teachers";
        string connectionString = ConfigurationManager.ConnectionStrings["hhh"].ConnectionString;
        public Teacher()
        {
            InitializeComponent();
            Text ="Добавить учителя";
        }
        public Teacher(int id) // конструктор с параметром - кодом книги для редактирования
        {
            InitializeComponent();
            IDTeacher = id;
            Text = "Изменить учителя";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string cmdStr = string.Format("SELECT * FROM Teachers WHERE ID_Teach = {0}", IDTeacher);
                connection.Open();
                SqlDataAdapter adapter = new SqlDataAdapter(cmdStr, connection);
                DataSet ds = new DataSet();
                adapter.Fill(ds);
                DataTable dt = ds.Tables[0];
                DataRow[] row = dt.Select();
            }
        }
        private void button1_Click(object sender, EventArgs e)
        {
            if (IDTeacher == 0)
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
                        newRow["FullName"] = textBoxName.Text;
                        newRow["Post"] = textBoxPost.Text;
                        newRow["Rank"] = textBoxRank.Text;
                        newRow["BirthDate"] = textBoxBirthDate.Text;
                        newRow["Years"] = textBoxYears.Text;
                        newRow["Experience"] = textBoxExperience.Text;
                        newRow["YearOfCertification"] = textBoxYearOfCertification.Text;
                        newRow["YearOfCourses"] = textBoxYearOfCourses.Text;
                        newRow["Phone"] = textBoxPhone.Text;
                        newRow["Email"] = textBoxEmail.Text;
                        newRow["Load"] = textBoxLoad.Text;
                        newRow["VacationFrom"] = textBoxVacationFrom.Text;
                        newRow["VacationTo"] = textBoxVacationTo.Text;
                        newRow["SickFrom"] = textBoxSickFrom.Text;
                        newRow["SickTo"] = textBoxSickTo.Text;
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
                    command.CommandText = "UPDATE Teachers SET FullName = @fn, Post = @p, Rank = @r, BirthDate = @bd, Years = @y, Experience = @exp" +
                        ", YearOfCertification = @yocert, YearOfCourses = @yocours, Phone = @phone, Email = @email, Load = @l, " +
                        "VacationFrom = @vf, VacationTo = @vt, SickFrom = @sf, SickTo = @st WHERE ID_Teach=@ID";
                    command.Parameters.AddWithValue("@fn", textBoxName.Text);
                    command.Parameters.AddWithValue("@P", textBoxPost.Text);
                    command.Parameters.AddWithValue("@r", textBoxRank.Text);
                    command.Parameters.AddWithValue("@bd", textBoxBirthDate.Text);
                    command.Parameters.AddWithValue("@y", textBoxYears.Text);
                    command.Parameters.AddWithValue("@exp", textBoxExperience.Text);
                    command.Parameters.AddWithValue("@yocert", textBoxYearOfCertification.Text);
                    command.Parameters.AddWithValue("@yocours", textBoxYearOfCourses.Text); 
                    command.Parameters.AddWithValue("@phone", textBoxPhone.Text);
                    command.Parameters.AddWithValue("@email", textBoxEmail.Text);
                    command.Parameters.AddWithValue("@l", textBoxLoad.Text);
                    command.Parameters.AddWithValue("@vf", textBoxVacationFrom.Text);
                    command.Parameters.AddWithValue("@vt", textBoxVacationTo.Text);
                    command.Parameters.AddWithValue("@sf", textBoxSickFrom.Text);
                    command.Parameters.AddWithValue("@st", textBoxSickTo.Text);
                    command.Parameters.AddWithValue("@id", IDTeacher);
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

        private void Teacher_Load(object sender, EventArgs e)
        {
            if (IDTeacher != 0)
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string cmdStr = "select * from Teachers where ID_Teach=@ID";
                    SqlCommand command = new SqlCommand(cmdStr, connection);
                    command.Parameters.AddWithValue("@id", IDTeacher);
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    reader.Read();
                    textBoxName.Text = reader.GetString(1);
                    textBoxPost.Text = reader.GetString(2);
                    textBoxRank.Text = reader.GetString(3);
                    textBoxBirthDate.Text = reader.GetDateTime(4).ToString("dd/MM/yyyy");
                    textBoxYears.Text = reader.GetInt32(5).ToString();
                    textBoxExperience.Text = reader.GetInt32(6).ToString();
                    textBoxYearOfCertification.Text = reader.GetInt32(7).ToString();
                    textBoxYearOfCourses.Text = reader.GetInt32(8).ToString();
                    textBoxPhone.Text = reader.GetString(9);
                    textBoxEmail.Text = reader.GetString(10);
                    textBoxLoad.Text = reader.GetDouble(11).ToString();
                    textBoxVacationFrom.Text = reader.GetDateTime(12).ToString("dd/MM/yyyy");
                    textBoxVacationTo.Text = reader.GetDateTime(13).ToString("dd/MM/yyyy");
                    textBoxSickFrom.Text = reader.GetDateTime(14).ToString("dd/MM/yyyy");
                    textBoxSickTo.Text = reader.GetDateTime(15).ToString("dd/MM/yyyy");
                    connection.Close();
                }
            }
        }
    }
}
