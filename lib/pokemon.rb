require 'pry-byebug'

class Pokemon

  attr_accessor :id, :name, :type, :db, :hp

  def initialize(name, hp=nil)
    @name = name
    @hp = hp
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
    result.hp == nil ? result.hp = 60 : result.hp = hp
    result
  end

  def alter_hp(new_hp, db)
    binding.pry
    # query = "UPDATE pokemon SET hp = #{new_hp} WHERE pokemon.id = #{self.id};"

    #### This seems to work in pry...
    values = [new_hp, self.id]
    db.execute("UPDATE pokemon SET hp = ? WHERE id = ?;", values)
    self.hp = new_hp
    self
  end

end
