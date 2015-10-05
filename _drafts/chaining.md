---
title: Into Adventure - Part 2 - Chaining
date: 2015-09-09 17:00:00
---

As a C# developer, the first time I found the term Fluent Style was with the introduction of LINQ on .Net 3.5

{% highlight C# %}
// C#
class MyTestObject
{
    public String Name {get; set;}
    public int Value {get; set;}
}

class Manipulator
{
    public List<MyTestObject> TestObjects {get; set;}
 
    public MyTestObject DoSomeOperations ()
    {
        this.TestObjects.Where(x => x.Name != "").First(x => x.Value > 5)
    }
}
{% endhighlight %}
You can see that upon TestObjects (a *List*, which inherits from *IEnumerable*)  we do an operation, **Where**, that returns an *IEnumerable*, upon which we do another operation, **First**, that will return a single object.

The idea itself has been present from the beginning in C#. Due to the String class being inmutable, you were forced to chain method calls if you wanted to do multiple operations to a string.

{% highlight C# %}
public String DoSomething (String originalString)
{
    return originalString.Trim().Replace("a", " ").Replace("d", "e);
}
{% endhighlight %}

Of course, you can do this on other OO languages

{% highlight Ruby %}
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
{% endhighlight%}

You can even combine returning different objects to chain several method calls.

{% highlight Ruby %}
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
{% endhighlight %}

But what about damaging a monster?

{% highlight Ruby %}
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
{% endhighlight %}

This is where the chain breaks. **getDamage()** returns an integer, and there is no way to chain that result into monster. This is due to the way that you need to return  the object unto which you are going to act next.


This idea, works differently on FP languages.

{% highlight Elixir %}
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
{% endhighlight %}

So far similar as to Ruby. Isn't it? Here we are using structures and the member returned is part of another structure for which we retrieve a member

But what about that proposition with monster? How do I achieve that?

Enter the pipe operator: \|> (on Elixir and F#, Clojure has the reader macros -> and ->>)

{% highlight Elixir %}
# Elixir
defmodule Monster do
    defstruct life: 0

    def receiveDamage(damage, monster=%Monster{}) do
         %Monster{monster|life: monster.life-damage}
    end
endx

defmodule Demonstration do
    def demo do
        weapon = %Weapon{damage: 5}
        player = %Player{weapon: weapon}
        monster = %Monster{life: 17}
        monster = player.weapon.damage |> Monster.receiveDamage monster
       IO.puts monster.life
    end
end

Demonstration.demo
{% endhighlight %}

What the pipe operator is doing in this case is pass the result on the left as the first parameter on the function on the right.

The pipe operator becomes a generalization of the Fluent Style. While in OOP languages you do a call on the return value (the context), on FP languages you pass the return value (the context) as parameter to the next function. With this behaviour, what you can achieve is to chain far more easily

Looking at the chaining of strings, for example we get this:

{% highlight Elixir %}
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
{% endhighlight %}

Of course, on FP working with lists/sequences is the most natural thing to do. And this where chaining, as done on FP languages, shines.

{% highlight FSharp %}
{% endhighlight %}
