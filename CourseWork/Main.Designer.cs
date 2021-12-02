
namespace CourseWork
{
    partial class Main
    {
        /// <summary>
        /// Обязательная переменная конструктора.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Освободить все используемые ресурсы.
        /// </summary>
        /// <param name="disposing">истинно, если управляемый ресурс должен быть удален; иначе ложно.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Код, автоматически созданный конструктором форм Windows

        /// <summary>
        /// Требуемый метод для поддержки конструктора — не изменяйте 
        /// содержимое этого метода с помощью редактора кода.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.contextMenuStrip1 = new System.Windows.Forms.ContextMenuStrip(this.components);
            this.событияToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.заявкаНаКурсыToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.заявкаНаОздоровлениеДетейЛьготныхКатегорийToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.button1 = new System.Windows.Forms.Button();
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.просмотрToolStripMenuItem1 = new System.Windows.Forms.ToolStripMenuItem();
            this.учителяToolStripShow = new System.Windows.Forms.ToolStripMenuItem();
            this.учащиесяToolStripShow = new System.Windows.Forms.ToolStripMenuItem();
            this.событияToolStripShow = new System.Windows.Forms.ToolStripMenuItem();
            this.добавитьToolStripMenuItem1 = new System.Windows.Forms.ToolStripMenuItem();
            this.учителяToolStripAdd = new System.Windows.Forms.ToolStripMenuItem();
            this.учащегосяToolStripAdd = new System.Windows.Forms.ToolStripMenuItem();
            this.событиеToolStripAdd = new System.Windows.Forms.ToolStripMenuItem();
            this.изменитьToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.учителяToolStripChange = new System.Windows.Forms.ToolStripMenuItem();
            this.учащегосяToolStripChange = new System.Windows.Forms.ToolStripMenuItem();
            this.событиеToolStripChange = new System.Windows.Forms.ToolStripMenuItem();
            this.успеваемостьToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.рассписаниеToolStrip = new System.Windows.Forms.ToolStripMenuItem();
            this.radioButton1 = new System.Windows.Forms.RadioButton();
            this.radioButton2 = new System.Windows.Forms.RadioButton();
            this.FindtextBox = new System.Windows.Forms.TextBox();
            this.button2 = new System.Windows.Forms.Button();
            this.button3 = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            this.contextMenuStrip1.SuspendLayout();
            this.menuStrip1.SuspendLayout();
            this.SuspendLayout();
            // 
            // dataGridView1
            // 
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.ContextMenuStrip = this.contextMenuStrip1;
            this.dataGridView1.Location = new System.Drawing.Point(12, 27);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dataGridView1.Size = new System.Drawing.Size(1160, 422);
            this.dataGridView1.TabIndex = 0;
            // 
            // contextMenuStrip1
            // 
            this.contextMenuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.событияToolStripMenuItem});
            this.contextMenuStrip1.Name = "contextMenuStrip1";
            this.contextMenuStrip1.Size = new System.Drawing.Size(166, 26);
            // 
            // событияToolStripMenuItem
            // 
            this.событияToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.заявкаНаКурсыToolStripMenuItem,
            this.заявкаНаОздоровлениеДетейЛьготныхКатегорийToolStripMenuItem});
            this.событияToolStripMenuItem.Name = "событияToolStripMenuItem";
            this.событияToolStripMenuItem.Size = new System.Drawing.Size(165, 22);
            this.событияToolStripMenuItem.Text = "Создать таблицу";
            // 
            // заявкаНаКурсыToolStripMenuItem
            // 
            this.заявкаНаКурсыToolStripMenuItem.Name = "заявкаНаКурсыToolStripMenuItem";
            this.заявкаНаКурсыToolStripMenuItem.Size = new System.Drawing.Size(355, 22);
            this.заявкаНаКурсыToolStripMenuItem.Text = "Заявка на курсы";
            this.заявкаНаКурсыToolStripMenuItem.Click += new System.EventHandler(this.заявкаНаКурсыToolStripMenuItem_Click);
            // 
            // заявкаНаОздоровлениеДетейЛьготныхКатегорийToolStripMenuItem
            // 
            this.заявкаНаОздоровлениеДетейЛьготныхКатегорийToolStripMenuItem.Name = "заявкаНаОздоровлениеДетейЛьготныхКатегорийToolStripMenuItem";
            this.заявкаНаОздоровлениеДетейЛьготныхКатегорийToolStripMenuItem.Size = new System.Drawing.Size(355, 22);
            this.заявкаНаОздоровлениеДетейЛьготныхКатегорийToolStripMenuItem.Text = "Заявка на оздоровление детей льготных категорий";
            this.заявкаНаОздоровлениеДетейЛьготныхКатегорийToolStripMenuItem.Click += new System.EventHandler(this.заявкаНаОздоровлениеДетейЛьготныхКатегорийToolStripMenuItem_Click);
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(954, 479);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(138, 38);
            this.button1.TabIndex = 1;
            this.button1.Text = "Удалить";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // menuStrip1
            // 
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.просмотрToolStripMenuItem1,
            this.добавитьToolStripMenuItem1,
            this.изменитьToolStripMenuItem,
            this.успеваемостьToolStripMenuItem,
            this.рассписаниеToolStrip});
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.Size = new System.Drawing.Size(1184, 24);
            this.menuStrip1.TabIndex = 5;
            this.menuStrip1.Text = "menuStrip1";
            // 
            // просмотрToolStripMenuItem1
            // 
            this.просмотрToolStripMenuItem1.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.учителяToolStripShow,
            this.учащиесяToolStripShow,
            this.событияToolStripShow});
            this.просмотрToolStripMenuItem1.Name = "просмотрToolStripMenuItem1";
            this.просмотрToolStripMenuItem1.Size = new System.Drawing.Size(76, 20);
            this.просмотрToolStripMenuItem1.Text = "Просмотр";
            // 
            // учителяToolStripShow
            // 
            this.учителяToolStripShow.Name = "учителяToolStripShow";
            this.учителяToolStripShow.Size = new System.Drawing.Size(130, 22);
            this.учителяToolStripShow.Text = "Учителя";
            this.учителяToolStripShow.Click += new System.EventHandler(this.учителяToolStripView_Click);
            // 
            // учащиесяToolStripShow
            // 
            this.учащиесяToolStripShow.Name = "учащиесяToolStripShow";
            this.учащиесяToolStripShow.Size = new System.Drawing.Size(130, 22);
            this.учащиесяToolStripShow.Text = "Учащиеся";
            this.учащиесяToolStripShow.Click += new System.EventHandler(this.учащиесяToolStripView_Click);
            // 
            // событияToolStripShow
            // 
            this.событияToolStripShow.Name = "событияToolStripShow";
            this.событияToolStripShow.Size = new System.Drawing.Size(130, 22);
            this.событияToolStripShow.Text = "События";
            this.событияToolStripShow.Click += new System.EventHandler(this.событияToolStripView_Click);
            // 
            // добавитьToolStripMenuItem1
            // 
            this.добавитьToolStripMenuItem1.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.учителяToolStripAdd,
            this.учащегосяToolStripAdd,
            this.событиеToolStripAdd});
            this.добавитьToolStripMenuItem1.Name = "добавитьToolStripMenuItem1";
            this.добавитьToolStripMenuItem1.Size = new System.Drawing.Size(71, 20);
            this.добавитьToolStripMenuItem1.Text = "Добавить";
            // 
            // учителяToolStripAdd
            // 
            this.учителяToolStripAdd.Name = "учителяToolStripAdd";
            this.учителяToolStripAdd.Size = new System.Drawing.Size(135, 22);
            this.учителяToolStripAdd.Text = "Учителя";
            this.учителяToolStripAdd.Click += new System.EventHandler(this.учителяToolStripAdd_Click);
            // 
            // учащегосяToolStripAdd
            // 
            this.учащегосяToolStripAdd.Name = "учащегосяToolStripAdd";
            this.учащегосяToolStripAdd.Size = new System.Drawing.Size(135, 22);
            this.учащегосяToolStripAdd.Text = "Учащегося";
            this.учащегосяToolStripAdd.Click += new System.EventHandler(this.учащегосяToolStripAdd_Click);
            // 
            // событиеToolStripAdd
            // 
            this.событиеToolStripAdd.Name = "событиеToolStripAdd";
            this.событиеToolStripAdd.Size = new System.Drawing.Size(135, 22);
            this.событиеToolStripAdd.Text = "Событие";
            this.событиеToolStripAdd.Click += new System.EventHandler(this.событиеToolStripAdd_Click);
            // 
            // изменитьToolStripMenuItem
            // 
            this.изменитьToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.учителяToolStripChange,
            this.учащегосяToolStripChange,
            this.событиеToolStripChange});
            this.изменитьToolStripMenuItem.Name = "изменитьToolStripMenuItem";
            this.изменитьToolStripMenuItem.Size = new System.Drawing.Size(73, 20);
            this.изменитьToolStripMenuItem.Text = "Изменить";
            // 
            // учителяToolStripChange
            // 
            this.учителяToolStripChange.Name = "учителяToolStripChange";
            this.учителяToolStripChange.Size = new System.Drawing.Size(135, 22);
            this.учителяToolStripChange.Text = "Учителя";
            this.учителяToolStripChange.Click += new System.EventHandler(this.учителяToolStripChange_Click);
            // 
            // учащегосяToolStripChange
            // 
            this.учащегосяToolStripChange.Name = "учащегосяToolStripChange";
            this.учащегосяToolStripChange.Size = new System.Drawing.Size(135, 22);
            this.учащегосяToolStripChange.Text = "Учащегося";
            this.учащегосяToolStripChange.Click += new System.EventHandler(this.учащегосяToolStripChange_Click);
            // 
            // событиеToolStripChange
            // 
            this.событиеToolStripChange.Name = "событиеToolStripChange";
            this.событиеToolStripChange.Size = new System.Drawing.Size(135, 22);
            this.событиеToolStripChange.Text = "Событие";
            this.событиеToolStripChange.Click += new System.EventHandler(this.событиеToolStripChange_Click);
            // 
            // успеваемостьToolStripMenuItem
            // 
            this.успеваемостьToolStripMenuItem.Name = "успеваемостьToolStripMenuItem";
            this.успеваемостьToolStripMenuItem.Size = new System.Drawing.Size(96, 20);
            this.успеваемостьToolStripMenuItem.Text = "Успеваемость";
            this.успеваемостьToolStripMenuItem.Click += new System.EventHandler(this.успеваемостьToolStripMenuItem_Click);
            // 
            // рассписаниеToolStrip
            // 
            this.рассписаниеToolStrip.Name = "рассписаниеToolStrip";
            this.рассписаниеToolStrip.Size = new System.Drawing.Size(84, 20);
            this.рассписаниеToolStrip.Text = "Расписание";
            this.рассписаниеToolStrip.Click += new System.EventHandler(this.рассписаниеToolStrip_Click);
            // 
            // radioButton1
            // 
            this.radioButton1.AutoSize = true;
            this.radioButton1.Location = new System.Drawing.Point(73, 477);
            this.radioButton1.Name = "radioButton1";
            this.radioButton1.Size = new System.Drawing.Size(57, 17);
            this.radioButton1.TabIndex = 6;
            this.radioButton1.TabStop = true;
            this.radioButton1.Text = "Поиск";
            this.radioButton1.UseVisualStyleBackColor = true;
            this.radioButton1.CheckedChanged += new System.EventHandler(this.radioButton1_CheckedChanged);
            // 
            // radioButton2
            // 
            this.radioButton2.AutoSize = true;
            this.radioButton2.Location = new System.Drawing.Point(73, 512);
            this.radioButton2.Name = "radioButton2";
            this.radioButton2.Size = new System.Drawing.Size(64, 17);
            this.radioButton2.TabIndex = 7;
            this.radioButton2.TabStop = true;
            this.radioButton2.Text = "Отмена";
            this.radioButton2.UseVisualStyleBackColor = true;
            this.radioButton2.CheckedChanged += new System.EventHandler(this.radioButton2_CheckedChanged);
            // 
            // FindtextBox
            // 
            this.FindtextBox.Location = new System.Drawing.Point(179, 489);
            this.FindtextBox.Name = "FindtextBox";
            this.FindtextBox.Size = new System.Drawing.Size(206, 20);
            this.FindtextBox.TabIndex = 8;
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(772, 479);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(138, 38);
            this.button2.TabIndex = 9;
            this.button2.Text = "Выполнить событие";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Visible = false;
            this.button2.Click += new System.EventHandler(this.button2_Click_1);
            // 
            // button3
            // 
            this.button3.Location = new System.Drawing.Point(593, 479);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(139, 38);
            this.button3.TabIndex = 10;
            this.button3.Text = "Перевод в другой класс";
            this.button3.UseVisualStyleBackColor = true;
            this.button3.Visible = false;
            this.button3.Click += new System.EventHandler(this.button3_Click);
            // 
            // Main
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1184, 569);
            this.Controls.Add(this.button3);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.FindtextBox);
            this.Controls.Add(this.radioButton2);
            this.Controls.Add(this.radioButton1);
            this.Controls.Add(this.menuStrip1);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.dataGridView1);
            this.Name = "Main";
            this.Text = "Главная";
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            this.contextMenuStrip1.ResumeLayout(false);
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.ContextMenuStrip contextMenuStrip1;
        private System.Windows.Forms.ToolStripMenuItem событияToolStripMenuItem;
        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStripMenuItem просмотрToolStripMenuItem1;
        private System.Windows.Forms.ToolStripMenuItem учителяToolStripShow;
        private System.Windows.Forms.ToolStripMenuItem учащиесяToolStripShow;
        private System.Windows.Forms.ToolStripMenuItem событияToolStripShow;
        private System.Windows.Forms.ToolStripMenuItem добавитьToolStripMenuItem1;
        private System.Windows.Forms.ToolStripMenuItem учителяToolStripAdd;
        private System.Windows.Forms.ToolStripMenuItem учащегосяToolStripAdd;
        private System.Windows.Forms.ToolStripMenuItem событиеToolStripAdd;
        private System.Windows.Forms.ToolStripMenuItem успеваемостьToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem изменитьToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem учителяToolStripChange;
        private System.Windows.Forms.ToolStripMenuItem учащегосяToolStripChange;
        private System.Windows.Forms.ToolStripMenuItem событиеToolStripChange;
        private System.Windows.Forms.RadioButton radioButton1;
        private System.Windows.Forms.RadioButton radioButton2;
        private System.Windows.Forms.TextBox FindtextBox;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.ToolStripMenuItem рассписаниеToolStrip;
        private System.Windows.Forms.ToolStripMenuItem заявкаНаКурсыToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem заявкаНаОздоровлениеДетейЛьготныхКатегорийToolStripMenuItem;
        private System.Windows.Forms.Button button3;
    }
}

