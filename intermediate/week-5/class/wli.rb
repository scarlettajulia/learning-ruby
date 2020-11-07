class WLI
  attr_reader :names
  def initialize(names) 
    @names = names
  end
  
  def likes
    return "No one likes this" if names.empty? 
    return "#{ names[0] } likes this" if names.length == 1
    return "#{ names[0] } and #{ names[1]} like this" if names.length == 2
    first_two_people = names.slice(0, 2).join(", ")
    remained_people = names.length - 2 
    mentioned_last = remained_people == 1 ? names[2] : remained_people.to_s
    "#{ first_two_people } and #{ mentioned_last } like this"
  end
end