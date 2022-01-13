using Microsoft.EntityFrameworkCore.Migrations;

namespace EfaturaPortal.Migrations
{
    public partial class SomeoneUpdateModel : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "IstisnaKodlariId",
                table: "FaturaSatirs",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "OlcuBirimleriId",
                table: "FaturaSatirs",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_FaturaSatirs_IstisnaKodlariId",
                table: "FaturaSatirs",
                column: "IstisnaKodlariId");

            migrationBuilder.CreateIndex(
                name: "IX_FaturaSatirs_OlcuBirimleriId",
                table: "FaturaSatirs",
                column: "OlcuBirimleriId");

            migrationBuilder.AddForeignKey(
                name: "FK_FaturaSatirs_IstisnaKodlaris_IstisnaKodlariId",
                table: "FaturaSatirs",
                column: "IstisnaKodlariId",
                principalTable: "IstisnaKodlaris",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_FaturaSatirs_OlcuBirimleris_OlcuBirimleriId",
                table: "FaturaSatirs",
                column: "OlcuBirimleriId",
                principalTable: "OlcuBirimleris",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_FaturaSatirs_IstisnaKodlaris_IstisnaKodlariId",
                table: "FaturaSatirs");

            migrationBuilder.DropForeignKey(
                name: "FK_FaturaSatirs_OlcuBirimleris_OlcuBirimleriId",
                table: "FaturaSatirs");

            migrationBuilder.DropIndex(
                name: "IX_FaturaSatirs_IstisnaKodlariId",
                table: "FaturaSatirs");

            migrationBuilder.DropIndex(
                name: "IX_FaturaSatirs_OlcuBirimleriId",
                table: "FaturaSatirs");

            migrationBuilder.DropColumn(
                name: "IstisnaKodlariId",
                table: "FaturaSatirs");

            migrationBuilder.DropColumn(
                name: "OlcuBirimleriId",
                table: "FaturaSatirs");
        }
    }
}
