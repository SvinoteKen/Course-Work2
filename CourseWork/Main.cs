using System;
using System.Data;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Configuration;

namespace CourseWork
{
    public partial class Main : Form
    {
        DataSet ds;
        SqlDataAdapter adapter;
        private ToDoc doc = new ToDoc();
        string sql1 = "SELECT ID_Teach, FullName AS ФИО, Post AS Должность, Rank AS Категория, BirthDate AS [Дата рождения], Years AS Возраст, Experience AS [Пед. стаж]" +
                        ", YearOfCertification AS [Год Аттестации], YearOfCourses AS [Год Курсов], Phone AS Телефон, Email AS Почта, Load AS Нагрузка, " +
                        "VacationFrom, VacationTo, SickFrom, SickTo FROM Teachers";
        string sql2 = "SELECT ID_Pupil, FullName AS ФИО, BirthDate AS [Дата рождения], Years AS Возраст, Class.Class AS Класс" +
                        ", District AS [Район], Social AS [Льготная категория], Phone AS Телефон," +
                        "DateOfReceipt AS [Дата Приема], DateOfDisposal AS [Дата Выбытия], Parent AS [ФИО родителя], " +
                        "PhoneParent AS [Телефон родителя] FROM Class INNER JOIN Pupils on Class.ID_Class = Pupils.Class";
        string sql3 = "SELECT ID_Event, Teachers.FullName AS Ответственный, Importance AS Важность, " +
                        "Term AS Срок, Place AS Место, Information AS Информация," +
                        "TypeEvent.TypeName AS Тип, Mark AS Отметка FROM Events INNER JOIN " +
                        "TypeEvent ON Events.Type = TypeEvent.ID_Type INNER JOIN Teachers ON Events.Post = Teachers.ID_Teach";
        char table = 't';
        string connectionString = ConfigurationManager.ConnectionStrings["hhh"].ConnectionString;
        public Main()
        {
            InitializeComponent();
            if (Status.Value == Role.Admin) 
            {
                FillTeacherGrid();
            }
            if (Status.Value == Role.Teacher)
            {
                FillTeacherGrid();
                учителяToolStripChange.Enabled = false;
                учителяToolStripAdd.Enabled = false;
                учащегосяToolStripChange.Enabled = false;
                событиеToolStripChange.Enabled = false;
            }
            if (Status.Value == Role.Pupil)
            {
                изменитьToolStripMenuItem.Enabled = false;
                добавитьToolStripMenuItem1.Enabled = false;
                просмотрToolStripMenuItem1.Enabled = false;
                radioButton2.Enabled = false;
                button1.Visible = false;
            }
            учащегосяToolStripChange.Enabled = false;
            событиеToolStripChange.Enabled = false;

        }

