using Microsoft.EntityFrameworkCore.Migrations;

namespace EfaturaPortal.Migrations
{
    public partial class UpdateAppUserAddAdSoyad : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "AdSoyad",
                table: "AspNetUsers",
                nullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "AdSoyad",
                table: "AspNetUsers");
        }
    }
}
