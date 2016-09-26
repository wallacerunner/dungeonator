class Character
  attr_reader :info

  def initialize
    @info = {
      :name => '',
      :strength => [],
      :stamina => [],
      :dexterity => [],
      :agility => [],
      :intelligence => [],
      :current_hp => 0,
      :max_hp => 0,
      :unarmed_combat => [],
      :armed_combat => [],
      :projectile_combat => [],
      :magic_combat => [],
      :combat_defence => [],
      :magic_defence => [],
      :current_xp => 0,
      :total_xp => 0,
      :current_gold => 0,
      :total_gold => 0,
      :location_x => 0,
      :location_y => 0
    }
  end

end
