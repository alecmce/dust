#!/usr/bin/env ruby

class Munit

  def test_all
    system 'haxelib run munit test -js -as3 -browser firefox'
  end

  def test_as3
    system 'haxelib run munit test -as3 -browser firefox'
  end

  def test_js
    system 'haxelib run munit test -js -browser firefox'
  end

  def test_cpp
    system 'haxelib run munit test -cpp'
  end

end