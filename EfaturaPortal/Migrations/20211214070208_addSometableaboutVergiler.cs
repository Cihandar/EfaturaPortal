using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace EfaturaPortal.Migrations
{
    public partial class addSometableaboutVergiler : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "FaturaSatirKdvlers",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    FaturaSatirId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    Kodu = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Adi = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    KdvOran = table.Column<double>(type: "float", nullable: false),
                    KdvTutar = table.Column<double>(type: "float", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_FaturaSatirKdvlers", x => x.Id);
                    table.ForeignKey(
                        name: "FK_FaturaSatirKdvlers_FaturaSatirs_FaturaSatirId",
                        column: x => x.FaturaSatirId,
                        principalTable: "FaturaSatirs",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "VergiKodlaris",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Kodu = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Adi = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Kisaltma = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_VergiKodlaris", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_FaturaSatirKdvlers_FaturaSatirId",
                table: "FaturaSatirKdvlers",
                column: "FaturaSatirId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "FaturaSatirKdvlers");

            migrationBuilder.DropTable(
                name: "VergiKodlaris");
        }
    }
}
