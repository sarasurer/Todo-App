using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace ToDoCervidae.Models
{
    public class ToDo
    {

        [Key]
        public int ID { get; set; }

        [Column(TypeName = "nvarchar(40)")]
        public string Title { get; set; }

        [Column(TypeName = "date")]
        public DateTime CreateDate { get; set; } = DateTime.Now;

        [Column(TypeName = "nvarchar(40)")]
        public bool IsCompleted { get; set; }

        [Column(TypeName = "nvarchar(40)")]
        public string Detail { get; set; }

        [Column(TypeName = "nvarchar(40)")]
        public string Priority { get; set; }
    }

}
