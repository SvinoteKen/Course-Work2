using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Wordprocessing;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

namespace CourseWork
{
    class ToDoc
    {
        private void CreateTable(string fileName, string[,] items)
        {
            using (WordprocessingDocument doc = WordprocessingDocument.Open(fileName, true))
            {
                Table table = new Table();

                TableProperties tblProp = new TableProperties(
                    new TableBorders(
                        new TopBorder()
                        {
                            Val =
                            new EnumValue<BorderValues>(BorderValues.BasicThinLines),
                            Size = 4
                        },
                        new BottomBorder()
                        {
                            Val =
                            new EnumValue<BorderValues>(BorderValues.BasicThinLines),
                            Size = 4
                        },
                        new LeftBorder()
                        {
                            Val =
                            new EnumValue<BorderValues>(BorderValues.BasicThinLines),
                            Size = 4
                        },
                        new RightBorder()
                        {
                            Val =
                            new EnumValue<BorderValues>(BorderValues.BasicThinLines),
                            Size = 4
                        },
                        new InsideHorizontalBorder()
                        {
                            Val =
                            new EnumValue<BorderValues>(BorderValues.BasicThinLines),
                            Size = 4
                        },
                        new InsideVerticalBorder()
                        {
                            Val =
                            new EnumValue<BorderValues>(BorderValues.BasicThinLines),
                            Size = 4
                        }
                    )
                );

                table.AppendChild<TableProperties>(tblProp);
                for (var i = 0; i <= items.GetUpperBound(0); i++)
                {
                    var tr = new TableRow();
                    for (var j = 0; j <= items.GetUpperBound(1); j++)
                    {
                        var tc = new TableCell();
                        tc.Append(new Paragraph(new Run(new Text(items[i, j]))));

                        tc.Append(new TableCellProperties(
                            new TableCellWidth { Type = TableWidthUnitValues.Auto }));

                        tr.Append(tc);
                    }
                    table.Append(tr);
                }
                doc.MainDocumentPart.Document.Body.Append(table);
            }
        }
        public void CreateWordprocessingDocument(string filepath, int count, string[,] items)
        {
            string text;
            using (WordprocessingDocument wordDocument = WordprocessingDocument.Create(filepath, WordprocessingDocumentType.Document))
            {
                MainDocumentPart mainPart = wordDocument.AddMainDocumentPart();
                mainPart.Document = new Document();
                Body body = mainPart.Document.AppendChild(new Body());
                Paragraph para = body.AppendChild(new Paragraph());
                Run run = para.AppendChild(new Run());
                if (count == 0) { text = "Заявка на курсы"; } else { text = "Заявка на оздоровление детей льготных категорий"; }
                run.AppendChild(new Text(text));
            }
            CreateTable(filepath, items);
        }
        public bool IsFileInUse(string fileFullPath)
        {
            if (System.IO.File.Exists(fileFullPath))
            {
                try
                {
                    using (FileStream fileStream = File.OpenWrite(fileFullPath))
                    {
                        if (fileStream == null)
                            return true;
                    }
                    return false;
                }
                catch
                {
                    return true;
                }
            }
            return false;
        }
    }
}
