---
title: Into Adventure - Part 4 - Chaining
date: 2015-09-09 17:00:00
---



# Ruby
class ThreeDObject
  def initialize(x, y, z)
    @x = x
    @y = y
    @z = z
  end
      
  def translate(x, y, z)
    # we translate the object
    self
  end

  def rotate(x, y, z)
    # we rotate the object
    self
  end

  def scale(x, y, z)
    # we scale the object
    self
  end
  
end

player = ThreeDObject.new(5,4,3)
player.scale(1,1,1).translate(1,0,0).rotate(90,0,0)




# Ruby
class Player
  def initialize (weapon)
    @weapon = weapon
  end
  
  def AttackWithWeapon
    @weapon
  end
end

class Weapon
  def initialize (damage)
    @damage = damage
  end

  def getDamage
    @damage
  end
end

sword = Weapon.new(5)
player = Player.new(sword)
puts player.AttackWithWeapon().getDamage()

 But what about damaging a monster?


# Ruby
class Monster
  def initialize (life)
    @life = life
  end
  
  def receiveDamage (damage)
    @life = @life - damage
  end
end

monster = Monster.new(10)
monster.receiveDamage(player.AttackWithWeapon().getDamage())



# Elixir
defmodule Player do
	defstruct weapon: nil
end

defmodule Weapon do
	defstruct damage: 0
end

defmodule Attack do

	def attackWithWeapon do
		weapon = %Weapon{damage: 5}
		player = %Player{weapon: weapon}

		IO.puts player.weapon.damage
	end
end

Attack.attackWithWeapon
(% endhighlight %}

So far similar as to Ruby. Isn't it?

But what about that proposition with monster? How do I achieve that?

Enter the pipe operator: |>


defmodule Monster do
	defstruct life: 0

	def receiveDamage(damage, monster=%Monster{}) do
		%Monster{monster|life: monster.life-damage}
	end
end

defmodule Demonstration do
	def demo do
		weapon = %Weapon{damage: 5}
v		player = %Player{weapon: weapon}
		monster = %Monster{life: 17}
		monster = player.weapon.damage |> Monster.receiveDamage monster
		IO.puts monster.life
	end
end

Demonstration.demo


What about generalizing that pipe operator?


# Elixir
defmodule Chaining do
		def stripchars(str, chars) do
		String.replace str, ~r/"|#{Enum.join(String.split(chars, ""), "|")}"/, ""
	end

	def isAllUppercase(str) do
		upper = (stripchars str, "123456789,") |> String.upcase
		upper |> String.strip |> String.length > 0 && stripchars(str, "1234567890,") == upper
	end
end

(Chaining.isAllUppercase "Is it?") |> IO.puts

