require("pg")

class Bounty

  attr_reader :id
  attr_accessor :name, :bounty_value, :danger_level, :homeworld

  def initialize(options)
    @id = options["id"].to_i
    @name = options["name"]
    @bounty_value = options["bounty_value"]
    @danger_level = options["danger_level"]
    @homeworld = options["homeworld"]
  end

  def save()
    db = PG.connect({dbname: "space_cowboys", host: "localhost"})
    sql = "INSERT INTO bounties (name, bounty_value, danger_level, homeworld) VALUES ($1, $2, $3, $4)
    RETURNING id;"
    values = [@name, @bounty_value, @danger_level, @homeworld]
    db.prepare("save", sql)
    result = db.exec_prepared("save", values)
    db.close()
    @id = result[0]["id"].to_i
  end

  def delete()
    db = PG.connect({dbname: "space_cowboys", host: "localhost"})
    sql = "DELETE FROM bounties WHERE id = $1"
    values = [@id]
    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close()
  end

  def update()
    db = PG.connect({ dbname: "space_cowboys" , host: "localhost"})
    sql = "UPDATE bounties SET (name, bounty_value, danger_level, homeworld) = ($1, $2, $3, $4)
    WHERE id = $5"
    values = [@name, @bounty_value, @danger_level, @homeworld, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def Bounty.all()
    db = PG.connect({dbname: "space_cowboys" , host: "localhost"})
    sql = "SELECT * FROM bounties"
    db.prepare("all", sql)
    space_cowboys = db.exec_prepared("all")
    db.close()
    return space_cowboys.map {|space_cowboy| Bounty.new(space_cowboy)}
  end


  def Bounty.delete_all()
    db = PG.connect({dbname: "space_cowboys" , host: "localhost"})
    sql = "DELETE FROM bounties"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def Bounty.find_by_name(name)
    db = PG.connect({dbname: "space_cowboys" , host: "localhost"})
    sql = "SELECT * FROM bounties WHERE name = $1"
    values = [name]
    db.prepare("find_by_name", sql)
    space_cowboy_bounty = db.exec_prepared("find_by_name", values)
    db.close()
    return  Bounty.new(space_cowboy_bounty.first())
  end

  def Bounty.find_by_id(id)
    db = PG.connect({dbname: "space_cowboys" , host: "localhost"})
    sql = "SELECT * FROM bounties WHERE id = $1"
    values = [@id]
    db.prepare("find_by_id", sql)
    result = db.exec_prepared("find_by_id", values)
    db.close()
    return Bounty.new(result.first())
  end
end
