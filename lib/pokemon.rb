require 'pry-byebug'

class Pokemon

  attr_accessor :id, :name, :type, :db, :hp

  def initialize(name, hp=nil)
    @name = name
    @hp = 60
  end

  def self.save(name, type, db)
    values = [name, type]
    db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", values)
  end

  def self.find(id, db)
    query = "SELECT * FROM pokemon WHERE pokemon.id = #{id};"
    # binding.pry
    result = new db.execute(query).flatten[1]
    result.id = db.execute(query).flatten[0]
    result.type = db.execute(query).flatten[2]
    result.hp = db.execute(query).flatten[3]
    result
  end

  def alter_hp(new_hp, db)
    # binding.pry
    query = <<-SQL
    UPDATE pokemon
    SET hp = ?
    WHERE id = ?;
    SQL

    values = [new_hp, self.id]
    db.execute(query, new_hp, self.id)
    self.hp = new_hp
    self
  end

end
