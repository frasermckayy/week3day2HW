require("pry-byebug")
require_relative("../models/space_cowboy.rb")

Bounty.delete_all()

bounty1 = Bounty.new({
  "name" => "Fraser",
  "species" => "Elvish",
  "bounty_value" => 500,
  "danger_level" => "high",
  "homeworld" => "Mars"
  })

  bounty1.save()

  bounty2 = Bounty.new({
    "name" => "Scott",
    "species" => "Dwarf",
    "bounty_value" => 5,
    "danger_level" => "low",
    "homeworld" => "Uranus"
    })

    bounty2.save()

    binding.pry
    nil
