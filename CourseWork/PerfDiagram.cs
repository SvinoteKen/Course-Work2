using System.Data;
using System.Windows.Forms;

namespace CourseWork
{
    public partial class PerfDiagram : Form
    {
        public PerfDiagram(int t,int len, string name, DataSet DiagramDs)
        {
            InitializeComponent();
            if (t == 1)
            {
                chart1.Titles.Add("Успеваемость по "+name+" классу");
                chart1.Series["Series1"].IsValueShownAsLabel = true;
            }
            if (t == 2) 
            {
                chart1.Titles.Add("Успеваемость по предмету: " + name);
                chart1.Series["Series1"].IsValueShownAsLabel = true;
            }
            for (int i = 1; i < DiagramDs.Tables[0].Columns.Count; i++)
            {
                if (int.Parse(DiagramDs.Tables[0].Rows[len].ItemArray[i].ToString()) == 0)
                {
                    continue;
                }
                else
                {
                    chart1.Series["Series1"].Points.AddXY(DiagramDs.Tables[0].Columns[i].ColumnName, DiagramDs.Tables[0].Rows[len].ItemArray[i].ToString());
                }
            }
        }
    }
}
