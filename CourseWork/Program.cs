using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CourseWork
{
    enum Role
    {
        Admin,
        Teacher,
        Pupil
    }
    static class Status
    {
        public static Role Value { get; set; }
        public static bool Enter { get; set; }
        public static string User { get; set; }
    }
    static class Program
    {
        /// <summary>
        /// Главная точка входа для приложения.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Authorization f1 = new Authorization();
            if (f1.ShowDialog() == DialogResult.OK && Status.Enter == true)
            {
                Application.Run(new Main());
            }
        }
    }
}
