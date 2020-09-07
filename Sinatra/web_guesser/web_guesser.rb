require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(101)
@@guesses_remaining = 5

get '/' do
  guess = params['guess'].to_i
  isCheater = params['cheat']
  msg = !params['guess'] ? 'Guess a number!' : check_guess(guess, isCheater)
  col = assign_colour(guess)
  erb :index, :locals => {:number => SECRET_NUMBER, :message => msg, :colour => col}
end

def check_guess(guess, isCheater)
  if guess == SECRET_NUMBER || isCheater
    msg = "You got it right! The SECRET NUMBER is #{SECRET_NUMBER}"
  elsif guess > SECRET_NUMBER + 5
    msg = "Way too high!"
  elsif guess > SECRET_NUMBER
    msg = "Too high!"
  elsif guess < SECRET_NUMBER - 5
    msg = "Way too low!"
  elsif guess < SECRET_NUMBER
    msg = "Too low!"
  end
end

def assign_colour(guess)
  if guess > SECRET_NUMBER + 5 || guess < SECRET_NUMBER - 5
    col = 'red'
  elsif guess > SECRET_NUMBER || guess < SECRET_NUMBER
    col = 'pink'
  else 
    col = 'green'
  end
end