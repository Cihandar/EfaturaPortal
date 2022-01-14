using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace EfaturaPortal.Migrations
{
    public partial class SomeoneUpdateModel2 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
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

            migrationBuilder.CreateIndex(
                name: "IX_Faturas_FirmaId",
                table: "Faturas",
                column: "FirmaId");

            migrationBuilder.AddForeignKey(
                name: "FK_Faturas_Firmalars_FirmaId",
                table: "Faturas",
                column: "FirmaId",
                principalTable: "Firmalars",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Faturas_Firmalars_FirmaId",
                table: "Faturas");

            migrationBuilder.DropIndex(
                name: "IX_Faturas_FirmaId",
                table: "Faturas");

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
    }
}
