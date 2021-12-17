using Microsoft.EntityFrameworkCore.Migrations;

namespace EfaturaPortal.Migrations
{
    public partial class UpdateFaturaAddSomeColumn : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<double>(
                name: "DigerVergilerToplam",
                table: "Faturas",
                type: "float",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.AddColumn<double>(
                name: "TevkifatToplam",
                table: "Faturas",
                type: "float",
                nullable: false,
                defaultValue: 0.0);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "DigerVergilerToplam",
                table: "Faturas");

            migrationBuilder.DropColumn(
                name: "TevkifatToplam",
                table: "Faturas");
        }
    }
}
