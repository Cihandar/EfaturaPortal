using Microsoft.EntityFrameworkCore.Migrations;

namespace EfaturaPortal.Migrations
{
    public partial class UpdateFaturaAddSaat : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateIndex(
                name: "IX_FaturaSatirs_FaturaId",
                table: "FaturaSatirs",
                column: "FaturaId");

            migrationBuilder.CreateIndex(
                name: "IX_Faturas_CarilerId",
                table: "Faturas",
                column: "CarilerId");

            migrationBuilder.CreateIndex(
                name: "IX_Faturas_SeriNumaralarId",
                table: "Faturas",
                column: "SeriNumaralarId");

            migrationBuilder.AddForeignKey(
                name: "FK_Faturas_Carilers_CarilerId",
                table: "Faturas",
                column: "CarilerId",
                principalTable: "Carilers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Faturas_SeriNumaralars_SeriNumaralarId",
                table: "Faturas",
                column: "SeriNumaralarId",
                principalTable: "SeriNumaralars",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_FaturaSatirs_Faturas_FaturaId",
                table: "FaturaSatirs",
                column: "FaturaId",
                principalTable: "Faturas",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Faturas_Carilers_CarilerId",
                table: "Faturas");

            migrationBuilder.DropForeignKey(
                name: "FK_Faturas_SeriNumaralars_SeriNumaralarId",
                table: "Faturas");

            migrationBuilder.DropForeignKey(
                name: "FK_FaturaSatirs_Faturas_FaturaId",
                table: "FaturaSatirs");

            migrationBuilder.DropIndex(
                name: "IX_FaturaSatirs_FaturaId",
                table: "FaturaSatirs");

            migrationBuilder.DropIndex(
                name: "IX_Faturas_CarilerId",
                table: "Faturas");

            migrationBuilder.DropIndex(
                name: "IX_Faturas_SeriNumaralarId",
                table: "Faturas");
        }
    }
}
