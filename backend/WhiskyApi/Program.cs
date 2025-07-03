using Microsoft.EntityFrameworkCore;
using WhiskyApi.Models;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddDbContext<WhiskyContext>(options =>
    options.UseNpgsql(builder.Configuration.GetConnectionString("WhiskyDb")));

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<WhiskyContext>();
    db.Database.EnsureCreated();
    if (!db.TastingNotes.Any())
    {
        db.TastingNotes.AddRange(
            new TastingNote { Distillery = "Ardbeg", Age = 10, Nose = "Smoky", Palate = "Peaty", Finish = "Long", Score = 90, Taster = "System" },
            new TastingNote { Distillery = "Glenlivet", Age = 12, Nose = "Fruity", Palate = "Smooth", Finish = "Medium", Score = 85, Taster = "System" }
        );
        db.SaveChanges();
    }
}

app.MapGet("/notes", async (WhiskyContext db) =>
    await db.TastingNotes.ToListAsync());

app.MapPost("/notes", async (WhiskyContext db, TastingNote note) =>
{
    db.TastingNotes.Add(note);
    await db.SaveChangesAsync();
    return Results.Created($"/notes/{note.Id}", note);
});

app.Run();
