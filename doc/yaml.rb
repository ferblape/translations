# coding: UTF-8

require 'yaml'

class Hash
  def rmerge(other_hash)
    r = {}
    merge(other_hash)  do |key, oldval, newval| 
      r[key] = oldval.class == self.class ? oldval.rmerge(newval) : newval
    end
  end
end

class Str
  attr_accessor :key, :value
  
  def to_hash
    arr = key.split(".")
    arr.reverse.inject(value) { |a, n| { n => a } }
  end
end

s = Str.new
s.key = "es.hello.this.world"
s.value = "hola mundo"
s = s.to_hash

q = Str.new
q.key = "es.hello.man"
q.value = "hola hombre"
q = q.to_hash

p = Str.new
p.key = "es.hello.that.planet"
p.value = "hola ese planéta!"
p = p.to_hash

x = Str.new
x.key = "es.bye.world"
x.value = "chao mundo"
x = x.to_hash

@hash = Hash.new

[q,p,x].each do |r|
  @hash = @hash.rmerge r
end


# hash = q.rmerge s
# hash = hash.rmerge p
# hash = hash.rmerge q



puts YAML::dump(@hash)
  
  
