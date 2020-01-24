var str = "aRjeMU9YWuP5aS8trretKALXhcjBpQ7xY0TJBwq8Dhl1sw3GkRX5VxeyzfqDtqiwAueS9rHbA5PNzr292iE6D1DMwbqLXErMVuhOOzREtZ9eL1FSFTBw6PCVnZmWUtQl3vfiWMaGOdg3gmkQjPLBWqabOcgsufJFdUID3VWrGUo4mT9Bscuq9WZ4Ey6itIMM5InH3mjb"
var shuffled = str.split('').sort(function () {
  return 0.5 - Math.random()
}).join('');

console.log(shuffled)

