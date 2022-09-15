using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace ToDoCervidae.Migrations
{
    public partial class InitialCreate : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "ToDoList",
                columns: table => new
                {
                    ID = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Title = table.Column<string>(type: "nvarchar(40)", nullable: false),
                    CreateDate = table.Column<DateTime>(type: "date", nullable: false),
                    IsCompleted = table.Column<bool>(type: "nvarchar(40)", nullable: false),
                    Detail = table.Column<string>(type: "nvarchar(40)", nullable: false),
                    Priority = table.Column<string>(type: "nvarchar(40)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ToDoList", x => x.ID);
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "ToDoList");
        }
    }
}
