alias Theme01.Repo
alias Theme01.Management.WorkingTime

Repo.insert! %WorkingTime{
    start: %NaiveDateTime{day: 12, hour: 14, minute: 0, month: 4, second: 0, year: 2020},
    end: %NaiveDateTime{day: 14, hour: 2, minute: 21, month: 4, second: 56, year: 2020},
    user_id: 2
}

Repo.insert! %WorkingTime{
    start: %NaiveDateTime{day: 2, hour: 14, minute: 0, month: 4, second: 0, year: 2020},
    end: %NaiveDateTime{day: 12, hour: 19, minute: 51, month: 8, second: 9, year: 2020},
    user_id: 1
}

Repo.insert! %WorkingTime{
    start: %NaiveDateTime{day: 8, hour: 7, minute: 3, month: 4, second: 0, year: 2020},
    end: %NaiveDateTime{day: 8, hour: 19, minute: 51, month: 4, second: 19, year: 2020},
    user_id: 3
}
