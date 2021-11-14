using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace EfaturaPortal.Migrations
{
    public partial class UpdateSeriNumaralarEditSablon : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Sablon",
                table: "SeriNumaralars");

            migrationBuilder.AddColumn<string>(
                name: "SablonDosyaAdi",
                table: "SeriNumaralars",
                nullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "SablonDosyaAdi",
                table: "SeriNumaralars");

            migrationBuilder.AddColumn<byte[]>(
                name: "Sablon",
                table: "SeriNumaralars",
                nullable: true);
        }
    }
}
