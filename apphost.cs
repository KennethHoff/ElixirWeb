#:package CommunityToolkit.Aspire.Hosting.PostgreSQL.Extensions@13.0.0-beta.435
#:sdk Aspire.AppHost.Sdk@13.0.0

var builder = DistributedApplication.CreateBuilder(args);
var postgres = builder.AddPostgres("postgres").WithDbGate();
var db = postgres.AddDatabase("db");
var mix = builder
    .AddExecutable("elixir", "mix", "./helpdesk/", args: ["phx.server"])
    .WithEnvironment("PG_URL", db.Resource.UriExpression)
    .WithHttpEndpoint(env: "PORT")
    .WaitFor(db);

builder.Build().Run();