        private void button1_Click(object sender, EventArgs e)
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
                        if (table == 't')
                        {
                            command.CommandText = "DELETE FROM Teachers WHERE ID_Teach=@id";
                        }
                        if (table == 'p')
                        {
                            command.CommandText = "DELETE FROM Pupils WHERE ID_Pupil=@id";
                        }
                        if (table == 'e')
                        {
                            command.CommandText = "DELETE FROM Events WHERE ID_Event=@id";
                        }
                        command.Parameters.AddWithValue("@id", id);
                        connection.Open();
                        command.ExecuteNonQuery();
                        connection.Close();
                    }
                }
            }
        }


        private void учителяToolStripView_Click(object sender, EventArgs e)
        {
            button2.Visible = false;
            button3.Visible = false;
            FillTeacherGrid();
            table = 't';
            учителяToolStripChange.Enabled = true;
            учащегосяToolStripChange.Enabled = false;
            событиеToolStripChange.Enabled = false;
        }

        private void учащиесяToolStripView_Click(object sender, EventArgs e)
        {
            button2.Visible = false;
            button3.Visible = true;
            FillPupilGrid();
            table = 'p';
            учителяToolStripChange.Enabled = false;
            учащегосяToolStripChange.Enabled = true;
            событиеToolStripChange.Enabled = false;
        }

        private void событияToolStripView_Click(object sender, EventArgs e)
        {
            button2.Visible = true;
            button3.Visible = false;
            FillEventGrid();
            table = 'e';
            учителяToolStripChange.Enabled = false;
            учащегосяToolStripChange.Enabled = false;
            событиеToolStripChange.Enabled = true;
        }

        private void успеваемостьToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Hide();
            Performance perf = new Performance();
            perf.ShowDialog();
            Show();
        }

        private void учителяToolStripAdd_Click(object sender, EventArgs e)
        {
            Teacher tech = new Teacher();
            tech.ShowDialog();
            FillTeacherGrid();
        }
        private void учителяToolStripChange_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Вы действительно хотите изменить эту запись",
                    "Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
            {
                if (dataGridView1.SelectedRows.Count == 1)
                {
                    int id = int.Parse(dataGridView1.SelectedRows[0].Cells[0].Value.ToString());
                    Teacher tech = new Teacher(id);
                    tech.ShowDialog();
                    FillTeacherGrid();
                }
            }
        }
        public void FillTeacherGrid()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                adapter = new SqlDataAdapter(sql1, connection);
                ds = new DataSet();
                adapter.Fill(ds);
                dataGridView1.DataSource = ds.Tables[0];
                dataGridView1.Columns["ID_Teach"].ReadOnly = true;
            }
        }
        public void FillPupilGrid()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                adapter = new SqlDataAdapter(sql2, connection);
                ds = new DataSet();
                adapter.Fill(ds);
                dataGridView1.DataSource = ds.Tables[0];
                dataGridView1.Columns["ID_Pupil"].ReadOnly = true;
            }
        }
        public void FillEventGrid()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                adapter = new SqlDataAdapter(sql3, connection);
                ds = new DataSet();
                adapter.Fill(ds);
                dataGridView1.DataSource = ds.Tables[0];
                dataGridView1.Columns["ID_Event"].ReadOnly = true;
                dataGridView1.Columns["Отметка"].ReadOnly = true;
            }
        }

        private void radioButton1_CheckedChanged(object sender, EventArgs e)
        {
            if (radioButton1.Checked)
            {
                radioButton2.Checked = false;
                if (FindtextBox.Text == "")
                {
                    MessageBox.Show("Поле для пойска пустое",
                    "Notification", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                    return;
                }
                using (SqlConnection connection = new SqlConnection(connectionString))
                using (SqlCommand command = connection.CreateCommand())
                {
                    string sql = "";
                    if (table == 't')
                    {
                        sql = string.Format("SELECT ID_Teach, FullName AS ФИО, Post AS Должность, Rank AS Категория, BirthDate AS [Дата рождения], Years AS Возраст, Experience AS [Пед. стаж]" +
                        ", YearOfCertification AS [Год Аттестации], YearOfCourses AS [Год Курсов], Phone AS Телефон, Email AS Почта, Load AS Нагрузка, " +
                        "VacationFrom, VacationTo, SickFrom, SickTo FROM Teachers WHERE concat(FullName, Post, Rank, BirthDate, Years, Experience" +
                        ", YearOfCertification, YearOfCourses, Phone, Email, Load, " +
                        "VacationFrom, VacationTo, SickFrom, SickTo) LIKE '%{0}%'", FindtextBox.Text);
                    }
                    if (table == 'p')
                    {
                        sql = string.Format("SELECT ID_Pupil, FullName AS ФИО, BirthDate AS [Дата рождения], Years AS Возраст, Class.Class AS Класс" +
                        ", District AS [Район], Social AS [Льготная категория], Phone AS Телефон," +
                        "DateOfReceipt AS [Дата Приема], DateOfDisposal AS [Дата Выбытия], Parent AS [ФИО родителя], PhoneParent AS [Телефон родителя] " +
                        "FROM Class INNER JOIN Pupils on Class.ID_Class = Pupils.Class WHERE concat(FullName, BirthDate, Years, Class.Class, District, Social, Phone," +
                        "DateOfReceipt, DateOfDisposal, Parent, PhoneParent) LIKE '%{0}%'", FindtextBox.Text);
                    }
                    if (table == 'e')
                    {
                        sql = string.Format("SELECT ID_Event, Teachers.FullName AS Ответственный, Importance AS Важность, " +
                        "Term AS Срок, Place AS Место, Information AS Информация," +
                        "TypeEvent.TypeName AS Тип, Mark AS Отметка FROM Events INNER JOIN " +
                        "TypeEvent ON Events.Type = TypeEvent.ID_Type INNER JOIN Teachers ON Events.Post = Teachers.ID_Teach WHERE concat(Teachers.FullName," +
                        " Importance, Term, Place, Information, TypeEvent.TypeName, Mark) LIKE '%{0}%'", FindtextBox.Text);
                    }
                    connection.Open();
                    SqlDataAdapter adapter = new SqlDataAdapter(sql,connectionString);
                    ds = new DataSet();
                    adapter.Fill(ds);
                    dataGridView1.DataSource = ds.Tables[0];
                }
            }
        }

        private void radioButton2_CheckedChanged(object sender, EventArgs e)
        {
            if (radioButton2.Checked)
            {
                radioButton1.Checked = false;
                FindtextBox.Text = "";
                if (table == 't')
                {
                    FillTeacherGrid();
                }
                if (table == 'p')
                {
                    FillPupilGrid();
                }
                if (table == 'e')
                {
                    FillEventGrid();
                }
            }
        }

        private void учащегосяToolStripAdd_Click(object sender, EventArgs e)
        {
            Pupil pupil = new Pupil();
            pupil.ShowDialog();
            FillPupilGrid();
        }

        private void учащегосяToolStripChange_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Вы действительно хотите изменить эту запись",
                    "Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
            {
                if (dataGridView1.SelectedRows.Count == 1)
                {
                    int id = int.Parse(dataGridView1.SelectedRows[0].Cells[0].Value.ToString());
                    Pupil pupil = new Pupil(id);
                    pupil.ShowDialog();
                    FillPupilGrid();
                }
            }
        }

        private void событиеToolStripAdd_Click(object sender, EventArgs e)
        {
            EventForm eve = new EventForm();
            eve.ShowDialog();
            FillEventGrid();
        }

        private void событиеToolStripChange_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Вы действительно хотите изменить эту запись",
                    "Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
            {
                if (dataGridView1.SelectedRows.Count == 1)
                {
                    int id = int.Parse(dataGridView1.SelectedRows[0].Cells[0].Value.ToString());
                    EventForm eve = new EventForm(id);
                    eve.ShowDialog();
                    FillEventGrid();
                }
            }
        }

        private void button2_Click_1(object sender, EventArgs e)
        {
            if (table == 'e')
            {
                if (dataGridView1.SelectedRows.Count == 1)
                {
                    int id = int.Parse(dataGridView1.SelectedRows[0].Cells[0].Value.ToString());
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    using (SqlCommand command = connection.CreateCommand())
                    {
                        command.CommandText = "UPDATE Events SET Mark = 1 WHERE ID_Event=@ID";
                        command.Parameters.AddWithValue("@id", id);
                        connection.Open();
                        command.ExecuteNonQuery();
                        connection.Close();
                    }
                    FillEventGrid();
                }
            }
        }

        private void рассписаниеToolStrip_Click(object sender, EventArgs e)
        {
            Schedule schedule = new Schedule();
            Hide();
            schedule.ShowDialog();
            Show();
        }

        private void заявкаНаКурсыToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (table != 't') { return; }
            if (dataGridView1.SelectedRows.Count > 0)
            {
                SaveFileDialog sfd = new SaveFileDialog
                {
                    Filter = "Word Documents (*.docx)|*.docx",
                    FileName = "export.docx"
                };

                if (sfd.ShowDialog() == DialogResult.OK)
                {
                    Int32 selectedRowCount = dataGridView1.Rows.GetRowCount(DataGridViewElementStates.Selected);
                    string[,] items = new string[dataGridView1.SelectedRows.Count + 1, 10];
                    items[0, 0] = "№"; items[0, 1] = "ФИО\n(полностью)"; items[0, 2] = "Место работы (полное название)"; items[0, 3] = "Должность";
                    items[0, 4] = "Уровень профессионального образования, согласно диплому"; items[0, 5] = "Предметная специализация";
                    items[0, 6] = "Квалификация согласно диплому"; items[0, 7] = "Педагогический стаж";
                    items[0, 8] = "Контактный телефон оператора \"Феникс\""; items[0, 9] = "Адрес электронной почты";
                    int rows = 1;
                    for(int i=0;i<selectedRowCount;i++)
                    {
                        int index = dataGridView1.SelectedRows[i].Index;
                        items[rows, 0] = rows.ToString();
                        items[rows, 1] = dataGridView1.Rows[index].Cells[1].Value.ToString();
                        items[rows, 2] = "МУНИЦИПАЛЬНОЕ ОБШЕОБРАЗОВАТЕЛЬНОЕ УЧРЕЖДЕНИЕ \"КЛАССИЧЕСКАЯ ГУМАНИТАРНАЯ ГИМНАЗИЯ ГОРОДА ДОНЕЦКА\"";
                        items[rows, 3] = dataGridView1.Rows[index].Cells[2].Value.ToString();
                        items[rows, 4] = "Высшее профессиональное, специалист";
                        items[rows, 5] = "---";
                        items[rows, 6] = "---";
                        items[rows, 7] = dataGridView1.Rows[index].Cells[6].Value.ToString();
                        items[rows, 8] = dataGridView1.Rows[index].Cells[9].Value.ToString();
                        items[rows, 9] = dataGridView1.Rows[index].Cells[10].Value.ToString();
                        rows++;
                    }
                    if (!doc.IsFileInUse(sfd.FileName))
                    {
                        doc.CreateWordprocessingDocument(sfd.FileName, 0, items);
                    }
                    else
                    {
                        MessageBox.Show("Закройте файл в который вы хотите добавить таблицу!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    }
                }
            }
            else
            {
                MessageBox.Show("Выберите записи которые хотите добавить в таблицу.",
                "Notification", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void заявкаНаОздоровлениеДетейЛьготныхКатегорийToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (table != 'p') { return; }
            if (dataGridView1.SelectedRows.Count > 0)
            {
                SaveFileDialog sfd = new SaveFileDialog
                {
                    Filter = "Word Documents (*.docx)|*.docx",
                    FileName = "export.docx"
                };

                if (sfd.ShowDialog() == DialogResult.OK)
                {
                    DateTime currDate = DateTime.Now;
                    DateTime season = new DateTime();
                    if (currDate.Month == 12 || currDate.Month == 1 || currDate.Month == 2)
                    {
                        if (currDate.Month == 12) { season = new DateTime(currDate.Year + 1, 2, 1); }
                        else { season = new DateTime(currDate.Year, 2, 1); }
                    }
                    if (currDate.Month > 2 && currDate.Month < 6) { season = new DateTime(currDate.Year, 5, 1); }
                    if (currDate.Month > 5 && currDate.Month < 9) { season = new DateTime(currDate.Year, 8, 1); }
                    if (currDate.Month > 8 && currDate.Month < 12) { season = new DateTime(currDate.Year, 11, 1); }
                    Int32 selectedRowCount = dataGridView1.Rows.GetRowCount(DataGridViewElementStates.Selected);
                    string[,] items = new string[dataGridView1.SelectedRows.Count + 1, 9];
                    items[0, 0] = "№"; items[0, 1] = "ФИО ребенка"; items[0, 2] = "Дата рождения"; items[0, 3] = $"Возраст(полных лет на {season:dd.MM.yyyy})";
                    items[0, 4] = "Место учебы, класс"; items[0, 5] = "Место проживания";
                    items[0, 6] = "Родители или лица их заменяющие (ФИО, контактный телефон)"; items[0, 7] = "Реквизиты свидетельства о рождении, дата выдачи";
                    items[0, 8] = "Категория";
                    int rows = 1;
                    for (int i = 0; i < selectedRowCount; i++)
                    {
                        int index = dataGridView1.SelectedRows[i].Index;
                        TimeSpan Birthday = season - DateTime.Parse(dataGridView1.Rows[index].Cells[2].Value.ToString());
                        items[rows, 0] = rows.ToString();
                        items[rows, 1] = dataGridView1.Rows[index].Cells[1].Value.ToString();
                        items[rows, 2] = dataGridView1.Rows[index].Cells[2].Value.ToString();
                        items[rows, 3] = (Birthday.Days / 365).ToString();
                        items[rows, 4] = $"МОУ «ДКГГ», {dataGridView1.Rows[index].Cells[4].Value.ToString()} класс";
                        items[rows, 5] = dataGridView1.Rows[index].Cells[5].Value.ToString();
                        items[rows, 6] = dataGridView1.Rows[index].Cells[10].Value.ToString() + "\n т." + dataGridView1.Rows[index].Cells[11].Value.ToString();
                        items[rows, 7] = "---";
                        items[rows, 8] = dataGridView1.Rows[index].Cells[6].Value.ToString();
                        rows++;
                    }
                    if (!doc.IsFileInUse(sfd.FileName))
                    {
                        doc.CreateWordprocessingDocument(sfd.FileName, 1, items);
                    }
                    else
                    {
                        MessageBox.Show("Закройте файл в который вы хотите добавить таблицу!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    }

                }
            }
            else
            {
                MessageBox.Show("Выберите записи которые хотите добавить в таблицу.",
                "Notification", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            if (table == 'p')
            {
                if (dataGridView1.SelectedRows.Count > 0)
                {
                    Int32 selectedRowCount = dataGridView1.Rows.GetRowCount(DataGridViewElementStates.Selected);
                    for (int i = 0; i < selectedRowCount; i++)
                    {
                        using (SqlConnection connection = new SqlConnection(connectionString))
                        using (SqlCommand command = connection.CreateCommand())
                        {
                            int index = dataGridView1.SelectedRows[i].Index;
                            int id = int.Parse(dataGridView1.Rows[index].Cells[0].Value.ToString());
                            command.CommandText = "UPDATE Pupils SET Class = Class+1 WHERE ID_Pupil=@ID";
                            command.Parameters.AddWithValue("@id", id);
                            connection.Open();
                            command.ExecuteNonQuery();
                            connection.Close();
                        }

                    }
                    FillPupilGrid();
                }
            }
        }
    }
}