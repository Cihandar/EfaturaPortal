using Microsoft.EntityFrameworkCore.Migrations;

namespace EfaturaPortal.Migrations
{
    public partial class updatedovizaddOncelik2 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "FaturaSenaryo",
                table: "Faturas");

            migrationBuilder.DropColumn(
                name: "FaturaTipi",
                table: "Faturas");

            //migrationBuilder.RenameColumn(
            //    name: "faturaTipi",
            //    table: "Faturas",
            //    newName: "FaturaTipi");

            //migrationBuilder.RenameColumn(
            //    name: "faturaSenaryo",
            //    table: "Faturas",
            //    newName: "FaturaSenaryo");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "FaturaTipi",
                table: "Faturas",
                newName: "faturaTipi");

            migrationBuilder.RenameColumn(
                name: "FaturaSenaryo",
                table: "Faturas",
                newName: "faturaSenaryo");

            migrationBuilder.AddColumn<string>(
                name: "FaturaSenaryo",
                table: "Faturas",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "FaturaTipi",
                table: "Faturas",
                type: "nvarchar(max)",
                nullable: true);
        }
    }
}
