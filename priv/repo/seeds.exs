# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Blog.Repo.insert!(%Blog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Blog.{Repo, Posts.Post}

phoenix = %Post{title: "Proenix Framework", description: "Framework web para desenvolviemtno Elixir."}
postgre = %Post{title: "PostgreSQL", description: "Banco de dados relacionao opensource"}

Blog.Repo.insert!(phoenix)
Blog.Repo.insert!(postgre)
