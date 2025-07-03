using System;
using System.ComponentModel.DataAnnotations;

namespace WhiskyApi.Models
{
    public class TastingNote
    {
        public int Id { get; set; }
        [Required]
        public string Distillery { get; set; } = string.Empty;
        public int Age { get; set; }
        public string? Bottling { get; set; }
        public string Nose { get; set; } = string.Empty;
        public string Palate { get; set; } = string.Empty;
        public string Finish { get; set; } = string.Empty;
        public int Score { get; set; }
        public string? Overall { get; set; }
        public string Taster { get; set; } = string.Empty;
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    }
}
