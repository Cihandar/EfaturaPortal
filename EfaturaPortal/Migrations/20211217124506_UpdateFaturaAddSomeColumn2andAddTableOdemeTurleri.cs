using Microsoft.EntityFrameworkCore.Migrations;

namespace EfaturaPortal.Migrations
{
    public partial class UpdateFaturaAddSomeColumn2andAddTableOdemeTurleri : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "OdemeSekli",
                table: "Faturas",
                newName: "OdemeSekliKodu");

            migrationBuilder.AddColumn<string>(
                name: "OdemeSekliAdi",
                table: "Faturas",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "OdemeTurleris",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Kodu = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Adi = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_OdemeTurleris", x => x.Id);
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "OdemeTurleris");

            migrationBuilder.DropColumn(
                name: "OdemeSekliAdi",
                table: "Faturas");

            migrationBuilder.RenameColumn(
                name: "OdemeSekliKodu",
                table: "Faturas",
                newName: "OdemeSekli");
        }
    }
}
