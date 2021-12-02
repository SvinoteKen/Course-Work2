using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;

namespace CourseWork
{
    class AuthService
    {
        private List<Account> _account = new List<Account>();
        public IEnumerable<Account> GetListAccounts()
        {
            return _account.ToArray();
        }
        public IEnumerable<Account> GetAccounts()
        {
            if (!File.Exists("account.json"))
            {
                return null;
            }
            using (var f = File.OpenText("account.json"))
            {
                var json = f.ReadToEnd();
                _account = JsonConvert.DeserializeObject<Account[]>(json,
                    new JsonSerializerSettings { PreserveReferencesHandling = PreserveReferencesHandling.Objects }).ToList();
                return JsonConvert.DeserializeObject<Account[]>(json,
                    new JsonSerializerSettings { PreserveReferencesHandling = PreserveReferencesHandling.Objects });
            }
        }
        public bool Authorize(string login, string password)
        {
            GetAccounts();
            var user = AuthUser(login, password);
            if (user != null)
            {
                if (user.Roles == "Admin")
                {
                    Status.Value = Role.Admin;
                }
                if (user.Roles == "Teacher")
                {
                    Status.Value = Role.Teacher;
                }
                if (user.Roles == "Pupil")
                {
                    Status.Value = Role.Pupil;
                }
                return true;
            }
            return false;
        }
        public Account AuthUser(string login, string password)
        {
            return _account.SingleOrDefault(u => u.Login == login && u.Password == password);
        }
    }
}
