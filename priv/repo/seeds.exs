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
alias Blog.{Accounts, Accounts.User, Posts, Posts.Post}

user = %{
  email: "viana.mail@gmail.com",
  first_name: nil,
  image:
    "https://lh3.googleusercontent.com/a-/AOh14GicsQvhdjupXGnxS-sHjwX30J0WHzaRBQViXwzcVw=s96-c",
  last_name: nil,
  provider: "google",
  token:
    "ya29.a0ARrdaM_Wl6LwzQLHH-flu3vmbeaStictJ1LI42QZN-sqGQYjVOGu180Rc8fd7SpvZ59N2pR2OcVLDyDjO-5zHy1ohHVt8WB0DPfJ4AF2BcQb78zSV2bY20gNfhxYAkKy760DzvMDvqLqSYTuPRJ-j82vikku"
}

user_2 = %{
  email: "viouyouy@gmail.com",
  first_name: nil,
  image:
    "https://lh3.go4444ogleusercontent.com/a-/AOh14GicsQvhdjupXGnxS-sHjwX30J0WHzaRBQViXwzcVw=s96-c",
  last_name: nil,
  provider: "google",
  token:
    "ya29.a0hlhljhljhwzQLHH-flu3vmbeaStictJ1LI42QZN-sqGQYjVOGu180Rc8fd7SpvZ59N2pR2OcVLDyDjO-5zHy1ohHVt8WB0DPfJ4AF2BcQb78zSV2bY20gNfhxYAkKy760DzvMDvqLqSYTuPRJ-j82vikku"
}

post = %{title: "PostgreSQL", description: "Banco de dados relacionao opensource"}

{:ok, user} = Blog.Accounts.create_user(user)
{:ok, user_2} = Blog.Accounts.create_user(user_2)
{:ok, postgre} = Posts.create_post(user, post)
