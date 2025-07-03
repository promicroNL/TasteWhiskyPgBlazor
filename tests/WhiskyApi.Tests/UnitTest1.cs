using WhiskyApi.Models;

namespace WhiskyApi.Tests;

public class UnitTest1
{
    [Fact]
    public void Model_CanInstantiate()
    {
        var note = new TastingNote { Distillery = "Ardbeg", Age = 10 };
        Assert.Equal("Ardbeg", note.Distillery);
    }
}
