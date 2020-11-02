alias Theme01.Repo
alias Theme01.Management.User

Repo.insert! %User{
    username: "Alex",
    email: "alex@epitech.eu",
    role: "admin",
    password_hash: "$2b$12$mlvT2coHZXICY99gBObwCOwRQC/NFgCuBRQ3GxGgn.wsvzM4Q83y2" # testAdmin06
}

Repo.insert! %User{
    username: "Marcel",
    email: "marcel@epitech.eu",
    role: "employee",
    password_hash: "$2b$12$p5oo/fnf2fZl8wEiPtZCBehHTsTvSbVz9qGlx.ehSU241R5jDW6XG" # testEmployee06
}

Repo.insert! %User{
    username: "Nico",
    email: "nico@epitech.eu",
    role: "manager",
    password_hash: "$2b$12$Pbq2d3IeaDiGjeddrjEWmO9LGLN8p8TewUbDmUSvp7HoIppNZgHgu" # testManager06
}

Repo.insert! %User{
    username: "Kenny",
    email: "kenny@epitech.eu",
    role: "employee",
    password_hash: "$2b$12$p5oo/fnf2fZl8wEiPtZCBehHTsTvSbVz9qGlx.ehSU241R5jDW6XG" # testEmployee06
}
