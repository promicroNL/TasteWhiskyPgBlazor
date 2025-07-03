using Microsoft.EntityFrameworkCore;

namespace WhiskyApi.Models
{
    public class WhiskyContext : DbContext
    {
        public WhiskyContext(DbContextOptions<WhiskyContext> options) : base(options) {}
        public DbSet<TastingNote> TastingNotes => Set<TastingNote>();
    }
}
