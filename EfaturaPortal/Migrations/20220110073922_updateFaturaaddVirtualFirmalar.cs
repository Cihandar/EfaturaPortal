using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace EfaturaPortal.Migrations
{
    public partial class updateFaturaaddVirtualFirmalar : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<Guid>(
                name: "FirmalarId",
                table: "Faturas",
                type: "uniqueidentifier",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Faturas_FirmalarId",
                table: "Faturas",
                column: "FirmalarId");

            migrationBuilder.AddForeignKey(
                name: "FK_Faturas_Firmalars_FirmalarId",
                table: "Faturas",
                column: "FirmalarId",
                principalTable: "Firmalars",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Faturas_Firmalars_FirmalarId",
                table: "Faturas");

            migrationBuilder.DropIndex(
                name: "IX_Faturas_FirmalarId",
                table: "Faturas");

            migrationBuilder.DropColumn(
                name: "FirmalarId",
                table: "Faturas");
        }
    }
}
